# 비계층적 군집분석 : 군집수를 파악 후 모델 생성
# k-means clustering 
iris_s <- scale(iris[-5]) # 정규화 
iris_s

head(iris_s)
?scale

# 군집의 개수를 확인 
?kmeans
install.packages("NbClust")
library(NbClust)

nc <- NbClust(iris_s, min.nc = 2, max.nc=10, method="kmeans")
nc
plot(table(nc$Best.nc[1,]))

  # 3이 best (?)
# best 군집 개수를 centers 로 주고 kmeans 수행 
iris_k <- kmeans(iris_s, centers = 3, iter.max=100) # centers: 군집 크기 
iris_k
names(iris_k)
table(iris_k$cluster)

# kmeans 결과 시각화 
plot(iris[c("Sepal.Length", "Sepal.Width")], col=iris_k$cluster)

# 원래 Species
plot(iris[c("Sepal.Length", "Sepal.Width")], col=iris$Species)


# pam 알고리즘을 활용하여 군집분석
library(cluster)
iris_p <- pam(iris_s, k=3)

plot(iris[c("Sepal.Length", "Sepal.Width")], col=iris_p$cluster)
table(iris_p$clustering)
clusplot(iris_p)
