library(arules)
customer <- read.csv("C:/work/rsou/pro3/testdata/priori_data.csv", stringsAsFactors =F)
customer

customer_list <- split(customer$sangpum, customer$irum)
customer_list

customer_tran <- as(customer_list, "transactions")
customer_list <- sapply(customer_list, unique) # 중복제거 

customer_tran <- as(customer_list, "transcations")
customer_tran
inspect(customer_tran)
summary(customer_tran)

itemFrequency(customer_tran) # 구매빈도 
itemFrequencyPlot(customer_tran, support = 0.3) # 빈도 0.3 이상인 데이터만 
itemFrequencyPlot(customer_tran, topN = 5) # top 5개 

# 연관규칙 생성
customer_rule <- apriori(customer_tran, parameter = list(supp=0.1))
customer_rule <- apriori(customer_tran)
?apriori
summary(customer_rule)
inspect(customer_rule)

customer_rule <- apriori(customer_tran, parameter = list(supp=0.2, confidence=0.2))
inspect(customer_rule)
inspect(sort(customer_rule, by="lift", decreasing = F)[1:5])
inspect(subset(customer_rule, items %in% c("맛동산", "짱구")))

# 시각화
install.packages("arulesViz")
library(arulesViz)
plot(customer_rule)
plot(customer_rule, method="grouped")
plot(customer_rule, method="graph", control = list(type="items"))
plot(customer_rule, method="graph", engine='interactive')



# 연관분석용 식료품 구매 관련 sample data
data("Groceries")
gdf <- as(Groceries, "data.frame")
head(gdf)

rules <- apriori(Groceries, parameter = list(supp=0.001, conf=0.8))
inspect(rules)

plot(rules, method="grouped")


rules <- apriori(Groceries, parameter = list(supp=0.001, conf=0.8, maxlen=3))
inspect(rules)

so <- sort(rules, decreasing = T , by = "confidence")
inspect(so)

library(arulesViz)
plot(so,method="graph", control = list(type="items"))

wmilk <- subset(so, rhs %in% 'whole milk') # whole milk 데이터만 따로 
inspect(wmilk)
plot(wmilk,method="graph", control = list(type="items"))

veg <- subset(so, rhs %pin% c("other vegetables"))
plot(veg, method="graph")

