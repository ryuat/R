# 날씨정보로 분류학
library(rpart)

weather <- read.csv("testdata/weather.csv",header=T)
str(weather)
head(weather)

weather_m <- rpart(RainTomorrow ~ ., data=weather[,c(-1,-11)], cp=0.01) # 가지수를 늘리고 줄일 때 cp ? 

x11()
plot(weather_m)
text(weather_m, use.n=T) # 텍스트 추

# 분류예측
pred <- predict(weather_m, weather)
head(pred)

result <- ifelse(pred[,2] > 0.5 , 'YES', 'NO')
result

table(result,weather$RainTomorrow)
