setwd("C:\\TestData")
conString <- "Server=chaemyung.database.windows.net;Database=AirlineData;Trusted_Connection=TRUE"
airportData <- RxSqlServerData(connectionString = conString, table = "Airports")
colClasses <- c(
	"iata" = "character",
	"airport" = "character",
	"city" = "character",
	"state" = "factor",
	"country" = "factor",
	"lat" = "numeric",
	"long" = "numeric")
csvData <- RxTextData(file = "airports.csv", colClasses = colClasses)
rxDataStep(inData = csvData, outFile = airportData, overwrite = TRUE)

# Azure Database용
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
