# 맨하탄 거리와 유클리드 거리 계산 연습  - 예로 사용할 데이터는 5명 학생의 영어와 수학 시험 점수

txt1 <- read.csv("testdata/cluster_ex.csv")
txt1
plot(txt1[, c(2:3)],
     xlab='영어', ylab='수학',
     xlim = c(30, 100), ylim = c(30, 100),
     main = "학생점수 산포도")
# 학생들 중 홍길동과 이기자 사이의 거리를 계산해 본다.
# 그래프로 표시
text(txt1[, 2], txt1[, 3], labels = abbreviate(rownames(txt1)), cex = 0.8, pos = 1, col = "blue")
  # abbreviate : 문자열 축약 함수 
text(txt1[, 2], txt1[, 3], labels = txt1[,1] ,cex = 0.8, pos = 2, col = "red")
points(txt1[1, 2], txt1[1, 3], col = "red", pch = 19)
points(txt1[2, 2], txt1[2, 3], col = "red", pch = 19)





# 거리를 계산하기 dist(dataset, method = "...") 함수를 사용하여 맨하탄 거리를 계산할 수 있다. 

# 홍길동과 이기자의 거리를 구해 보겠다.

dist_mht <- dist(txt1[c(1:2),c(2:3)], method = "manhattan")  # 맨하탄 거리로 계산

dist_mht   # 60



dist_euc <- dist(txt1[c(1:2),c(2:3)], method = "euclidean")   # 유클리드 거리 계산

dist_euc   # 50.9902  맨하탄 거리가 가장 길고 유클리드 거리가 그 다음이다.
