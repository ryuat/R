library(KoNLP)
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_171")
library(rJava) # 형태소 분석용 
txt_data <- file("C:/work/rsou/pro3/testdata/news_data.txt", encoding="UTF-8")
txt_data

t_data <- readLines(txt_data)
t_data

lword <- Map(extractNoun, t_data)
lword

lword <- sapply(lword, unique)
lword

func1 <- function(x){
  nchar(x) <= 4 && nchar(x) >= 2 && is.hangul(x) # 2~4자 사이의 한글만  
}
head(lword)

func2 <- function(x){
  Filter(func1, x)
}

lword <- sapply(lword, func2)
str(lword)

wordtran <- as(lword, "transactions")
inspect(wordtran[1:5])
tranrule <- apriori(wordtran)
inspect(tranrule)

plot(tranrule, method="graph")
