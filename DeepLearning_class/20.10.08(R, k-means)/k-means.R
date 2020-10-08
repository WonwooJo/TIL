library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)

# 난수 100개 발생 / 정규분포를 따르는, 평균: 0, 표준편차: 1
y = rnorm(100)
hist(y)

x<-matrix(rnorm(100),nrow=5) # 난수 100개 생성, 5행*20열

help(dist) # 두 점 사이의 거리를 구하는 함수. method는 여러 방법들. default는 euclidean

dist(x)
# 20차원에 해당되는 데이터에서 1, 2번째 데이터 간 유클리디안 거리=5.349665

dist(x,method='manhattan')

data(iris) # data함수: 데이터를 로드
head(iris)

iris[,-5]

help(kmeans)

# elbow 기법(최적의 k값 구하기)
# iris는 4차원 데이터(feature 갯수 4개) → 3개 클러스터로 나누겠다.
# → 3개의 클러스터에 대한 중심점 좌표 확인(centers) →
# 1번째 cp: (5.7, 2.5, 1.4, 0.15)
# 2번째 cp: (4.7, 2.2, 2.4, 1.15)
# 3번째 cp: (3.7, 1.5, 1.7, 0.5)
# 이렇게 3행 4열로 centers가 표현됨.

# ex) 3만명 sns 데이터, features 30개, 5개 클러스터링
# 5개 클러스터에 대한 중심점의 shape?
# 5행 30열

kmeans.iris<-kmeans(iris[,-5],3,nstart = 2)
kmeans.iris$centers
kmeans.iris$cluster

table(iris[,5],kmeans.iris$cluster)

kmeans.iris
kmeans10.iris<-kmeans(iris[,-5],3,nstart = 10)
round(sum(kmeans10.iris$withinss),2)

set.seed(123)
kmeans.iris<-kmeans(iris[,-5],3)
round(sum(kmeans.iris$withinss),2)

iris_plot<-ggplot(data=iris,aes(x=Petal.Length,y=Petal.Width,colour=Species))+
  geom_point(shape=19,size=4)+ ggtitle('iris data')

iris_plot2<-iris_plot+
  annotate('text',x=1.5,y=0.7,label='Setosa',size=5)+
  annotate('text',x=3.5,y=1.5,label='Verisicolor',size=5)+
  annotate('text',x=6.0,y=2.7,label='Virginica',size=5)

iris_k_means<-kmeans(iris[,c('Petal.Length','Petal.Width')],3)

prop.table(iris_k_means$size)

iris_kmeans_centers<-iris_k_means$centers
iris_kmeans_centers

iris_plot2+
  annotate('point',x=4.3,y=1.36,size=5,color='black')+
  annotate('point',x=5.6,y=2.05,size=5,color='black')+
  annotate('point',x=1.5,y=0.25,size=5,color='black')



# k-means 사용 시 고려사항
# 범주별 데이터 갯수가 비슷한 경우 → 클러스터링이 잘 됨
# 범주별 데이터 갯수 차이가 심한 경우 → 클러스터링이 잘 되지 않음 → 데이터 증식
# or 데이터 제거(범주별 데이터 갯수를 비슷하게 해줌)
# 범주별 밀도가 다른 경우 클러스터링이 잘 안될 수 있음.
# 표준화 작업
z_iris<-scale(iris[,-5])

# iris colums 컬럼 2, 3, 4개 → 클러스터링 수행해봐
