library(dplyr)

STOCK <- Uniqlo_stocks2012.2016

STOCK$Date <- as.Date(STOCK$Date)
STOCK$Year <- as.factor(format(STOCK$Date, "%Y"))
STOCK$Day <- as.factor(format(STOCK$Date, "%a"))
# %a = monday, friday.. %d = date of the day

str(STOCK)

# when R is not working, re start it #
Group_Data = stock %>%
  group_by(Year,Day) %>%
  summarise(Mean = round(mean(Open)), # from here
            Median = round(median(Open)),
            Max = round(max(Open)),
            Counts = length(Open))

head(Group_Data)

Ungroup_Data <- Group_Data %>%
  ungroup()

head(Ungroup_Data)

## extract data : fileter(), subset()
subseted_data <- Group_Data %>%
  filter(Year == "2012")

head(subseted_data)

# drop duplacated data: distict()
SL <- sample(1:nrow(Group_Data), 500, replace = TRUE)
Duplicated_Data <- Group_Data[SL, ] # what is this?

dim(Duplicated_Data)

Duplicated_Data2 <- Duplicated_Data %>%
  distinct(Year, Day, Mean, Median, Max, Counts)

dim(Duplicated_Data2)

# extract random sample data: sample_frac(), sample_n()
Sample_Frac_Gr <- Group_Data %>%
  sample_frac(size = .4, replace = FALSE) # size?

Sample_Frac_Gr

Sample_Frac_Un <- Ungroup_Data %>%
  sample_frac(size = .4, replace = FALSE)

Sample_Frac_Un


Sample_N_Gr <- Group_Data %>%
  sample_n(size = 2, replace = F)

Sample_N_Gr

Sample_N_Un <- Ungroup_Data %>%
  sample_n(size = 10, replace = F)

Sample_N_Un
## GROUP_BY !!!!!!!!!!! ###

# extract data according to index : slice(), top_n()
Slice_Data <- Ungroup_Data %>%
  slice(1:10)

Slice_Data

Top_n_Data <- Ungroup_Data %>%
  top_n(5, Mean) # Top 5 of mean value
Top_n_Data

# arrange data : arrange()
Asce_Data <- Ungroup_Data%>%
  arrange(Mean) # arrange data according to the mean value

Asce_Data

Desc_Data <- Ungroup_Data %>%
  arrange(-Mean)

Desc_Data

# select specific column : select(), select_if()
Select_Data <- Group_Data %>%
  select(1:2)
Select_Data

Select_Data <- Group_Data %>%
  select(Year, Day)
Select_Data

Select_If_Data1 <- Group_Data %>%
  select_if(is.factor)
Select_If_Data1

Select_If_Data2 <- Group_Data %>%
  select_if(is.integer)
Select_If_Data2

# make new variables(column): mutate(), mutate_if(), mutate_at()
Mutate_Data <- STOCK %>%
  mutate(Divided = round(High/Low, 2)) %>%
  select(Date, High, Low, Divided)
head(Mutate_Data)

Mutate_If_Data <- STOCK %>% # apply formula to all columns
  mutate_if(is.integer, as.numeric)
str(Mutate_If_Data)

Mutate_At_Data <- STOCK%>% # apply formula to specific columns
  mutate_at(vars(-Date, -Year, -Day), log)%>% # except for Date, Year, Day
  select_if(is.numeric)
head(Mutate_At_Data)
