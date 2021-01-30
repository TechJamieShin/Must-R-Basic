library(dplyr)

STOCK <- Uniqlo_stocks2012.2016

STOCK$Date <- as.Date(STOCK$Date)
STOCK$Year <- as.factor(format(STOCK$Date, "%Y"))
STOCK$Day <- as.factor(format(STOCK$Date, "%a"))
# %a = monday, friday.. %d = date of the day

str(STOCK)

### AGAIAIN ####
Group_Data = stock %>%
  group_by(Year,Day) %>%
  summarise(Mean = round(mean(Open)), # from here
            Median = round(median(Open)),
            Max = round(max(Open)),
            Counts = length(Open))

head(Group_Data)

## extract data 
subseted_data <- Group_Data %>%
  filter(Year == "2012")

head(subseted_data)



