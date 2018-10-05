# 분류분석 : decision tree: 가지치기 적용

library(rpart)
set.seed(123)
n <- sample(2, nrow(iris), replace =T, prob=c(0.7, 0.3))
n 
train <- iris[n==1,]
test <- iris[n==2,]

dim(train); dim(test)

install.packages("party")

iris_rpart <- rpart(Species ~., data= train, method='class')

x11()
plot(iris_rpart)
text(iris_rpart)
plotcp(iris_rpart)
printcp(iris_rpart)
# CP값? 이 작은 값
cp <- iris_rpart$cptable[which.min(iris_rpart$cptable[,"xerror"])] # 최선의 cp값 
cp

iris_rpart_prune <- prune(iris_rpart, cp=cp, 'cp') # cp: 가지치기 강도 
plot(iris_rpart_prune)
text(iris_rpart_prune)

# 예측
pred <- predict(iris_rpart_prune, test, type='class')
pred


library(caret)
confusionMatrix(pred, test$Species)
