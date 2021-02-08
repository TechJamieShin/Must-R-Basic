str(HR)
HR$left = as.factor(HR$left)

# 1. Homegeneity of Variance Test (등분산검정)
# H0: s1 = s2, H1: s1 =/= s2 (left0 and left1)

library(car)

# Levene's Test
leveneTest(satisfaction_level ~ left, data = HR)
# F value = 122.4, Pr(>F) = < 2.2e-16 (< alpha = .05)
# can reject H0

# 2. t test 
# H0: mu1 = mu2, H1: mu1 =/= mu2
# when homegeneity of variance
t.test(satisfaction_level ~ left, data = HR, var.equal = T)

# when heteroscedasticity of variance
t.test(satisfaction_level ~ left, data = HR, var.equal = F) # p-value < 2.2e-16
# can reject H0
