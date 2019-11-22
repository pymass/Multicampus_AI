# Create a Hadoop compute context
context <- RxHadoopMR(sshUsername = "instructor", 
                      sshHostname = "LON-HADOOP")

rxSetComputeContext(context)

# List the contents of the /user/instructor folder in HDFS
rxHadoopCommand("fs -ls /user/instructor")

# Connect directly to HFDS on the Hadoop VM
hdfsConnection <- RxHdfsFileSystem()
rxSetFileSystem(hdfsConnection)

# Create a data source for the CensusWorkers.xdf file
workerInfo <- RxXdfData("/user/instructor/CensusWorkers.xdf")

# Perform functions that read from the CensusWorkers.xdf file
head(workerInfo)
rxSummary(~., workerInfo)
