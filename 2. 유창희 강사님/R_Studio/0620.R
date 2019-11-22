love <- 1
print(love)
love <- "안녕하세요"
print(love)
love("이제 나는 함수가 될 수 있을까?")
love <- print
love("이제 나는 함수가 되었다!")

love_num <- 1
love_str <- "안녕하세요"
love_vec <- c(1,1,1,1)
love_fun <- print

str(love_num)
str(love_str)
str(love_vec)
str(love_fun)

A <- 1
B <- A
print(A)
print(B)
A <- 9
print(A)
print(B)

a <- 1
print(a)
a

vec_t <- c(1,2,3,4)
vec_t

str(vec_t)
length(vec_t)

vec_t <- c(1, 'hi', 2)
vec_t
str(vec_t)

scalar_item <- 1
scalar_item

vector_item <- c(1)
vector_item

identical(scalar_item, vector_item)
numeric_vector <- c(0.2, -1, 2, -0.5)
numeric_vector
mode(numeric_vector)

n_vector <- c(1,2,3,4,5,6,7,8,9)
min(n_vector)
max(n_vector)
mean(n_vector)
median(n_vector)
sum(n_vector)

numeric_vector <- c(1/0, 2/2, -2/2, -1/0, 0/0)
numeric_vector

ex_logical_1 <-c(TRUE, FALSE, TRUE, FALSE)
ex_logical_1
mode(ex_logical_1)

ex_logical_2 <-c(T,F,T,F)
ex_logical_2
mode(ex_logical_2)

ex_logical_3 <- c(true,false,true,false)

ex_logical_4 <- c('TRUE', 'FALSE', 'TRUE', 'FALSE')
ex_logical_4
mode(ex_logical_4)

ex_logical <- c(TRUE, T, FALSE, F)
ex_logical

!ex_logical

ex_logical <- as.logical(c(0,-1,1,100,-7))
print(ex_logical)


v_charater <- c("문자열1", "문자열2", "A", "1")
v_charater

mode(v_charater)

nchar(c("F123", "F124", "F125", "F126"))
substr("1234567",2, 4)
substr(c("F123", "F124", "F125", "F126"), 2, 4)

strsplit('2014/11/22', split="/")
paste("50 = ", "30 +", "20", sep="")
paste("50", "30", "20", sep="*")

toupper("AbCdEfGhIjKLMn")
tolower("AbCdEfGhIjKLMn")

v_character <- c("사과", "복숭아", "사과", "오렌지", "사과", "오렌지", "복숭아")
v_character

v_factor <- factor(v_character)
v_factor
mode(v_factor)
str(v_factor)

v_factor_to_char <- as.character(v_factor)
v_factor_to_char

v_factor_to_num <- as.numeric(v_factor)
v_factor_to_num
v_character <- c("사과", "복숭아", "사과", "오렌지", "사과", "오렌지", "복숭아")
v_factor <- factor(v_character, levels = c("사과", "복숭아"))

v_factor
v_factor <- factor(v_character, levels = c("사과", "복숭아", '오렌지'))
v_factor

v_factor <- factor(v_character, levels = c("복숭아", "오렌지", "사과"))
v_factor

ex_label <- c("하하", "중하", "중", "중상", "상상")

ordered_factor <- factor(ex_label, ordered=T)
ordered_factor

factor(ex_label, levels = c("하하", "중하", "중", "중상", "상상"), ordered=T)

v_num <- c(1000,2000,1000,2000,3000,2000,3000)
v_num_factor <- factor(v_num)
v_num_factor

as.numeric(v_num_factor)
v_char <- as.character(v_num_factor)
v_char

v_num <- as.numeric(v_char)
v_num

ex_trans <- c(1,0,1,0,0,0)
as.character(ex_trans)
as.logical(ex_trans)

t_vector <- c(11,12,13,14,15,16,17,18,19,20)
t_vector
t_vector[3]
idx <- c(1,3,5,6)
t_vector[idx]
t_vector[c(1,3,5,6)]

t_vector
t_vector[c(1,3,5,6)]
t_vector[c(6,5,3,1)]
seq_vector <- 3:7
seq_vector

seq_vector <- 51:100
seq_vector

seq_vector[30:40]
seq(from=10, to=20, by=2)
seq(from=20, to=10, by=-2)

t_vector <-c(11,12,13,14,15)
logical_idx <- c(F,F,T,F,F)
t_vector[logical_idx]
t_vector[c(F,F,T,F,F)]
t_vector[c(F,F,T,T,F)]

t_vector
t_vector <= 3
t_vector > 3
t_vector[t_vector <= 12]
t_vector[t_vector > 12]

vector_m <- c(1,2,3,4,5)
vector_m

vector_m[3] <- 10
vector_m

vector_m[c(2,4)] <- 9
vector_m

vector_m[vector_m >5] <-3
vector_m

vector_m[2:5] <- 0
vector_m
vector_m
vector_m <- 1
vector_m

vector_m <-c(1,2,3,4,5)
length(vector_m)

vector_m[1:length(vector_m)] <- 1
vector_m

v_add <- c(1,2,3,4,5)
v_add <- c(0, v_add)
v_add
v_add <- c(c(-2,-1), v_add)
v_add
v_add <-c(v_add,6)
v_add
v_add <-c(v_add, 7:10)
v_add
t_add1 <- c(1,2,3)
t_add2 <- c(4,5,6)
t_add3 <- c(7,8,9)

new_add <- c(t_add1, t_add2, t_add3)
new_add

vector_a <- c("A", "B", "C", "F", "G")
vector_b <- c("D", "E")

append(vector_a, vector_b, 3)
vector_a

t_vector[c(1,3,5,6)]
t_vector[-c(1,3,5,6)]
length(t_vector)
t_vector[-length(t_vector)]

logical_var <- c(FALSE, TRUE, TRUE, FALSE, FALSE)
logical_var
!logical_var

v_str <- c("첫째", "둘째", "셋째", "넷째", "다섯째")
v_str

v_str[logical_var]
v_str[!logical_var]

a <- c(1,2,3,4)
b <- c(5,6,7,8)

c <- a+b
c

c <- a-b
c

c <- a*b
c
a <- c(1,2,3,4)
b <- c(5,6)

c <- a+b
c

c <- b+a
c
c <- a-b
c

c <- a*b
c

a <- c(1,2,3,4)
c <- a*2
c

b <- c(2)
c <- a*b
c

b <- c(2,2,2,2)
c <- a*b
c

a <- c(1,2,3,4)
b <- c(1,2)

print(a+b)

a <- c(1,2,3,4)
b <- c(1,2,3)

print(a+b)
