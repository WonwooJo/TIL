insurance<-read.csv("data/insurance.csv")
str(insurance)
# 종속변수: expenses (Target)
# 선형회귀는 종속변수가 정규분포를 따르는 게 잘 fitting 

#요약통계
summary(insurance$expenses)
# 중앙값보다 평균값이 크다 -> 의료비 분포가 오른쪽으로 길게 분포!

# 대부분이 0~15000달러 사이에 위치함.
hist(insurance$expenses)

# 회귀모델은 모든 피쳐가 수치데이터야 함.
# 3개의 factor 타입(sex, moker, region)
table(insurance$sex)
table(insurance$smoker)
table(insurance$region)

# 회귀모델 만들기 전에 독립변수가 종속변수와 어떤 관계?
# 상관분석!!
# scatter 여러개
pairs(insurance[c("age","bmi","children","expenses")])

# install.packages("psych")
library(psych)
pairs.panels(insurance[c("age","bmi","children","expenses")])

help(lm)
# 종속변수~독립변수 순으로 작성
# lm(expenses~독립변수+독립변수+독립변수+...)
ins_model<-lm(expenses~age+children+bmi+sex+smoker+region, data=insurance)
ins_model
ins_model<-lm(expenses~., data=insurance) # .은 expenses를 제외한 모든 컬럼 의미
ins_model

# intercept: 독립변수들이 모두 0일 때 절편 
# expenses=256.8*age + 475.7*children+...-959.3*regionsouthwest - 11941.6
# sex와 smoker를 범주형 → dummy화 (1or0)
# sexmale=0 or 1
# sexfemale = 1 or 0 으로 표현

summary(ins_model)
# residuals(잔차; 예측에 대한 오차(실제값-예측값)의 요약)
# 오차의 min: -11303$ 
# 오차의 max:  29972$ (실제값보다 낮게 예측)
# 오차의 50%는 Q1과 Q3 사이에 존재. -2851 > 50% > 1384

# Estimate(추정된 회귀계수)

# probulaty? Pr(>|t|): 추정된 계수가 실제 0일 확률 추정치. p값이 작은 경우 
# 실제 계수가 아닐 가능성이 높다는 것을 의미함. 특징변수가 
# 종속변수와 관계가 없을 가능성이 아주 낮다는 의미(매우 높다).
### p값이 0.05보다 낮으면 통계적으로 유의미하다! ###

# Multiple R-squared:  0.7509 (다중 R-제곱): 모델이 종속변수 값을 얼만큼
# 잘 설명하는지 측정한 값, 1에 가까울수록 모델이 완벽하게 종속변수를 설명함.
# 0.7509 → 모델이 종속변수 변화량의 약 75%를 설명하고 있다

# 선형회귀 → 연속형 값 예측
# 로지스틱 회귀 → 선형회귀 → 연속형 값 예측 → 특수한 함수 → 분류결과(0 or 1)
#                                         (activation function)
# 연속형 값 예측(선형회귀), 분류결과(로지스틱 회귀)
# 신경망 → 로지스틱 회귀방식의 한계점(너무 단순)을 개선
#         (간단한 모델에 적절)


# 주성분분석(pca, 차원 축소)
# 전파? 신호(가중치 변수값)가 전달되는 것
# 딥러닝은 순전파/역전파가 번갈아가며 수행되는 학습 방법

# cost function: 실제값-예상값(오차)를 계산하는 함수
# 비용함수의 결과를 바탕으로 오차를 최소화하는 과정(GD알고리즘)
# GD알고리즘: cost의 최솟값에 해당되는 위치(w, b)를 찾는 것

temp<-data.frame(age=25,children=2,bmi=30,
                 sex='female',smoker='yes',region='northeast')
predict(ins_model, newdata=temp) # 29456.97$


