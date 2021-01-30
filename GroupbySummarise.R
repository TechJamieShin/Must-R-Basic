library(dplyr)

data <- read.csv("https://raw.githubusercontent.com/guru99-edu/R-Programming/master/lahman-batting.csv") %>%
  select(c(playerID, yearID, AB, teamID, lgID, G, R, HR, SH))  %>% 
  arrange(playerID, teamID, yearID)

# %>% ok, % > % not ok

str(data)
glimpse(data)

summarise(data, mean_run = mean(R))
summarise(data, mean_names = mean(G), mean_SH = mean(SH, na.rm = TRUE))

# group_by 
data %>%
  group_by(lgID) %>%
  summarise(mean_run = mean(HR))

## continue later...#