imdb <- read.csv("~/STA/Must R/IMDB-Movie-Data.csv")

str(imdb)
head(imdb)
summary(imdb)

## missing value ##
# check missing value 
is.na(imdb$Metascore) # True or False
sum(is.na(imdb$Metascore)) # the number of null value
colSums(is.na(imdb)) # all null value

# drop the missing value
imdb2 <- na.omit(imdb) # drop all rows with null values
colSums(is.na(imdb2)) # 0 

imdb3 <- imdb[complete.cases(imdb[ ,12]), ] # 벡터 의미
colSums(is.na(imdb3))

# replace missing values
imdb$Metascore2 <- imdb$Metascore # copy Metascore into Metascore2
imdb$Metascore2[is.na(imdb$Metascore2)] <- 58.99 # replace missing values with 58.99

# analysis without missing values
mean(imdb$Revenue..Millions.) # NA(Not Available): missing values
mean(imdb$Revenue..Millions.,na.rm = TRUE) # mean withouth NA

# is revenue is normal distribution? NO!
library(ggplot2)

ggplot(imdb, aes(x=Revenue..Millions.)) +
  geom_histogram(binwidth = 15)

## outlier ##
# check outliers
# check how the plots are different
ggplot(imdb, aes(x=as.factor(Year), y=Revenue..Millions.))+
  geom_boxplot(outlier.colour = 'red')

ggplot(imdb, aes(x=Revenue..Millions.))+
  geom_boxplot(outlier.colour = 'red')

# deal with outliers
summary(imdb$Revenue..Millions.)
# 1st quantile
q1 <- quantile(imdb$Revenue..Millions., probs = c(.25), na.rm = TRUE)
# 3rd quantile
q3 <- quantile(imdb$Revenue..Millions., probs = c(.75), na.rm = TRUE)

lc <- q1 - 1.5 * (q3 - q1) # lower whisker
uc <- q3 + 1.5 * (q3 - q1) # upper whisker

imdb2 <- subset(imdb, Revenue..Millions. > lc & Revenue..Millions. < uc )

# check outliers for the second time
ggplot(imdb2, aes(x=as.factor(Year), y=Revenue..Millions.))+
  geom_boxplot(outlier.colour = 'red')