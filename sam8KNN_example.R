# KNN 분류모델로 토마토는 소속이 어디일까? 확인하기



# food dataframe

ingredient <- c("apple", "bacon", "banana", "carrot","celery", "cheese", "cucumber", "fish",
                
                "grape", "green bean", "lettuce","nuts", "orange", "pear","shrimp")

sweetness <- c(10,1,10,7,3,1,2,3,8,3,1,3,7,10,2)

crunchiness = c(9,4,1,10,10,1,8,1,5,7,9,6,3,7,3)

class = c("Fruits","Proteins","Fruits","Vegetables","Vegetables","Proteins","Vegetables",
          "Proteins","Fruits","Vegetables","Vegetables","Proteins","Fruits","Fruits","Proteins")



food <- data.frame(ingredient = ingredient,
                   
                   sweetness = sweetness,
                   
                   crunchiness = crunchiness,
                   
                   class = class)

food



tomato <- data.frame(ingredient = "tomato", sweetness = 6, crunchiness = 4)

tomato



library(ggplot2)



par(pty="s")   # par : 파라미터 지정 / pty : plot모형을 "square" 정사각형



#par:파라미터, xpd:모형옮기기, mar:여백설정(아래,왼쪽,위,오른쪽)

par(xpd = T, mar = par()$mar + c(0,0,0,15)) 



plot(food$sweetness,food$crunchiness,
     
     pch=as.integer(food$class),
     
     xlab = "sweetness", ylab = "crunchiness", 
     
     main = "What is tomato class?")

#속성 : pch=food$class,  pch는 모형 지정



# legend 위치 지정 

legend(10.5, 10, c("Fruits", "Proteins", "Vegetables", "X"), pch=as.integer(food$class))



text(food$sweetness, food$crunchiness, 
     
     labels = food$ingredient, pos = 3, offset = 0.3, cex = 0.7 ) 

# 속성 : pos 글자위치 (1:below, 2:left, 3:above, 4:right), offset 좌표와 얼마나 띄어쓰기, cex 문자크기



ggplot(data=food,aes(x=sweetness,y=crunchiness)) +
  
  labs(title="What is tomato class?") + 
  
  geom_point(aes(color=class, shape=class),size=6) +
  
  geom_text(aes(label=ingredient), 
            
            vjust=-1, size = 5) 

# 속성 : vjust(수직으로 움직일 거리 (위는 -, 아래는 +), size(문자크기)



#install.packages("dplyr")  #contains knn()

library(class) 

library(dplyr)



# k=1로 두었을 때, 토마토만 예측

# 유클레디안 측정 knn 분류

tmt <- knn(select(food, sweetness, crunchiness), 
           
           select(tomato,sweetness, crunchiness), 
           
           food$class, k=1)

tmt  #결과 : Fruits



# 데이터프레임 만들기

# 포도, 완두콩, 오렌지, 토마토를 통해서 예측하기

unknown_data <- data.frame(ingredient = c("grape", "green bean", "orange","tomato"),
                           sweetness = c(8,3,7,6), 
                           crunchiness = c(5,7,3,4))
unknown_data



# 포도, 완두콩, 오렌지, 토마토를 통해서 k=3으로 예측

pred <- knn(select(food, sweetness, crunchiness), 
          
            select(unknown_data, sweetness, crunchiness), 
            
            food$class, k=3)

pred  #결과 : Fruits Vegetables Fruits Fruits   