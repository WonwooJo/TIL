# k-means

> 20.10.08에 배운 k-means에 대해 정리해보자.



## 1. k-means 알고리즘이란?

- 머신러닝 비-지도학습 카테고리 안에 있는 대표적인 클러스터링 알고리즘
- 데이터만 받아 레이블을 달아주는 역할을 함.
- 각 클러스터와 거리차이의 분산을 최소화하는 방식으로 동작함.



## 2. k-means 알고리즘 작동 순서

![image-20201008172005598](C:\Users\joww0\AppData\Roaming\Typora\typora-user-images\image-20201008172005598.png)

#### 1. k개의 random centroid points 생성

​	→ 초기 클러스터의 중심점을 random으로 생성함.

#### 2. 생성된 각 클러스터의 centroid points들과 모든 데이터 사이의 거리를 구함

#### 3. 모든 데이터에 대해 가까운 거리에 있는 클러스터 중심점 할당

#### 4. 각각의 클러스터 내의 데이터에 대한 중심점 계산

​	→ 계산을 바탕으로 k개의 클러스터의 centroid points 업데이트

#### 5. 2~4번을 nstart만큼 반복함. until 클러스터 centroid points에 대한 업데이트가 전혀 없을 때까지

#### 6. 추가 업데이트 없을 시 알고리즘 종료.



## 3. 주의할 점

#### 1. 최적의 k값을 구하는 것이 중요함.

- Rule of thumb

  data의 갯수가 많지 않은 경우 주로 사용됨.

  <img src="C:\Users\joww0\AppData\Roaming\Typora\typora-user-images\image-20201008173052889.png" alt="image-20201008173052889" style="zoom:67%;" />

- Elbow Method

  클러스터의 수를 순차적으로 늘려가면서 결과를 모니터링함. 

  <img src="C:\Users\joww0\AppData\Roaming\Typora\typora-user-images\image-20201008173409903.png" alt="image-20201008173409903" style="zoom:50%;" />

- Information Criterion Approach

  클러스터링 모델에 대해 가능도 계산이 가능할 때 사용함. 

#### 2. 몇몇 상황에서 사용하기 어려운 경우가 있음.

- k값이 데이터의 실제 클러스터보다 작을 때(ex. 실제 클러스터 4개, k=3)

<img src="C:\Users\joww0\AppData\Roaming\Typora\typora-user-images\image-20201008173613474.png" alt="image-20201008173613474" style="zoom: 67%;" />

- k값이 데이터의 실제 클러스터보다 클 때(ex. 실제 클러스터 5개, k=8)

<img src="C:\Users\joww0\AppData\Roaming\Typora\typora-user-images\image-20201008173758688.png" alt="image-20201008173758688" style="zoom:67%;" />

- 이상치에 민감함(중심점이 클러스터의 중심에 위치하지 못함)

<img src="C:\Users\joww0\AppData\Roaming\Typora\typora-user-images\image-20201008173929902.png" alt="image-20201008173929902" style="zoom:67%;" />

- 구형(spherical)이 아닌 클러스터를 찾는데에는 적절하지 않음.

  실제 데이터의 클러스터는 4개로 알고리즘 상 갯수는 같지만, 클러스터 된 부분이 다름.

![image-20201008174219862](C:\Users\joww0\AppData\Roaming\Typora\typora-user-images\image-20201008174219862.png)

​	→ 이러한 한계점을 돌파하기 위해 비슷한 밀도를 가진 데이터를 묶는 클러스터링 방법으로 DBSCAN이나 

​		mean-shift 클러스터링 알고리즘을 사용하기도 한다.



참고: wikipedia/K-means_clustering