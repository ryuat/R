install.packages("ggvis")
library(ggvis) # 시각화 관련 라이브러리

# 종에 영향을 크게 미칠 것으로 예상되는 petal length와 width를 시각화 %>% pipeline 
iris %>% ggvis(~Petal.Length, ~Petal.Width, fill=~factor(Species))

# 데이터 정규화 ( KNN에서 사용할 거리 단위를 동일하게 )
  # (요소값 - 최소값) / (최대값 - 최소값)  
    # (최대-최소를 1단위로 정규화)

func <- function(x){
  num <- (x-min(x))
  mm <- (max(x)-min(x))
  return(num/mm)
}

# test 간단한 숫자 벡터를 정규화해보기 (위에서 만든 함수 사용)
test_df <- data.frame(x=c(1,2,3,4,5))
func(test_df)

lapply(test_df,func)

#  iris 데이터를 정규화하기 
normal_d <- as.data.frame(lapply(iris[1:4],func))
head(normal_d)
summary(normal_d)

# 정규화된 iris 데이터를 data frame으로 생성
df <- data.frame(normal_d, Species=iris$Species)
head(df)

# train/test data 생성
set.seed(123)
idx <- sample(1:nrow(df), 0.7 * nrow(df))
train <- df[idx,]
test <- df[-idx,]
dim(train); dim(test)

# KNN 수행 
library(class)
result <- knn(train=train[,-5], test=test[,-5], cl=train$Species
             ,k=3) # cl: train class factor , # k는 참고할 이웃 수 

result
summary(result)
t <- table(result, test$Species)
accuracy <- sum(diag(t))/length(result)
accuracy

library(gmodels)

CorssTable(x=test$Species, y=model, prop.chisq=F)

# 최적의 k값 찾기
model <- knn(train=train[,-5], test = test[,-5], 
             cl=train$Species, k=11)
k=seq(from=3, to=13, by=2)

result<-c()
for(i in k){
  m <- knn(train=train[,-5], test = test[,-5], 
           cl=train$Species, k=i)
  t<- table(m, test$Species)
  acc <- sum(diag(t))/length(test$Species) # 정확도 
  result <- c(result, acc) # 정확도를 붙이기 
}

result
acc_df <- data.frame(k = k, acc = result)
acc_df
