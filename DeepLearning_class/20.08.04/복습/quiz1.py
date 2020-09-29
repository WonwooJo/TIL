# 1
###### 거리가 가장 가까운 두 점 출력 ######
s = [9,5,2,7,3,20,100,95]

minNum = 777
for i in range(len(s)):
    for j in range(len(s)):
        p1, p2 = s[i], s[j]
        if abs(p1 - p2) != 0:
            if minNum > abs(p1 - p2):
                minNum = abs(p1 - p2)
                minP1,minP2  = p1, p2

print('가장 가까운 두 점은 {}, {}'.format(minP1, minP2))

