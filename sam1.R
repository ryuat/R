# 분류분석 : decision tree

set.seed(123)
idx <- sample(1:nrow(iris), nrow(iris)* 0.7)
train <- iris[idx,]
test <- iris[-idx,]
dim(train)

install.packages("party")
library(party)

# 재귀적인 방법
formula <- Species ~.
ir_ctree <- ctree(formula=formula, data = train)

plot(ir_ctree)
plot(ir_ctree, type ="simple")  # 간단한 시각화

# 예측
pred <-predict(ir_ctree,test)
pred
test$Species

library(caret)
confusionMatrix(pred, test$Species)

