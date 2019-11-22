install.packages("ggplot2")
library(ggplot2)

# factor

data <- c("East", "West", "East", "North", "North", "East")
mode(data)
data2 <- factor(data)
data2
mode(data2)
is.factor(data2)
data3 <- c("East", "West", "East", "North", "North", "East")
data4 <- factor(data3, levels = c("East", "West", "North"))
data4
data5 <- factor(data3, levels = c("East", "West", "North", "South")) #임의로 넣을 수 있음
data5
data6 <- gl(3, 4, labels = c("East", "West", "South")) #3개의 카테고리에 대해 4번씩 반복
data6

# Matrix
data7 <- matrix(c(1,2,3,4))
data7
data8 <- matrix(c(1,2,3,4), nrow = 2)
data8
data9 <- matrix(3:14, nrow = 4)
data9
data10 <- matrix(1:6, nrow=2, ncol = 3)
data10
data11 <- matrix(3:14, nrow= 4, byrow = F)
data11
data12 <- matrix(3:14, nrow = 4, byrow = TRUE,
                 dimnames = list(c('row1', 'row2', 'row3', 'row4'), c('col1', 'col2', 'col3')))
data12
data11[1,3]
data11[4,2]
data11[2,]
data11[,3]

# array

data12 <- c(1,2,3)
data13 <- c(10,11,12,13,14,15)

# List

data37 <- list("Apple", "Green", 10.20, c(1,2,3,4), c('test1', 'test2', 3))
data37
data38 <- list("Apple", "Green", 10.20, c(1,2,3,4), c('test1', 'test2', 3),
               matrix(c(1,2,3,4)))
data38
data38[1]
data38[2]
data39 <- list("Apple", "Green", 10.20, c(1,2,3,4), c('test1', 'test2', 3),
               matrix(c(1,2,3,4)), list(1,"2",T))
data39
data39[7]

names(data39) <- c('item1','item2','item3','item4','item5','item6','item7')
data39
data39$item1

temp <- c(1,2,3,4)
df <- data.frame(temp)
df
temp2 <- matrix(c(1,2,3,4))
df2 <- data.frame(temp2)
df2

emp <- data.frame(emp_id = c(1:3), emp_name = c('Tom', 'John', 'Amy'),
                  salary = c(2000,3000,4000), 
                  start_date = c('2019-01-01', '2019-02-01', '2019-03-01'),
                  stringsAsFactors = F)
emp
str(emp)
summary(emp)

emp$emp_id
emp$emp_name
emp$salary
emp$start_date
emp
emp[1,2]
emp[c(1,3),c(1,2)]
emp$dept <- c('IT', 'HR', 'Finance')
emp

new.data <- data.frame(emp_id = c(4,5),
  emp_name = c('Tom', 'Jerry')
  salary = c(2000,3000)
  start_date = c('2019-10-11','2019-10-20'),
  dept = c('IT', 'Finance'))

remoteLogin("http://machinelearn.eastus.cloudapp.azure.com:12800",
            session = T, diff = T, commandline = T, username = 'admin',
            password = 'Pa$$w0rd2019')
mtcars
firstCar <- mtcars[1, ]
pause()
print(firstCar)
getRemoteObject(c("firstCar"))
print(firstCar)
resume()
exit
