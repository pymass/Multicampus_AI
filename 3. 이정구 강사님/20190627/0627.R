# 1번으로 할거
remoteLogin(
  "http://tetetestml.eastus.cloudapp.azure.com:12800",
  session = T,
  diff = T,
  commandline = T,
  username = 'admin',
  password = 'Pa$$w0rd2019'
)

# 2번으로 할거 에러뜨면 방화벽 설정에서 ip 넣기
conString <- "Driver=SQL Server;Server=chaemyung.database.windows.net;Database=AirlineData;Uid=admin2019;Pwd=Pa$$w0rd2019"
airportData <- RxSqlServerData(connectionString = conString, table = "Airports")
colClasses <- c(
  "iata" = "character",
  "airport" = "character",
  "city" = "character",
  "state" = "factor",
  "country" = "factor",
  "lat" = "numeric",
  "long" = "numeric")
csvData <- RxTextData(file = "C:\\TestData\\airports.csv", colClasses = colClasses)
rxDataStep(inData = csvData, outFile = airportData, overwrite = TRUE)

# 3번으로 할거
# Connect to SQL Server

sqlConnString <- "Driver=SQL Server;Server=chaemyung.database.windows.net;Database=AirlineData;Uid=admin2019;Pwd=Pa$$w0rd2019"

connection <- RxSqlServerData(connectionString = sqlConnString,
                              table = "dbo.Airports", rowsPerRead = 1000)

# Use R functions to examine the data in the Airports table

head(connection)
rxGetVarInfo(connection)
rxSummary(~., connection)

# 4번으로 할거 - 로컬에서 하는거임
# Flight delay data for the year 2000
setwd("C:\\workspace") # 경로에 한글있으면 제대로 안됨

csvDataFile = "2000.csv" 

# Examine the raw data
rawData <- rxImport(csvDataFile, numRows = 1000)
rxGetVarInfo(rawData)

# Create an XDF file that combines the ArrDelay and DepDelay variables, 
# and that selects a random 10% sample from the data

outFileName <- "2000.xdf"
filteredData <- rxImport(csvDataFile, outFile = outFileName, 
                         overwrite = TRUE, append = "none",
                         transforms = list(Delay = ArrDelay + DepDelay),
                         rowSelection = ifelse(rbinom(.rxNumRows, size=1, prob=0.1), TRUE, FALSE))

# Examine the stucture of the XDF data - it should contain a Delay variable
# Note that Origin is a characater
rxGetVarInfo(filteredData)

# Generate a quick summary of the numeric data in the XDF file
rxSummary(~., filteredData)

# Summarize the delay fields
rxSummary(~Delay+ArrDelay+DepDelay, filteredData)

# Examine Delay broken down by origin airport
# Need to change Origin and Dest to factors

refactoredData = "2000Refactored.xdf"
refactoredXdf = RxXdfData(refactoredData)

rxFactors(inData = filteredData, outFile = refactoredXdf, 
          overwrite = TRUE, factorInfo = c("Origin", "Dest"))

rxSummary(Delay~Origin, refactoredXdf)

# Generate a crosstab showing the average delay 
# for flights departing from each origin to each destination
rxCrossTabs(Delay ~ Origin:Dest, refactoredXdf, means = TRUE)

# Generate a cube of the same data
rxCube(Delay ~ Origin:Dest, refactoredXdf)

# Omit the routes that don't exist
rxCube(Delay ~ Origin:Dest, refactoredXdf, removeZeroCounts = TRUE)

# ------------------------ 오후 수업 ------------------------------
# EX 1 - Run locally

setwd("C:\\Users\\user\\Desktop\\new\\Labfiles\\Lab02")

# Examine the structure of the data file
flightDataSampleCsv <- "2000.csv"
flightDataSample <- rxImport(flightDataSampleCsv, numRows = 10)

rxGetVarInfo(flightDataSample)

# The structure of the data
flightDataColumns <- c("Year" = "factor",
                       "DayofMonth" = "factor",
                       "DayOfWeek" = "factor",
                       "UniqueCarrier" = "factor",
                       "Origin" = "factor",
                       "Dest" = "factor",
                       "CancellationCode" = "factor"
)

# Read the CSV file and write it out as an XDF file
flightDataXdf <- "2000.xdf"
rxOptions(reportProgress = 1)
flightDataSampleXDF <- rxImport(inData = flightDataSampleCsv, outFile = flightDataXdf, overwrite = TRUE, append = "none", colClasses = flightDataColumns)

# Check the structure of the new file
rxGetVarInfo(flightDataXdf)

# Compare sizes of XDF and CSV files at this point (using File Explorer, not R)

# Compare performance of CSV and XDF

system.time(csvDelaySummary <- rxSummary(~., flightDataSampleCsv))
# print(csvDelaySummary)

system.time(xdfDelaySummary <- rxSummary(~., flightDataSampleXDF))
# print(xdfDelaySummary)

# Generate crosstabs and cubes for cancelled flights - still comparing performance
system.time(csvCrossTabInfo <- rxCrossTabs(~as.factor(Month):as.factor(Cancelled == 1), flightDataSampleCsv))
# print(csvCrossTabInfo)

system.time(xdfCrossTabInfo <- rxCrossTabs(~as.factor(Month):as.factor(Cancelled == 1), flightDataSampleXDF))
# print(xdfCrossTabInfo)

system.time(csvCubeInfo <- rxCube(~as.factor(Month):as.factor(Cancelled), flightDataSampleCsv))
# print(csvCubeInfo)

system.time(xdfCubeInfo <- rxCube(~as.factor(Month):as.factor(Cancelled), flightDataSampleXDF))
# print(xdfCubeInfo)

# Tidy up memory
rm(flightDataSample, flightDataSampleXDF, csvDelaySummary, xdfDelaySummary, 
   csvCrossTabInfo, xdfCrossTabInfo, csvCubeInfo, xdfCubeInfo)


# EX 2 - Run remotely on R Server

# Preparation: Log into the LON-RSVR VM and create the Data share over the C:\Temp folder
# Copy the CSV files from E:\Setup\Data to \\LON-RSVR\\Data

remoteLogin("http://tetetestml.eastus.cloudapp.azure.com:12800", session = TRUE, diff = TRUE, commandline = TRUE)

pause()

putLocalObject(c("flightDataColumns"))

resume()

ls()

# Transform the data - create a combined Delay column, filter all cancelled flights, and discard FlightNum, TailNum, and CancellationCode
# Test import and transform over a small sample first
flightDataSampleXDF <- rxImport(inData = "C:\\TestData\\2000.csv", outFile = "C:\\TestData\\Sample.xdf", overwrite = TRUE, append = "none", colClasses = flightDataColumns, transforms = list(Delay = ArrDelay + DepDelay + ifelse(is.na(CarrierDelay), 0, CarrierDelay) + ifelse(is.na(WeatherDelay), 0, WeatherDelay) + ifelse(is.na(NASDelay), 0, NASDelay) + ifelse(is.na(SecurityDelay), 0, SecurityDelay) + ifelse(is.na(LateAircraftDelay), 0, LateAircraftDelay), MonthName = factor(month.name[as.numeric(Month)], levels=month.name)), rowSelection = (Cancelled == 0), varsToDrop = c("FlightNum", "TailNum", "CancellationCode"), numRows = 1000)

head(flightDataSampleXDF, 100)

# Combine separate CSV files containing data for each year into one big XDF file, performing the same transformations (which have now been tested)
rxOptions(reportProgress = 1)

delayXdf <- "C:\\TestData\\FlightDelayData.xdf"
flightDataCsvFolder <- "C:\\data"
flightDataXDF <- rxImport(inData = flightDataCsvFolder, outFile = delayXdf, overwrite = TRUE, append = ifelse(file.exists(delayXdf), "rows", "none"), colClasses = flightDataColumns, transforms = list(Delay = ArrDelay + DepDelay + ifelse(is.na(CarrierDelay), 0, CarrierDelay) + ifelse(is.na(WeatherDelay), 0, WeatherDelay) + ifelse(is.na(NASDelay), 0, NASDelay) + ifelse(is.na(SecurityDelay), 0, SecurityDelay) + ifelse(is.na(LateAircraftDelay), 0, LateAircraftDelay), MonthName = factor(month.name[as.numeric(Month)], levels=month.name)), rowSelection = (Cancelled == 0), varsToDrop = c("FlightNum", "TailNum", "CancellationCode"), rowsPerRead = 500000)

exit

# EX3 - Start locally

# Import airport data from the Airports table in the AirlineData database, and save it as an XDF file
conString <- "Driver=SQL Server;Server=chaemyung.database.windows.net;Database=AirlineData;Uid=admin2019;Pwd=Pa$$w0rd2019"
airportData <- RxSqlServerData(connectionString = conString, table = "Airports")

# Examine the first few rows of data
head(airportData)

# Import the data to a data frame
airportInfo <- rxImport(inData = airportData, stringsAsFactors = TRUE)
head(airportInfo)

# Connect remotely
remoteLogin("http://tetetestml.eastus.cloudapp.azure.com:12800", session = TRUE, diff = TRUE, commandline = TRUE)
pause()

# Copy the data frame
putLocalObject(c("airportInfo"))

resume()

# Add the OriginState and DestState columns. These columns hold the US state for the Origin and Dest airports, retrieved from the airportData data frame
enhancedDelayDataXdf <- "C:\\TestData\\EnhancedFlightDelayData.xdf"
flightDelayDataXdf <- "C:\\TestData\\FlightDelayData.xdf"

enhancedXdf <- rxImport(inData = flightDelayDataXdf, outFile = enhancedDelayDataXdf, overwrite = TRUE, append = "none", rowsPerRead = 500000, transforms = list(OriginState = stateInfo$state[match(Origin, stateInfo$iata)], DestState = stateInfo$state[match(Dest, stateInfo$iata)]), transformObjects = list(stateInfo = airportInfo)
)

head(enhancedXdf)


# EX4 - Remain connected remotely

# delayFactor breaks the continous variable Delay into a series of factored values
delayFactor <- expression(list(Delay = cut(Delay, breaks = c(0, 1, 30, 60, 120, 180, 181), labels = c("No delay", "Up to 30 mins", "30 mins - 1 hour", "1 hour to 2 hours", "2 hours to 3 hours", "More than 3 hours"))))

# Generate a crosstab that summarizes the delays for flights starting at the Origin airport
originAirportDelays <- rxCrossTabs(formula = ~ Origin:Delay, data = enhancedXdf,
                                   transforms = delayFactor
)
print(originAirportDelays)

# Generate a crosstab that summarizes the delays for flights finishing at the Dest airport
destAirportDelays <- rxCrossTabs(formula = ~ Dest:Delay, data = enhancedXdf,
                                 transforms = delayFactor
)
print(destAirportDelays)

# Generate a crosstab that summarizes the delays for flights starting in the OriginState state
originStateDelays <- rxCrossTabs(formula = ~ OriginState:Delay, data = enhancedXdf,
                                 transforms = delayFactor
)
print(originStateDelays)

# Generate a crosstab that summarizes the delays for flights finishing in the DestState state
destStateDelays <- rxCrossTabs(formula = ~ DestState:Delay, data = enhancedXdf,
                               transforms = delayFactor
)
print(destStateDelays)

# return to the local session
exit

# Install dplyrXdf
install.packages("dplyr")
install.packages("devtools")
devtools::install_github("RevolutionAnalytics/dplyrXdf")
library(dplyr)
library(dplyrXdf)

# Read in a subset of the data from the XDF file containing the data to be summarized (discard all the other columns)
enhancedDelayDataXdf <- "C:\\Users\\user\\Desktop\\new\\Labfiles\\Lab02\\EnhancedFlightDelayData.xdf"
essentialData <-RxXdfData(enhancedDelayDataXdf, varsToKeep = c("Delay", "Origin", "Dest", "OriginState", "DestState"))

# Summarize the data using dplyrXdf
originAirportStats <- filter(essentialData, !is.na(Delay)) %>%
  select(Origin, Delay) %>%
  group_by(Origin) %>%
  summarise(mean_delay = mean(Delay), .method = 1) %>% # Use methods 1 or 2 only
  arrange(desc(mean_delay)) %>%
  persist("C:\\Users\\user\\Desktop\\new\\Labfiles\\Lab02\\temp.xdf")  # Return a reference to a persistent file. By default, temp files will be deleted
head(originAirportStats, 100)

destAirportStats <- filter(essentialData, !is.na(Delay)) %>%
  select(Dest, Delay) %>%
  group_by(Dest) %>%
  summarise(mean_delay = mean(Delay), .method = 1) %>%
  arrange(desc(mean_delay)) %>%
  persist("C:\\Users\\user\\Desktop\\new\\Labfiles\\Lab02\\temp.xdf")
head(destAirportStats, 100)

originStateStats <- filter(essentialData, !is.na(Delay)) %>%
  select(OriginState, Delay) %>%
  group_by(OriginState) %>%
  summarise(mean_delay = mean(Delay), .method = 1) %>%
  arrange(desc(mean_delay)) %>%
  persist("C:\\Users\\user\\Desktop\\new\\Labfiles\\Lab02\\temp.xdf")
head(originStateStats, 100)

destStateStats <- filter(essentialData, !is.na(Delay)) %>%
  select(DestState, Delay) %>%
  group_by(DestState) %>%
  summarise(mean_delay = mean(Delay), .method = 1) %>%
  arrange(desc(mean_delay)) %>%
  persist("C:\\Users\\user\\Desktop\\new\\Labfiles\\Lab02\\temp.xdf")
head(destStateStats, 100)

