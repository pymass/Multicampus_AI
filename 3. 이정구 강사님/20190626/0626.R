df <- read.csv("income.csv")
str(df)

options(repos = c(CRAN = 'https://cloud.r-project.org'))
install.packages('dplyr', repos = 'https://cloud.r-project.org')

df
sample_n(df,3)
sample_frac(df, 0.1)
df2 <- distinct(df)
df2
str(df)

#select
select(df,Index,State:Y2008)
select(df,Index,State)
select(df, State)
select(df, Index, -State)
select(df, -c(Index, State))
select(df, starts_with("Y"))
select(df, -starts_with("Y"))
select(df, contains("I"))
# select(df, State, everything()) = df

df2 <- rename(df, Index2=Index)
names(df2)

#filter
filter(df, Index == "A")
filter(df, Index %in% "A")
filter(df, Index %in% c("A", "C"))

filter(df, Index %in% c("A", "C") & Y2002 >= 1400000)
filter(df, Index %in% c("A", "C"))
# 010-1234-1234

filter(df, grepl("Ar", State))
summary(df, Y2015_mean = mean(Y2015), Y2015_median = median(Y2015))

#arrange
df3 <- select(df, Index)
df3
df4 <- arrange(df3, Index)
head(df4)
df5 <- arange(df3, desc(Index))
df5

df6 <- select(df, Index, State)
df6

df7 <- arange(df6, desc(Index), State)
df7

# group_by
group_by(df, Index)

View(df)
head(df)
tail(df)

# Pipe Operator %>%
# magrittr

df %>% select(Index, State) # df라는거를 Index앞에 연결, State앞에 연결
sample_n(select(df, Index,State), 10)
df %>% select(Index, State) %>% sample_n(10) # 위아래가 동일함

df10 <- read.csv("exam.csv")
str(df10)
df10
filter(df10, class == 1)
df10 %>% filter(class == 1)

filter(select(df10, class, math, english), class == 1)
df10 %>%
  select(class, math, english) %>%
  filter(class == 1) %>%
  arrange(desc(math))

df_temp <- df10 %>%
  filter(class %in% c(1,3,5)) %>%
  arrange(desc(english))

a <- 10
if(is.integer(a)){
  print("X is ans Integer")
}
al <- 10L
if(is.integer(al)){
  print("X is an Integer")
}

a2 <- c("What", "is", "truth")
if("Truth" %in% a2){
  print("True")
} else {
    print("False")
}

a3 <- switch(3, "One", "Two", "Three", "Four")
a3

# Loop

a4 <- c("Hello", "R loop")
cnt <- 2
repeat{
  print(a4)
  cnt <- cnt + 1
  print(cnt)
  if(cnt > 5) {
    break;
  }
}

a5 <- c("Hello", "R loop")
cnt <- 2
while(cnt < 7){
  print(a5)
  cnt = cnt +1
}

a6 <- LETTERS[1:4]
a7 <- letters[1:4]

for(i in a6){
  print(i)
}

#user-defined functions
myfunc <- function(a){
  for(i in 1:a){
    b <- 1*2
    print(b)
  }
}

myfunc(10)

myfunc2 <- function(){
  for (i in 1:5){
    print(i * 2)
  }
}
myfunc2()

myfunc3 <- function(a,b){
  r <- a+b
  print(r)
}
myfunc3(1,2)
myfunc3(a=1, b=2)
myfunc3(b=2, a=1)
myfunc3(1, b=3)

myfunc4 <- function(a=0, b=0){
  r <- a + b
  print(r)
}

myfunc4(a=1)
myfunc4(b=2)
myfunc5 <- function(a){c <- a}
myfunc5(1)

df <- read.csv("exam.csv")
str(df)

df %>% 
  select(id, class, math) %>%
  filter(class == 1) %>%
  arrange(desc(id))

df %>%
  arrange(class, desc(id)) %>%
  head(5)

df %>%
  arrange(class, desc(id)) %>%
  mutate(total = math + english + science,
         mean = (math + english + science)/3)
# group_by
df %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            median_math = median(math),
            sum_math = sum(math),
            count_math = n())

mpg <- as.data.frame(ggplot2::mpg)
str(mpg)

select(mpg, class)
mpg %>%
  group_by(class) %>%
  summarise(mean_cty=mean(cty))

# 어떤 회사의 자동차 hwy가 가장 높은 것을 알아보려고 한다.
# hwy평균 가장 높은 회사 5곳을 출력하시오.

mpg %>%
  group_by(manufacturer) %>%
  summarise(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy)) %>%
  head(5)


# 1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.

mpg %>%
  group_by(displ <= 4) %>%
  group_by(displ >= 5) %>%
  filter(displ <= 4 | displ >= 5) %>%
  summarise(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy))

# 2.자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. "audi"와 "toyota" 중 어느 manufacturer(자동차 제조 회사)의 cty(도시 연비)가 평균적으로 더 높은지 알아보세요.

mpg %>%
  select(manufacturer, cty) %>%
  filter(manufacturer == 'audi' | manufacturer == 'toyota') %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty))

# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다. 이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요.

mpg %>%
  filter(manufacturer == 'chevrolet' | manufacturer == 'ford' | manufacturer == 'honda') %>%
  summarise(mean_hwy = mean(hwy))

# 4.mpg 데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비 변수'를 추가하세요.

mpg_copy <- mpg %>%
  mutate(totaly = cty + hwy)
mpg_copy

# 5. 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가세요.

mpg_copy %>%
  mutate(mean_total = totaly/2)
mpg_copy

# 6. '평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.

mpg_copy %>%
  mutate(mean_total = totaly/2) %>%
  arrange(desc(mean_total)) %>%
  head(3)

# 7. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

mpg %>%
  filter(class == 'compact') %>%
  group_by(manufacturer) %>%
  summarise('count' = n()) %>%
  arrange(desc(count))
