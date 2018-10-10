# svm의 이해

set.seed(1)
x <- matrix(rnorm(20*2), ncol=2)
x

y 
  
y <- c(rep(-1,10), rep(1,10))
y
x[y==1,] <- x[y==1,] + 1 # x의 뒷10개 1을 더한다.??
x
3-y

plot(x,col=3-y) 
library(e1071)

dat <- data.frame(x=x, y=as.factor(y))
dat 

svmfit <- svm(y~ ., data=dat, kernel= 'linear', cost=0.1, scale=F)
svmfit

plot(svmfit, dat)

attributes(svmfit) # 모델이 가진 속성 확인

svmfit$index # 서포트 벡터 : 초평면을 구성하는 데 영향을 준 관측값 

# tune() : best cost 얻기
tune_out <- tune(svm, y~., data= dat , kernel='linear', 
                 ranges=list(cost = c(1e-22, 1e-15, 1, 100)))
summary(tune_out)

bestmod <- tune_out$best.model
bestmod


# 예측하기
xtest <- matrix(rnorm(20*2 ), ncol=2)
xtest
ytest <- sample(c(-1,1), 20, rep=T)
testdat <- data.frame(x=xtest, y=as.factor(ytest))
testdat

pred <- predict(bestmod, testdat)
table(실제값=testdat$y, 예측값=pred)

(11+3) / nrow(testdat)

