library(e1071)
head(iris)

x <- subset(iris, select=-Species)
y <- iris$Species

svm_model <- svm(Species ~., data=iris)
summary(svm_model1)
svm_model1 <- svm(x,y)
summary(svm_model1)

pred <- predict(svm_model1, newdata=x)
pred
table(y, pred)

sum(diag(table(y,pred)))/length(y)

svm_tune <- tune(svm, train.x = x , train.y = y, ranges = list(cost=10^(-2:2)))
svm_tune

best <- svm_tune$best.model
best


# svm의 다른 방법: ksvm(r로 만든 패키지를 사용)
library(kernlab)

irismodel <- ksvm(Species ~ ., data = iris, prob.model=T)
irismodel

predict(irismodel, iris[c(3,10,56,68,107,120), -5], type="probabilities")

newdata <- iris[c(3),-5]

predict(irismodel, newdata);iris[3,"Species"];

