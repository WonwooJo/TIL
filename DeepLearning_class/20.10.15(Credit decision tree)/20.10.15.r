# 채무 불이행 분류문제 
credit<-read.csv("data/credit.csv")
str(credit)

table(credit$checking_balance) # 계좌 잔고
table(credit$savings_balance) # 저축 계좌 잔고

summary(credit$months_loan_duration) # 대출 기간
summary(credit$amount) # 대출금
# 대출금 250~18424, 중앙값 2320, 평균 3271

table(credit$default) # 채무불이행 여부

# 훈련 90%, 테스트 10%로 구성하자.

# random sampling 하는데 쓰는 함수
set.seed(123)
sample(10,5) # 1~10까지 숫자 중 5개의 난수 출력

trainSample<-sample(1000,900)
str(trainSample)

str(credit)

# 900개 난수에 맞는 데이터 출력력
creditTrain<-credit[trainSample,] # 900개 랜덤데이터
creditTest<-credit[-trainSample,] # 100개 랜덤데이터

table(creditTrain$default) 
table(creditTest$default) 

#### 의사결정트리(decision tree) 만들자!

# install.packages('C50')
library(C50)

str(credit)
creditTrain$default<-factor(creditTrain$default)
str(creditTrain)

model<-C5.0(creditTrain[-17],creditTrain$default,trials = 50)
model

creditPred<-predict(model, creditTest)
creditPred

library(gmodels)
CrossTable(creditTest$default, creditPred, prop.chisq = FALSE, prop.c = FALSE,
           prop.r = FALSE,
           dnn=c('act default','pred default'))

# information gain을 구한다 
# 분할 전과 후의 복잡도 출력 → entropy
