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

# extract characters 
substr(imdb$Actors[1], 1, 5) # from first row, first letter to fifth letter

# paste char
paste(imdb$Actors[1], "_", "A") # add _ A to the first raw 
paste(imdb$Actors[1], "_", "A", sep = "") # without space
paste(imdb$Actors[1], "_", "Example", sep = "|") # put | between letters

# split char
str(imdb$Actors)
# Actors is Factor so it changes as char for the split
strsplit(as.character(imdb$Actors[1]), split= ",") 

# replace char
# replace , to empty space
imdb$Genre2 <- gsub(",", " ", imdb$Genre)

# TEXT MINING
install.packages("tm")
install.packages("NLP")
library(tm)
library(NLP)

# genre
corpus <- Corpus(VectorSource(imdb$Genre2)) # not corpus(), not vectorsource         
corpus_tm <- tm_map(corpus, removePunctuation) #drop special character
corpus_tm <- tm_map(corpus_tm, removeNumbers) # drop numbers
corpus_tm <- tm_map(corpus_tm, tolower) # lower character

# array of char
tdm <-DocumentTermMatrix(corpus_tm) 
inspect(tdm)

# turn array into data frame 
tdm <-as.data.frame(as.matrix(tdm)) #as.mastix!!!!!
head(tdm)

# combine tdm to imdb
imdb_genre <- cbind(imdb, tdm)

# description
corpus <- Corpus(VectorSource(imdb$Description)) # not corpus(), not vectorsource         
corpus_tm = tm_map(corpus,stripWhitespace)
corpus_tm <- tm_map(corpus_tm, removePunctuation) #drop special character
corpus_tm <- tm_map(corpus_tm, removeNumbers) # drop numbers
corpus_tm <- tm_map(corpus_tm, tolower) # lower character

tdm <-DocumentTermMatrix(corpus_tm) 
inspect(tdm)

corpus_tm <- tm_map(corpus_tm, removeWords, 
                    c(stopwords("en"), "my", "custom", "words"))

tdm <-DocumentTermMatrix(corpus_tm) 
inspect(tdm)

# cope with duplicated words 

# the word is included in sentences: yes 1, no 0
convert_count <- function(x) {
  y <- ifelse(x > 0, 1, 0)
  y <- as.numeric(y)
  y
}

# how many times the word shows up in sentences
convert_count2 <- function(x) {
  y <- ifelse(x > 0, x, 0)
  y <- as.numeric(y)
  y
}

desc_imdb <- apply(tdm, MARGIN = 2, convert_count)
desc_imdb <- as.data.frame(desc_imdb)

desc_imdb2 <- apply(tdm, MARGIN = 2, convert_count2)
desc_imdb2 <- as.data.frame(desc_imdb2)

# visualization
# word cloud
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)

library("SnowballC")
installed.packages("wordcloud")
library("RColorBrewer")
library("wordcloud")


