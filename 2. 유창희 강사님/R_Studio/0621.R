id <- c('F1', 'F2', 'F3')
name <- c('김가수', '박인호', '고소미')
age <- c(32, 28, 22)
isMarried <- c(T,T,F)

df <- data.frame(id, name, age, isMarried)
df
stf(df)

df <- data.frame(id, name, age, isMarried, stringsAsFactors = F)
str(df)

df <- data.frame(name=c('김가수', '박인호'), age=c(32,28))
df

df <- data.frame(id, name, age, isMarried)
df
df[2,3]
df[c(2,3), c(2,4)]
df[, c(2,3)]
df[c(2,3),]
df[, c("name", "age")]
df
df$name
df$age
str(df$age)
sum(df$age)
df$age[2:3]
iris
str(iris)
nrow(iris)
ncol(iris)
head(iris, 3)
tail(iris, 3)
summary(iris)
min(Sepal.Length)
min(iris$Sepal.Length)
max(iris$Sepal.Length)
median(iris$Sepal.Length)
meam(iris$Sepal.Length)
quantile(iris$Sepal.Length)
View(iris)
subset(iris, Sepal.Length > 7)
subset(iris, Sepal.Length >7 & Petal.Length <= 6.5)
subset(iris, Sepal.Length > 7 | Petal.Length >= 6.5)
subset(iris, Sepal.Length > 7.2 & Petal.Length <= 6.5, c('Sepal.Length', 'Species'))
subset(iris, Sepal.Length > 7.2 & Petal.Length <=6.5, c('Sepal.Length', 'Species'))
subset(iris, Sepal.Length > 7.2 & Petal.Length <=6.5, c('Species', 'Sepal.Length'))
subset(iris, Species == 'setosa')
str(subset(iris, Species == 'setosa'))
nrow(subset (iris, Species == 'setosa'))
summary(subset(iris, Species == 'setosa'))
subset(iris, Sepal.Length == 7.2, c('Species', 'Sepal.Length'))
subset(Sepal.Length == 7.2, iris, c('Species', 'Sepal.Length'))
subset(x=iris, subset=(Sepal.Length == 7.2), select=c('Species', 'Sepal.Length'))
subset(select=c('Species', 'Sepal.Length'), subset=(Sepal.Length == 7.2), x=iris)

name <- c('김가수', '박인호', '어만데', '이기성')
age <- c(23, 28, 15, 22)
weight <- c(67, 75, 73, 80)

ex_df <- data.frame(name, age, weight)

ex_df
ex_df[,]
ex_df[c("1", "2"), c("name", "weight")]
ex_df[c(1,2), c(1,3)]
ex_df[c(T,T,F,T), c(T,F,T)]
ex_df$age
ex_df$age >25
ex_df[ex_df$age >25,]
str(longley)
longley
longley[longley$GNP > 200 & longley$Population >= 109 & longley$Year > 1960 & longley$Employed > 50,]
attach(longley)
longley[GNP > 200 & Population >= 109 & Year > 1960 & Employed > 50,]
detach(longley)
longley[GNP > 200 & Population >= 109 & Year > 1960 & Employed > 50,]
longley[, c("GNP", "Year")]
str(longley[, c("GNP", "Year")])
longley[, c("GNP"), drop=F]
str(longley[, c("GNP")], drop=F)
str(iris)
subset(iris, Sepal.Length >= 7.6 & Species == 'virginica', c("Species", "Sepal.Length"))
iris[iris$Sepal.Length >= 7.6 & iris$Species == 'virginica', c("Species", "Sepal.Length")]
longley
install.packages("sqldf")
library(sqldf)
sqldf("select GNP, Year, Employed from longley where GNP > 400")
sqldf("select Year, sum(GNP) from longley where Year > 1960 group by Year")
ex_df
ex_df[c(1,2,4),]
ex_df[c(4,2,1),]
ex_df
ex_df$age
order(ex_df$age)
ex_df[order(ex_df$age),]
ex_df[order(ex_df$age, decreasing = T),]
alpha <- c('A', 'C', 'F', 'B', 'E', 'D')
alpha

order(alpha) # 인덱스 값을 리턴
alpha[order(alpha)]
sort(alpha) # 정렬된 값을 리턴

dept <- c('개발부', '개발부', '개발부', '개발부', '영업부', '영업부', '영업부', '영업부')
position <- c('과장', '과장', '차장', '차장', '과장', '과장', '차장', '차장')
name <- c('김가윤', '고동산', '박기성', '이소균', '황가인', '최유리', '김재석', '유상균')
salary <- c(5400, 5100, 7500, 7300, 4900, 5500, 6000, 6700)
worktime <- c(15,18,10,12,17,20,8,9)

com_data <- data.frame(dept, position, name, salary, worktime)
com_data

aggregate(salary ~ dept, com_data, mean)
aggregate(cbind(salary, worktime) ~ dept, com_data, mean)
aggregate(salary ~ dept + position, com_data, mean)

ex_df
ex_df_m <- edit(ex_df)
ex_df
ex_df_m
id <- c('F1', 'F2', 'F3')
name <- c(' 김가수 ', '박인호 ', '고소미')
age <- c(32 , 28 , 22 )
isMarried <- c(TRUE , TRUE , FALSE)
df <- data.frame(id, name, age, isMarried)

df
df[1,3]
df[1,3] <- 100
df[1,3]
df
subset(iris, Species == 'virginica' & Petal.Width >= 2.4)
iris[iris$Species == 'virginica' & iris$Petal.Width >= 2.4, c("Petal.Length")] <- 1
subset(iris, Species == 'virginica' & Petal.Width >= 2.4)
head(iris)
iris$Sepal.Width <- iris$Sepal.Width*2
head(iris)
iris$new_column <- '신규열'
head(iris)
iris$new_column <- NULL
head(iris)
new_iris <- iris[, -c(1,2,3)]
head(new_iris)
head(iris)
iris[, c(1,2,3)] <- list(NULL)
head(iris)

ex_na <- c(1,2, NA, NA, 3)
print(ex_na)
sum(ex_na)
sum(ex_na, na.rm=TRUE)
ex_null <- c(1,2, NULL, NULL, 3)
print(ex_null)
sum(ex_null)
ex_cc <- c(1,2, NA, 4, NA)
complete.cases(ex_cc)
head(iris)
iris$Sepal.Length <- 0
iris$Sepal.Width <- 0
iris$Sepal.Length <- NULL
iris$Petal.Width <- NULL

head(iris)
data(iris)
head(iris)
colnames(iris)
colnames(iris)[3] <- "3th_Column"
colnames(iris)
head(iris)
colnames(iris) <- c('꽃받침길이', '꽃받침너비', '꽃잎길이', '꽃잎너비', '종류')
colnames(iris)
head(iris)
hotel_rooms <- read.table (file = "clipboard", header=TRUE , sep="\t", stringsAsFactors=FALSE )
hotel_rooms
str(hotel_rooms)
hotel_rooms$room_type <- as.factor(hotel_rooms$type)
hotel_rooms$room_number <- as.character(hotel_rooms$room_number)
str(hotel_rooms)
str(hotel_rooms)
aggregate(price ~ room_type, hotel_rooms, mean)
hotel_rooms$price <- as.numeric(hotel_rooms$price)
str(hotel_rooms)
aggregate(price ~ type, hotel_rooms, mean)
id <- c('F1', 'F2', 'F3', 'F4')
name <- c('김가인', '박지성', '고아라', '이승철')
age <- c(24,32,18,40)
ex_df_age <- data.frame(id, name, age)
ex_df_age
id <- c('F2', 'F1', 'F4', 'F3')
name <- c('박지성', '김가인', '이승철', '고아라')
age <- c(95,100,56,73)

ex_df_score <- data.frame(id, name, age)
ex_df_score
cbind(ex_df_age, ex_df_score)
merge(ex_df_age, ex_df_score, by=c('id', 'name'))
merge(ex_df_age, ex_df_score, by=c('id'))
ex_df_age
ex_row_add <- data.frame(id='F5', name= '나지용', age=27)
ex_row_add
ex_rbind <- rbind(ex_df_age, ex_row_add)
ex_rbind
