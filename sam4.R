# randomforest: 의사결정나무보다 예측 향상 

install.packages("randomForest")
library(randomForest)

set.seed(123)
idx <- sample(1:nrow(iris), nrow(iris)* 0.7)
train <- iris[idx,]
test <- iris[-idx,]
dim(train)
dim(test)
model <- randomForest(Species ~ ., data=train)
model

model2 <- randomForest(Species ~ ., data=train, ntree=200, mtry=3, na.action=na.omit)
model2

model3 <- randomForest(Species ~ ., data=train, importance = T)

importance(model3) # 높으면 중요한 변수 

pred <- predict(model2, newdata=test)

pred
table(obs = test$Species, predict= pred)

confusionMatrix(pred, test$Species) 

# 최적의 모델을 위한 파라미터값 얻기
ntree <- c(400, 500, 600)
mtry <- c(2:4)
param <- data.frame(n=ntree, m=mtry)
param
for(i in param$n){
  cat('ntree= ',i,'\n')
  for(j in param$m){
    cat('mtry=' ,j, '\n')
    model_test <- randomForest(Species ~ ., data=train, ntree=i, mtry=j, na.action=na.omit)
    print(model_test)
    }
}
