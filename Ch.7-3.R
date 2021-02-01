library(ggplot2)
str(STOCK)

Graph <- ggplot(STOCK) +
  geom_histogram(aes(x = Open), binwidth = 1000, 
                 fill = "royalblue", alpha = .4) +
  theme_bw() +
  xlab("Open") +
  ylab("") +
  ggtitle("Histrogram")

Graph

# change theme : theme_bw, _classic, _dark, _light (background color)
Graph + theme_dark()

Graph + theme_linedraw()
Graph + theme_minimal()
Graph + theme_test()
Graph + theme_void()

library(ggthemes)

Graph + theme_wsj()

# change legend
Graph2 <- ggplot(STOCK) +
  geom_histogram(aes(x = Open, fill = Year), binwidth = 1000, alpha= .4) + # fill!!
  theme_bw() +
  xlab("Open") +
  ylab("") +
  ggtitle("Histrogram")

Graph2

Graph2 + labs(fill = "Year!") # name of legend

Graph2 + theme(legend.position = "top") # position of legend
Graph2 + theme(legend.position = "left")
Graph2 + theme(legend.position = c(.85, .7))# 85% of axis X and 70% of axis Y

# change axis 
Graph2 + scale_x_continuous(breaks = seq(0,70000, by=10000))
Graph2 + scale_x_continuous(breaks = NULL)
Graph2 + scale_x_continuous(limits = c(0,50000)) # range of x axis 


Graph3 <- ggplot(Group_Data) +
  geom_bar(aes(x=Year, y=Mean, fill = Year), stat = "identity",
           alpha = .4) +
  theme_classic()
Graph3

Graph3 + scale_x_discrete(label=c("'12", "'13", "'14", "'15", "'16")) + # x axis
  scale_fill_discrete(label=c("'12", "'13", "'14", "'15", "'16")) # legend

# skip changing color and fonts 

# separate of plots
Graph2 + facet_wrap(~ Year, ncol = 1)
# change x axis and y axis
Graph2 + coord_flip()

# Bar Chart 

