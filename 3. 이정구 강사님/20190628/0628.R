ls("package:datasets")
test_data <- c(850, 740, 900, 1050, 1020, 940, 930, 870, 800, 740, 630, 1050)

test_data
plot(test_data)
plot(1:10)
stem(test_data)
hist(test_data)
qqnorm(test_data)
boxplot(test_data)
summary(test_data)
mean(test_data)
min(test_data)
sd(test_data)
var(test_data)

plot(attitude)

test <- lm(rating ~ complaints, data=attitude)
test

#Microsoft R DataSet
library(readr)
library(RevoScaleR)
list.files(rxGetOption("sampleDataDir"))
inDataFile <- file.path(rxGetOption("sampleDataDir"), "mortDefaultSmall2000.csv")
mortData <- rxImport(inData = inDataFile)
str(mortData)
rxGetVarInfo(mortData)
nrow(mortData)
ncol(mortData)
names(mortData)
head(mortData, 3)
rxGetInfo(mortData, getVarInfo = T, numRows = 5)
rxHistogram(~creditScore, data=mortData)
mortData2 <- rxDataStep(inData = mortData, varsToDrop = c("year"), rowSelection = creditScore < 800)
rxHistogram(~creditScore, data=mortData2)

mortData3 <- rxDataStep(inData = mortData, 
varsToDrop = c("year"),
rowSelection = creditScore < 800,
transforms = list(
catDept = cut(ccDebt, breaks = c(0,6500, 13000), 
              labels = c("Low Debt", "High Debt")), 
lowScore = creditScore < 625))

rxGetVarInfo(mortData3)

mortCube <- rxCube(~F(creditScore):catDept, data = mortData3)
head(mortCube)
rxLinePlot(Counts ~ creditScore|catDept, data = rxResultsDF(mortCube))

setwd("C:\\Users\\user\\Desktop\\new\\Labfiles\\Lab03")

flightDelayDataXdf <- "FlightDelayData.xdf"
flightDelayData <- RxXdfData(flightDelayDataXdf)
rxOptions(reportProgress = 1)
delayPlotData <- rxImport(flightDelayData, 
  rowsPerRead = 1000000, 
  varsToKeep = c("Distance", "Delay", "Origin", "OriginState"), 
  rowSelection = (Distance) > 0 & 
    as.logical(rbinom(n = .rxNumRows, size = 1, prob = 0.02)))

library(tidyverse)

ggplot(data = delayPlotData) + 
  geom_point(mapping = aes(x = Distance, y = Delay)) + 
  xlab("Distance (miles)") + 
  ylab("Delay (minutes)")

delayPlotData2 <- rxImport(delayPlotData, rowsPerRead = 100000,
rowSelection = !is.na(Delay) & (Delay >= 0) & (Delay <= 1000))

delayPlotData2 %>%
  ggplot(mapping = aes(x = Distance, y = Delay)) +
  xlab("Distance (miles)") +
  ylab("Delay (minutes)") +
  geom_point(alpha = 1/50) +
  geom_smooth(color = "red")

delayPlotData2 %>%
  ggplot(mapping = aes(x = Distance, y = Delay)) +
  xlab("Distance (miles)") + 
  ylab("Delay (minutes)") + 
  geom_point(alpha = 1/50) +
  geom_smooth(color = "red") +
  theme(axis.text = element_text(size = 6)) +
  facet_wrap( ~ OriginState, nrow = 8)

delayDataWithProportionsXdf <- "FlightDelayDataWithProportions.xdf"
delayPlotDataXdf <- rxImport(flightDelayData, outFile = delayDataWithProportionsXdf, overwrite = TRUE, append ="none", rowsPerRead = 1000000, varsToKeep = c("Distance", "ActualElapsedTime", "Delay", "Origin", "Dest", "OriginState", "DestState", "ArrDelay", "DepDelay", "CarrierDelay", "WeatherDelay", "NASDelay", "SecurityDelay", "LateAircraftDelay"), rowSelection = (Distance > 0) & (Delay >= 0) & (Delay <= 1000) & !is.na(ActualElapsedTime) & (ActualElapsedTime > 0), transforms = list(DelayPercent = (Delay / ActualElapsedTime) * 100))
delayPlotCube <- rxCube(DelayPercent ~ F(Distance):OriginState, data = delayPlotDataXdf, rowSelection = (DelayPercent <= 100))
names(delayPlotCube)[1] <- "Distance"

remoteLogin("http://dnlffldja.eastus.cloudapp.azure.com", diff = T, session = T, commandline = T)

