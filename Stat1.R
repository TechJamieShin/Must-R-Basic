library(ggplot2)
K = c(10, 100, 1000, 10000, 10000)

for (k in K) {
  PROB_LIST = c()
  for (i in 1:k) {
    BI = sample(c("H", "T"), size = 200,
                replace = T, prob = c(.5 ,.5))
    PROB = ifelse(BI == "H", 1, 0)
    PROB = sum(PROB) / 200
    PROB_LIST = c(PROB_LIST, PROB)
  }
  CLT = data.frame(PROB = PROB_LIST)
  graph = ggplot(CLT, aes(x=PROB)) +
    geom_bar(fill = 'royalblue', alpha= .3)
  ggsave(file = paste("/Users/jeongminshin/STA/Must R", k, '.jpg', sep = ""))
}
