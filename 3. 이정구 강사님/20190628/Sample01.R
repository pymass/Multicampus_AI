ls("package:datasets")
test_data <-
  c(850,740,900,1050,1020,940,930,870,980,900,
    800,740,630,1050,960,960,810,760,980,1000)
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

# y = 2x
# x -> y

# y x -> y = ()x + () -> y ~ x
# 2 1
# 3 2
# y = ()x2 + ()x + ()
# y ~ x + y
test <- lm(rating ~ complaints, data=attitude)
test
summary(test)

# Microsoft R DataSet
library(readr)
library(RevoScaleR)
list.files(rxGetOption("sampleDataDir"))
inDataFile <- 
  file.path(rxGetOption("sampleDataDir"),
            "mortDefaultSmall2000.csv")
mortData <- rxImport(inData = inDataFile)
str(mortData)
rxGetVarInfo(mortData)
nrow(mortData)
ncol(mortData)
names(mortData)
