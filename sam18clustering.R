# diamond dataset 계층적 / 비계층적 군집분석
library(ggplot2)

diamonds

t <- sample(1:nrow(diamonds), 1000)
head(t)

test <- diamonds[t,]
dim(test)
str(test)
test
mydia <- test[c("price", "carat", "depth")]
head(mydia)

# 계층적 군집분석
result <- hclust(dist(mydia), method="ave")
result

plot(result, hang=-1)

# 비계층적 군집분석
result2 <- kmeans(mydia,centers=4)
result2
names(result2)
result2$size

mydia$cluster <- result2$cluster
tail(mydia)

# 속성들 간 상관관계 분석 
cor(mydia[,-4], method="pearson")
plot(mydia[,-4])

library(corrgram)
corrgram(mydia[,-4], lower.panel=panel.conf)

plot(mydia[c("carat", "price")], col=mydia$cluster)
points(result2$centers[,c("carat","price")], col=c(3,1,2,4), pch=3, cex=3)


install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(mydia[,-4], histogram = , pch= "+")
