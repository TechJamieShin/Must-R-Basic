# change the value from char to factor
hr$salary <-as.factor(hr$salary)

str(hr$salary)
str(hr$satisfaction_level)

# sammary of salary -> the number of each factors
summary(hr$salary)
summary(hr$satisfaction_level)

# quantile (10%, 30%, 60%, 90%)
quantile(hr$satisfaction_level, probs = c(.1, .3, .6, .9))

# calculation
sum(hr$satisfaction_level)
mean(hr$satisfaction_level)
sd(hr$satisfaction_level)

colMeans(hr[1:5]) # means of columns (first to fifth)
colSums(hr[1:5]) # sums of columns (first to fifth)
