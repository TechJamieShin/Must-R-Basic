str(hr)

library(ggplot2)

# basic graph with ggplot
ggplot(hr, aes(x=salary)) +
  geom_bar()

# adding other features
ggplot(hr, aes(x=salary)) +
  geom_bar(fill = 'royalblue')

ggplot(hr, aes(x=salary)) +
  geom_bar(aes(fill=left)) # color according to 'left'

ggplot(hr, aes(x=salary)) +
  geom_bar(aes(fill=department)) + # color according to 'department'
  labs(fill = "Divided by department") # legend

ggplot(hr, aes(x=salary)) +
  geom_bar(aes(fill=left)) + # color according to 'department'
  labs(fill = "Divided by department") + # legend
  xlab("봉급") + ylab("")

# histogram 
ggplot(hr, aes(x=satisfaction_level)) + 
  geom_histogram() 

# `stat_bin()` using `bins = 30`. Pick better value with `binwidth`
ggplot(hr, aes(x=satisfaction_level)) + 
  geom_histogram(binwidth = 0.02, fill='royalblue') 

# density plot
ggplot(hr, aes(x=satisfaction_level)) + 
  geom_density()

ggplot(hr, aes(x=satisfaction_level)) + 
  geom_density(col='red', fill='royalblue')

# box plot
ggplot(hr, aes(x=left, y=satisfaction_level)) +
  geom_boxplot(aes(fill = left)) +
  xlab("Employment change") +
  ylab("Satisfaction level") +
  ggtitle("Boxplot") +
  labs(fill = "Left")

ggplot(hr, aes(x=left, y=satisfaction_level)) +
  geom_boxplot(aes(fill = salary), alpha = I(0.4), outlier.color = 'red') +
  xlab("Employment change") +
  ylab("Satisfaction level") +
  guides(fill = guide_legend(reverse = FALSE)) +
  ggtitle("Boxplot") +
  labs(fill = "Salary")

# scatter plot
ggplot(hr, aes(x=average_montly_hours, y=satisfaction_level)) +
  geom_point(aes(col = left)) +  # change the colors according to the 'left'
  labs(col = 'Employment change') + 
  xlab("Average working hours") +
  ylab("Satisfaction level")
