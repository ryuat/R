install.packages("neuralnet")
library(neuralnet) # MLP 운영 시 역전파 알고리즘을 


iris$Species2 <- ifelse(iris$Species == 'setosa', 1 , 
                        ifelse(iris$Species == 'versicolor',2, 3))


set.seed(123)
idx <- sample(1:nrow(iris), 0.7 * nrow(iris))
iris

train_y <- iris[idx, 6]
train <- iris[idx,-5]
test_y <- iris[-idx, 6]
test <- iris[-idx,-5]

dim(train); dim(test)

func <- function(x){
  num <- (x-min(x))
  mm <- (max(x)-min(x))
  return(num/mm)
}

test

#정규화
train <- as.data.frame(lapply(train, func))
test <- as.data.frame(lapply(test, func))

train$Species2 <- train_y
train$Species2 <- test_y
train
# 모델링 ( nn에서는 formula 컬럼 나열 )
model <- neuralnet(Species2 ~ Sepal.Length + Sepal.Width +Petal.Length+ Petal.Width, data=train, hidden=1)

install.packages("NeuralNetTools")
library(NeuralNetTools)
plotnet(model)
plot(model)
# 분류 예측
model_result <- compute(model, test[c(1:4)])

str(model_result)
names(model_result)

model_result
head(model_result$net.result)
tail(model_result$net.result)

# 상관관계
cor(model_result$net.result, test$Species2) #  0.9713399801


func <- function(x){
  if(2.5 <x && x  <= 4){
    return(3)
  }else if (1.5<x && x <= 2.5){
    return(2)
  }else if(-1 < x && x <= 1.5){
    return(1)
  }
}

pred <- model_result$net.result
result <- apply(pred, 1,func)

t <- table(result, test_y)
sum(diag(t))/nrow(pred)


# 모델 성능 향상( 실패 )
model2 <- neuralnet(Species2 ~ Sepal.Length + Sepal.Width +Petal.Length+ Petal.Width,
                   data=train, hidden=1, algorithm="backprop", 
                   learningrate = 0.01)
plot(model2)

model_result2 <- compute(model2, test[c(1:4)])
pred2 <- model_result2$net.result


pred2 <- apply(pred2, 1,func)
t<-table(pred2, test_y)
sum(diag(t))/length(pred2)

pred2
