# 1
###### 거리가 가장 가까운 두 점 출력 ######
list1 = []
s = [9,5,2,7,3,20,100,95]

for i in s:
    for j in s:
        if i-j>0:
            list1.append([i,j])
# print(list1)  # 가능한 조합 리스트
min1 = min(list1)

print('가장 가까운 두 점은 {}입니다.'.format(min1))
