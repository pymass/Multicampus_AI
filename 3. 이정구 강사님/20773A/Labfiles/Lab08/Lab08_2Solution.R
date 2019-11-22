# EX 1 - Integration with Pig

# Review the pig script before starting
# Set the loginName variable


# Change the following as appropriate
loginName = "studentnn"

context <- RxHadoopMR(sshUsername = loginName, 
                      sshHostname = "LON-HADOOP",
                      consoleOutput = TRUE)

rxSetComputeContext(context, wait = TRUE)

# Copy FlightDelayData.csv to HDFS (/user/RevoShare/loginName)
rxHadoopRemove(path = paste("/user/RevoShare/", loginName, "/FlightDelayDataSample.csv", sep="") )
rxHadoopCopyFromClient(source = "E:\\Labfiles\\Lab08\\FlightDelayDataSample.csv",
                       hdfsDest = paste("/user/RevoShare/", loginName, sep=""))

# Copy Carriers.csv to HDFS (/user/RevoShare)
rxHadoopRemove(path = paste("/user/RevoShare/", loginName, "/carriers.csv", sep=""))
rxHadoopCopyFromClient(source = "E:\\Labfiles\\Lab08\\carriers.csv",
                       hdfsDest = paste("/user/RevoShare/", loginName, sep=""))

# Connect to R Server running on Hadoop
rxSetComputeContext(RxLocalSeq())
remoteLogin(deployr_endpoint = "http://LON-HADOOP-01.ukwest.cloudapp.azure.com:12800", session = TRUE, diff = TRUE, commandline = TRUE, username = "admin", password = "Pa55w.rd")
library(RevoScaleR)

# Copy the pig script and the loginName variable to the Hadoop VM
pause()
putLocalFile("E:\\Labfiles\\Lab08\\carrierDelays.pig")
putLocalObject(c("loginName"))
resume()

# Run the pig script
result <- system("pig carrierDelays.pig", intern = TRUE)

# Verify that the results file has been created
rxHadoopCommand(paste("fs -ls -R /user/RevoShare/", loginName, sep = ""), intern = TRUE)

# Remove the _SUCCESS file from results folder
rxHadoopRemove(paste("fs -ls -R /user/RevoShare/", loginName, "/results/_SUCCESS", sep = ""))

# Examine the results
rxOptions(reportProgress = 1)
rxSetFileSystem(RxHdfsFileSystem())
resultsFile <- paste("/user/RevoShare/", loginName, "/results", sep = "")
resultsData <- RxTextData(resultsFile)
rxGetVarInfo(resultsData)

# Map columns in Pig storage to variables 
carrierDelayColInfo <- list(V1 = list(type = "factor", newName = "Origin"),
                            V2 = list(type = "factor", newName = "Dest"),
                            V3 = list(type = "factor", newName = "AirlineCode"),
                            V4 = list(type = "character", newName = "AirlineName"),
                            V5 = list(type = "numeric", newName = "CarrierDelay"),
                            V6 = list(type = "numeric", newName = "LateAircraftDelay")
                           )

# Convert the file to XDF for more efficient processing
carrierFile <- RxXdfData(paste("/user/RevoShare", loginName, "CarrierData", sep = "/"))
carrierData <- rxImport(inData = resultsData, 
                        outFile = carrierFile, overwrite = TRUE,
                        colInfo = carrierDelayColInfo,
                        createCompositeSet = TRUE)

# Perform the remaining operations in the Hadoop Map/Reduce compute context
hadoopContext = RxHadoopMR(sshUsername = loginName, consoleOutput = TRUE)
rxSetComputeContext(hadoopContext)

# Verify the XDF data
rxGetVarInfo(carrierData)
rxSummary(~., carrierData)

# rxHistogram does not support transforms in this compute context, so perform them manually first
transformedCarrierData <- rxDataStep(carrierData, transforms = list(TotalDelay = CarrierDelay + LateAircraftDelay))

# The data source for this histogram is an in-memory data frame, so the processing is not distributed
rxHistogram(~TotalDelay, data = transformedCarrierData,
            xTitle = "Carrier + Late Aircraft Delay (minutes)",
            yTitle = "Occurences",
            endVal = 300
           )

# The data source for this histogram is the XDF file, so the processing can be distributed
# Also, change the resolution of the plot to enable the rxHistogram to display all airline codes
png(width=1024, height=768);rxHistogram(~AirlineCode, data = carrierData,
                                        xTitle = "Airline",
                                        yTitle = "Number of delayed flights"
                                       );dev.off()

# Generate a plot of total cumulative delay time versus airline name
# Use ggplot2
library(ggplot2)

ggplot(data = rxImport(carrierData, transforms = list(TotalDelay = CarrierDelay + LateAircraftDelay))) +
  geom_bar(mapping = aes(x = AirlineName, y = TotalDelay), stat = "identity") +
  labs(x = "Airline", y = "Total Carrier + Late Aircraft Delay (minutes)") +
  scale_x_discrete(labels = function(x) { lapply(strwrap(x, width = 25, simplify = FALSE), paste, collapse = "\n")}) +
  theme(axis.text.x = element_text(angle = 90, size = 8))


# Calculate the mean delay for each airline by route (origin and destination airports)
delayData <- rxCube(AverageDelay ~ AirlineCode:Origin:Dest, carrierData,
                    transforms = list(AverageDelay = CarrierDelay + LateAircraftDelay),
                    means = TRUE,
                    na.rm = TRUE, removeZeroCounts = TRUE)

# Sort the results in descending order of mean delay
# Need to use rxExec because rxSort is not inherently distributable
sortedDelayData <- rxExec(FUN=rxSort, as.data.frame(delayData), sortByVars = c("Counts", "AverageDelay"), decreasing = c(TRUE, TRUE), timesToRun = 1)

# Display the worst and best routes for airline delays
# Note that sortedDelayData is the list of results returned by rxExec
#  - extract each item from the list using $rxElemN where N is the element number
#    in this case, there is only one element, $rxElem1
head(sortedDelayData$rxElem1, 50)
tail(sortedDelayData$rxElem1, 50)

# Save the sorted delay data to HDFS
rxSetComputeContext(RxLocalSeq())
sortedDelayDataFile <- paste("/user/RevoShare/", loginName, "/SortedDelayData.csv", sep = "")
sortedDelayDataCsv <- RxTextData(sortedDelayDataFile)
sortedDelayDataSet <- rxDataStep(inData = sortedDelayData$rxElem1, 
                                 outFile = sortedDelayDataCsv, overwrite = TRUE
                                )



# EX 2 - Integration with Spark and Hive

# Create a Spark compute context
sparkContext = RxSpark(sshUsername = loginName,
                       consoleOutput = TRUE,
                       numExecutors = 10,
                       executorCores = 2,
                       executorMem = "1g",
                       driverMem = "1g")

rxSetComputeContext(sparkContext)

# Upload the cube containing the airline delays by route information to Hive
dbTable <- paste(loginName, "RouteDelays", sep = "")
hiveDataSource <- RxHiveData(table = dbTable)

data <- rxDataStep(inData = sortedDelayDataSet, 
                   outFile = hiveDataSource, overwrite = TRUE)

# Verify that the data uploaded correctly
rxSummary(~., hiveDataSource)

# Switch to Hive on the Hadoop VM and query the data

# Use spqrklyr to query the data in the Hive database
library(sparklyr)
library(dplyr)

# Close the current Spark compute context and create a new one that can interoperate with sparklyr
rxSparkDisconnect(sparkContext)
connection = rxSparkConnect(sshUsername = loginName,
                            consoleOutput = TRUE,
                            numExecutors = 10,
                            executorCores = 2,
                            executorMem = "1g",
                            driverMem = "1g",
                            interop = "sparklyr")

# Create a sparklyr session
sparklyrSession <- rxGetSparklyrConnection(connection)

# List the tables available in Hive
src_tbls(sparklyrSession)

# Retrieve the RouteDelay data. Cache the data in the Spark session 
tbl_cache(sparklyrSession, dbTable)
routeDelaysTable <- tbl(sparklyrSession, dbTable)
head(routeDelaysTable)

# Find all flights for American Airlines that depart from New York JFK
routeDelaysTable %>%
  filter(AirlineCode == "AA" & Origin == "JFK") %>%
  select(Dest, AverageDelay) %>%
  collect ->
  aajfkData

# Display and summarize this data
print(aajfkprint(aanyData)
rxSummary(~., aajfkData)Data)
rxSummary(~., aajfkData)

# Stop the Spark engine (if it is still running) and close the Spark compute context
rxSparkDisconnect(connection)
