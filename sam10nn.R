# ANN iris data set 

library(nnet)

set.seed(123)

 
idx <- sample(1:nrow(iris), 0.7 * nrow(iris))

train <- iris[idx,]
test <- iris[-idx,]

dim(train)
dim(test)

model_net1 <- nnet(Species ~., train, size=1)
model_net3 <- nnet(Species ~., train, size=120)
model_net1
summary(model_net1)

install.packages("NeuralNetTools")
library(NeuralNetTools)
plotnet(model_net1)
plotnet(model_net3)

# 분류 모델 평가 
pred <- predict(model_net1, test, type="class")
t <- table(pred, test$Species)
t
sum(diag(t))/nrow(test)
nrow(test)


pred3 <- predict(model_net3, test, type="class")
t3 <- table(pred3, test$Species)
t3
sum(diag(t3))/nrow(test)
nrow(test)
