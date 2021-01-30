install.packages("reshape")
library(reshape)
library(dplyr)
library(plyr)

HR <- HR_comma_sep_2

# apply
print("apply")
head(apply(HR[, 1:2],1,mean))
apply(HR[, 1:2],1,mean) # average of column 1 and 2 
apply(HR[, 1:2],2,mean) # 1-row, 2-column

# dplyr -> pipeline! 
HR[, 1:2] %>%
  rowMeans() %>%
  head()

HR[, 1:2] %>%
  colMeans() %>%
  head()

# %>% -> function(DATA) = DATA %>% function()

apply(HR[, 1:5], 2, mean)
colMeans(HR[, 1:5])
HR[ , 1:5] %>%
  colMeans()

# summarise
summarise(HR, MEAN_SATI = mean(satisfaction_level),
          MAX_SATI = max(satisfaction_level),
          N = length(satisfaction_level))

HR %>%
  summarise(MEAN_SATI = mean(satisfaction_level),
            MAX_SATI = max(satisfaction_level),
            N = length(satisfaction_level))

is.data.frame(HR)

HR2_D <- ddply(subset(HR, left == 1), c("sales"), summarise, 
               MEAN_SATI = mean(satisfaction_level),
               MAX_SATI = max(satisfaction_level),
               N = length(satisfaction_level)
               )

head(HR2_D)  

HR2_D <- HR %>%
  subset(left == 1) %>% 
  group_by(sales) %>% 
  dplyr::summarise(MEAN_SATI = mean(satisfaction_level),
                   MAX_SATI = max(satisfaction_level),
                   N = length(satisfaction_level))

head(HR2_D)  

#add a new column
HR3_D <- HR2_D %>%
  mutate(percent = MEAN_SATI/MAX_SATI)

head(HR3_D)

library(ggplot2)

HR2_D %>%
  ggplot() +
  geom_bar(aes(x=sales, y=MEAN_SATI, fill=sales), stat = "identity") +
  geom_text(aes(x=sales, y=MEAN_SATI+.05,
                label = round(MEAN_SATI, 2))) +
  xlab("Department") + ylab("Average Satisfaction") +
  theme(axis.text.x = element_text(angle = 45, size = 8.5, color = "black",
                                   face = "plain", vjust = 1, hjust = 1))

# drop duplicated data

a <- rep(1:10, each = 2) # repeat 2 times from 1 to 10
print(a)

# drop
unique(a)

# load dataset
dupl <- DUPLICATED

# drop all duplication 
dupl1 <- dupl[-which(duplicated(dupl)),]
dupl1

# drop same name 
dupl2 <- dupl[-which(duplicated(dupl$NAME)), ]
dupl2

# drop same name, id
dupl3 <- dupl[-which(duplicated(dupl[, c('NAME','ID')])), ] # name of variable
dupl3

dupl3_1 <- dupl[!duplicated(dupl[ ,c("NAME", "ID")]), ]
dupl3_1

dupl4 <- dupl[!duplicated(dupl[ ,c(2,3)]), ] # column number
dupl4

# sort data 
dupl$DATE
dupl$DATE = as.Date(dupl$DATE, "%Y-%m-%d")
summary(dupl$DATE)

dupl_sort = dupl[order(dupl[, 'DATE'], decreasing = TRUE), ]

### Reshape package ###
# reshape TEST into variables
library(reshape)
resh <- Reshape
head(resh)

cast_data <- cast(resh, OBS + NAME + ID + DATE ~ TEST)

# as previous data frame
melt_data <- melt(cast_data, id=c("OBS", "NAME", "ID", "DATE"))
melt_data <- na.omit(melt_data)

## merge data ## dupl3 + cast_data
merg <- merge(dupl3, cast_data[ , c(-1,-2,-4)], by = "ID", all.x = TRUE)
head(merg)
