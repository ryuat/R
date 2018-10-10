# 종속 변수를 숫자로 바꾸지 않고 그대로 사용하여 예측하기  
library(neuralnet)

set.seed(123)
idx <- sample(1:nrow(iris), 0.7*nrow(iris))
train <- iris[idx,]
test <- iris[-idx,]
dim(train); dim(test);

train <- cbind(train, train$Species == "setosa")
train <- cbind(train, train$Species == "versicolor")
train <- cbind(train, train$Species == "virginica")
head(train,2)

names(train)[6:8] <- c("setosa", "versicolor","virginica")
head(train,3)

model <- neuralnet(setosa + versicolor + virginica ~ 
                     Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
                   data=train, hidden=2)

plot(model)

# 예측 
comp <- compute(model, test[-5])
comp
pred_weight <- comp$net.result
head(pred_weight)

pred_weight
apply(pred_weight,1,max)

idx <- apply(pred_weight,1,which.max) # 해당 행에서 제일 큰 값의 위치 
idx 

pred <- c("setosa", "versicolor","virginica")[idx]
pred

sum(diag(table(pred, test$Species)))/length(pred)


# 새로운 데이터로 분류 수행 

