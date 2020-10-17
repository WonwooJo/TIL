# 장바구니 분석
# grocery.csv
# 데이터 갯수가 들쑥날쑥해서 읽는데 문제가 생긴다

groceries<-read.csv("data/groceries.csv")

# shape을 찍으라
dim(groceries) # 엑셀로 열어서 봤을 땐 9900개정도인데 왜 15295?
# 첫번째줄의 데이터가 4개라서 4개씩 잘라서 읽었기때문에 데이터 갯수가 많아짐.

# install.packages("arules")
library(arules)
# 행렬로 읽음
groceries<-read.transactions('data/groceries.csv',sep=',')
summary(groceries)
# 아이템 1개만 이루어진 거래가 2159건

# 각 행이 가지고있는 item 품목 도출
inspect(groceries[1:5])

# 거래 비율 확인 가능: support(지지도)
itemFrequency(groceries[,1:169])

# 지지도가 0.0.08 이상인 것들만 출력
itemFrequencyPlot(groceries, support=0.08)

# TOP20개 뽑아
itemFrequencyPlot(groceries, topN=20)

# 간단한 전체 데이터 시각화
image(groceries[1:169]) # 가로: 아이템 갯수 # 세로: 
# 어떤 상품이 많이 팔렸는가?

help(apriori)
# Arguments - data: 거래데이터 행렬
#             parameter: 요구되는 최소 지지도
groceryRules<-apriori(groceries,parameter = list(support=0.1))
# support가 0.1이상이면서 confidence가 0.8 이상인 조건을 만족하는 것들 출력
groceryRules

groceryRules<-apriori(groceries,parameter = list(support=0.005,
                                                 confidence=0.25, minlen=2))
# support가 0.005이상이면서 confidence가 0.25 이상인 조건을 만족하는 것들 출력
groceryRules

# support = 0.005: 전체 9835건의 거래 중에서 약 50건 거래가 있는 
#                  아이템을 대상으로 연관규칙을 만들겠다는 의미.
# confience = 0.25: 신뢰도  
#     confience(빵 → 우유): support(빵, 우유) / support(빵)
#                                 0.05        /    0.1       
#                        → 빵을 사면 우유도 산다는 규칙의 신뢰도
# minlen=2: 2개 미만의 아이템을 갖는 규칙 제외
# ex) {} -> {whole milk}와 같은 규칙은 필요 없어! 최소 2개는 사야징
# 근데 우리는 향상도가 중요해. 향상도가 높은 애들을 찾아라!!

summary(groceryRules)
# rule length distribution (lhs + rhs):sizes
# 규칙: 아이템(lhs) -> 아이템(rhs)
# lhs: left hand size
# rhs: right hand size
# ex) {빵} -> {우유}: 2
#     {빵, 우유} -> {아이스크림}: 3
#     {빵} -> {우유, 아이스크림}: 3
# lift가 중요해!
# 무조건 1보다 큰 애들에 대해 관심을 가져야해.

inspect(groceryRules[1:5])
class(inspect(groceryRules[1:5])) # dataframe

# 내림차순
inspect(sort(groceryRules,by='lift')[1:20])

# 오름차순
inspect(sort(groceryRules,by='lift',decreasing = FALSE)[1:20])

# 전략적으로 berries 상품과 함께 향상도(list)가 높은 상품 추출 → 판매
berryRules<-subset(groceryRules,items %in% "berries")

# 파일 저장
write(berryRules,file='berryRules.csv', sep=',',row.names=FALSE)

berrydf<-as(berryRules,'data.frame')
str(berrydf)

inspect(subset(groceryRules, items %in% c("berries","yogurt")))
