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

pred <- predict(model, newdata=test)

pred
table(pred, test$Species)

confusionMatrix(pred, test$Species) 
