# DeepLearning Class index

> 멀티캠퍼스 DeepLearning Class에서 배운 내용들에 대한 간단한 정리
>
> Pandas와 Numpy는 시간 날 때 마다 진행함.



## Prediction

> 교육받은 내용을 기반으로 kaggle Data, UCI 등 데이터를 활용해 예측 진행.



### 1. 타이타닉 생존자 예측(20.09.24)

> Kaggle Data, competition score 0.787

- 간단하게 데이터를 전처리
  - Name 컬럼에서 호칭 추출(Mr., Mrs., ... etc) using Regular Expression
  - FamilySize 컬럼 추가(SibSp + Parch)
  - 이상치 확인
  - Age 컬럼 cut 함수 활용하여 카테고리 타입으로 변경 
  - Pclass의 경우 OneHotEncoder를 활용.
  - violinplot으로 전처리 최종 확인
- .corr() 피어슨 상관계수를 구하고 Heatmap으로 시각화하여 y값과 연관성 확인
- Random Forest를 활용하여 예측.
  - GridSearchCV를 통해 최적의 Parameter(n_estimators, min_samples_split ... etc) 도출



### 2. Bike 대여 갯수 예측(20.09.21~)

> Kaggle Data

- 데이터 전처리

  - windspeed: 값이 0인 데이터들 값 → Random Forest로 예측값으로 대체

  - datetime → year, month, day, hour, dayofweek로 나눔

- Random Forest regression을 활용하여 예측.

  - GridSearchCV를 통해 최적의 Parameter(n_estimators, min_samples_split ... etc) 도출

- k-fold를 활용하여 모델 교차 검증



### 3. 암 판정 분류(20.09.25)

> UCI Machine Learning center에 있는 Breast Cancer Wisconsin Data 활용

- 데이터 전처리
  - StandardScaler를 통해 데이터를 scaling 진행.
  - Train 과 Test 데이터의 비율은 7.5 : 2.5로 나눔.
- Random Forest classifier를 활용하여 분류.
- TP, FP, FN, TN에 대해 배움.



### 4. US house price prediction (20.09.29)

> Kaggle Data, 

- 데이터 전처리

  - 결측치 처리(결측치가 많은 열은 제거, 적은 열은 대체값)
  - 회귀 분석의 정확도 향상을 위해 데이터의 타입 정의
    - 수치형(연속형, 이산형), 범주형(명목형, 순서형)

  - 회귀 분석의 정확도를 높이기 위해서는 정규화가 필수적이다.(log도 가능)
    - skewness(왜도), kurtosis(첨도) 파악이 필수 → 히스토그램(distplot, kdeplot)
    - pairplot을 통해 여러 피쳐들과의 그래프를 볼 수 있다.



## Web Crawling

> Selenium(Chrome Driver), Beautifulsoup을 통해 Web Crawling을 진행.

- 서울 내 Starbucks 지점 시각화(+Seoul geojson, 구별 인구 만명당 지점 갯수 구함) 20.08.11

- 다나와 웹사이트 내 무선청소기의 가격과 성능 비교 (20.08.12)
- 인스타그램, 네이버 검색어를 입력하여 이미지 크롤링(20.08.06~07)



## Recommand System

> 유클리디안, 코사인유사도를 활용하여 추천시스템 진행

- 영화 추천 시스템 (20.09.04)



## 통계 이론

> Data Prediction을 위해 필요한 기초 통계 Keyword

- 유의수준 / 유의 확률(p value)
- 추론통계: 대립가설(목표) / 귀무가설(입증) → 귀무가설을 기각하므로 대립가설이 성립됨.

- 상관분석 시 고려사항
  - 산점도(scatter plot)를 통해 선형성을 확인
  - 곡선형이라면 → 스피어만, 켄달 상관분석 활용
  - 상관관계가 있다고 반드시 인과관계가 있는 것은 아니다
    - 제 3변인 문제(원래는 A → B → C 인데, 데이터는 A → C 성립으로 B가 고려되지 않았을 수도 있음.)
  - 극단치(outlier)로 인한 인위적 상관관계가 있을 수 있음.
- 회귀분석 함수 statsmodels.formula.api.ols
  - R-squared
  - Prob(F-statistic)
  - coef
  - ... etc



## Git

> 2일간 Git을 배우며 원리와 활용 범위에 대해 교육





