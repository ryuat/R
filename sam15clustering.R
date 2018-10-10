# iris dataset으로 계층적 군집분석

library(cluster)
idist <- dist(iris[,1:4])
idist # 거리계산 ?

rect.hclust(hc, k=4, border = "red")
hc <- hclust(idist) # 분류 (완전연결법, 유클리드 거리)
hc
plot(hc, hang=-1)

  # 4개의 그룹으로 나누기( plot )
k = length(unique(iris$Species))
rect.hclust(hc, k=k, border = "red")

  # 군집 나누기 ( 데이터 )
ghc <- cutree(hc, k=k)
ghc

iris$ghc <- ghc
tail(iris)

# 요약 통계량
g1 <- subset(iris, ghc==1)
g2 <- subset(iris, ghc==2)
g3 <- subset(iris, ghc==3)

summary(g1)
summary(g2)
summary(g3)
