# assign and logic
A <- 2
A
A == 2
A != 2

# c()
a = c(1,2,3,4,5)
a

# req, seq
x1 = c(1:10)
x2 = seq(1,10,2)
x1
x2
y = rep(1,10)
y

df = data.frame(X = x1, Y = y)
head(df)

for (i in a) {
  print(i)
}

a[2]
a[1:4]
a[-3]
a[c(1,2,4,5)]

df[1,]

x = seq(1,10)
xx = c(1,2,3,4,5,6,7,8,9,10) 

str(x)
str(xx)

x1 = as.integer(x)
str(x1)
summary(x1)

x2 = as.numeric(x)
str(x2)
summary(x)

x3 = as.factor(x)
str(x3)
summary(x3)

xx3 = as.factor(xx)
str(xx3)
summary(xx3)

x4 = as.character(x)
str(x4)
summary(x)

sample(1:45, 6, replace = F)

set.seed(1234)
sample(1:45, 6, replace = F)

list = seq(1,30,2)
space = c()
for (i in list) {
  space = c(space, i) # save i in the space
  
}
space
list

a = c(1,2,3,4,5)
if(7 %in% a) {
  print("TRUE")
} else {
  print("FALSE")
}

plusone <- function(x) {
  y = x + 1
  return(y)
}

plusone(1003)

hr <- HR_comma_sep

head(hr)
str(hr)
summary(hr)

summary(hr$left)

hr$Work_accident <- as.factor(hr$Work_accident)
hr$left <- as.factor(hr$left)
hr$promotion_last_5years <- as.factor(hr$promotion_last_5years)

summary(hr$left)

## filter and assign values 
hr$satisfaction_level_group1 <- ifelse(hr$satisfaction_level> .5, 'High', 'Low')
hr$satisfaction_level_group2 <- ifelse(hr$satisfaction_level> .8, 'High',
                                       ifelse(hr$satisfaction_level>.5, 'Mid', 'Low'))

## extract data into a new data frame
hr_high = subset(hr, salary == 'high')
hr_high_IT <- subset(hr, salary == 'high' & department == 'IT') # and
hr_high_IT2 <- subset(hr, salary == 'high' | department == 'IT') # or

# making new dataset from hr (study more...)
install.packages("plyr")
library(plyr)

ss <- ddply(hr, 
            c("department","salary"), summarise, # department, salary별로 요약값 계산 
            m_sf = mean(satisfaction_level), # mean of satisfaction level
            count = length(department), # count the number of workers of department
            m_wh = round(mean(average_montly_hours),2)) # mean of avrage monthly hours
