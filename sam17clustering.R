df <- read.csv("C:/work/rsou/pro3/testdata/exam.csv", sep=" ", header=T)
df
ddf <- dist(df[-1])
ddf

# 거리를 그림으로 표현
gra_df <- cmdscale(ddf) # 2차원 좌표 상에서 표현되도록 
gra_df
plot(gra_df, type="n")
text(gra_df, as.character(1:10))

df$avg <- apply(df[,2:5],1,mean)
kmodel <- kmeans(df[,c("avg")], centers=4)
kmodel

table(kmodel$cluster)

cluster <- kmodel$cluster
cluster

kmeans_df <- cbind(df, cluster) # cluster를 df 에 붙임 
kmeans_df
str(kmeans_df)

kmeans_df <- transform(kmeans_df, cluster = as.factor(cluster)) # cluster 열을 factor로 변환 
str(kmeans_df) 
kmeans_df
library(ggplot2)

df_plot <- ggplot(data=kmeans_df, aes(x=bun,y=avg, color=cluster)) +
            geom_point(aes(shape=factor(cluster)), size=4) +
            ggtitle("Kmeans")
df_plot
