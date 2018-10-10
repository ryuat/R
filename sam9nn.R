# 인공신경망 (ANN)

df <- data.frame(
  x1 = c(1:6),
  x2 = c(6:1),
  y = factor(c('y', 'y','n','n', 'y','y'))
)
df

library(nnet)
df
df$y
# neural network with single hidden layer
model_net1 <- nnet(y~.,df, size=2) # size : hidden layer 내 unit의 수  

model_net1$fitted.values # train 예측값 
summary(model_net1) # 모델 확인 

# 모델 시각화
library(devtools)

par("mar")
par(mar=c(1,1,1,1)) # margin too large err 발생 시

  # 모델 시각화에 필요한 코드 (?)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(summary(model_net1))


# 분류 예측
df
model_net1$fitted.values
predict(model_net1, df)
pred <- predict(model_net1, df, type="class") # 범주형으로 리턴
table(pred, df$y)
