library(dplyr)
mpg = as.data.frame(ggplot2::mpg)

# 1. displ<=4 / displ>5 그룹 중 hwy가 평균적으로 어디가 더 높니
mpga <- mpg %>% 
  filter(displ <=4)
mpgb <- mpg %>% 
  filter(displ >5)
mean(mpga$hwy)
mean(mpgb$hwy)
# > mean(mpga$hwy)
# [1] 25.96319
# > mean(mpgb$hwy)
# [1] 18.13889


# 2. audi와 toyota 중 어떤 회사의 cty가 평균적으로 더 높냐?
mpg_audi <- mpg %>% 
  filter(manufacturer == 'audi')
mpg_toyota <- mpg %>% 
  filter(manufacturer == 'toyota')

mean(mpg_audi$cty)
mean(mpg_toyota$cty)

# > mean(mpg_audi$cty)
# [1] 17.61111
# > mean(mpg_toyota$cty)
# [1] 18.52941


# 3. 'chevrolet','ford','honda' 각 hwy의 평균 및 전체 hwy평균
mpg_chev <- mpg %>% 
  filter(manufacturer == 'chevrolet')
mpg_ford <- mpg %>% 
  filter(manufacturer == 'ford')
mpg_honda <- mpg %>% 
  filter(manufacturer == 'honda')

mean(mpg_chev$hwy)
mean(mpg_ford$hwy)
mean(mpg_honda$hwy)

# > mean(mpg_chev$hwy)
# [1] 21.89474
# > mean(mpg_ford$hwy)
# [1] 19.36
# > mean(mpg_honda$hwy)
# [1] 32.55556


# 4. mpg$class, cty, 추출해 새로운 데이터프레임을 만들자.
mpg_CC <- mpg %>% 
  select(class, cty)
mpg_CC

# 5. class가 suv, compact 중 평균 cty가 어떤 것이더 높냐?
mpg_CC_s <- mpg_CC %>% 
  filter(class == 'suv')
mpg_CC_c <- mpg_CC %>% 
  filter(class == 'compact')
mean(mpg_CC_c$cty)
mean(mpg_CC_s$cty)

# > mean(mpg_CC_c$cty)
# [1] 20.12766
# > mean(mpg_CC_s$cty)
# [1] 13.5


# 6. audi 중 어떤 모델이 hwy 1~5위냐?
mpg %>% 
  filter(manufacturer == 'audi') %>% 
  arrange(desc(hwy)) %>% 
  group_by(model)

# 7. 연비(hwy,cty)를 하나의 통합 연비로 만들어서 분석.
#     mpg 데이터 복사본을 만들고 cty + hwy 합산연비변수 추가
mpg_new <- mpg

mpg_new <- mpg_new %>% 
  mutate(total = hwy + cty)

head(mpg_new  )

# 8. 합산연비변수를 2로 나눠 평균 연비변수를 만들어라.
mpg_new <- mpg_new %>% 
  mutate(mymean = total/2)

head(mpg_new)

#9. 평균연비변수가 가장 높은 자동차 3종 출력
mpg_new %>% 
  arrange(desc(mymean)) %>% 
  head(3)

# 9-1  1~3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문으로 만들어 출력
# 데이터는 복사본 사용

mpg %>% 
  mutate(total=hwy+cty,
         mymean=total/2) %>% 
  arrange(desc(mymean)) %>% 
  head(3)

# 10. 회사별로 'suv'자동차의 도시 및 고속도로 통합연비 내림차순, 1~5위까지 출력
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=='suv') %>% 
  mutate(total = (cty+hwy)/2) %>% 
  summarise(meantot = mean(total)) %>% 
  arrange(desc(meantot)) %>% 
  head(5)

# 11. class 별 cty 평균
mpg %>% 
  group_by(class) %>% 
  summarise(meancty=mean(cty))

# 12. cty 평균 높은 순
mpg %>% 
  group_by(class) %>% 
  summarise(meancty=mean(cty)) %>% 
  arrange(desc(meancty))

# 13 어느 회사 자동차의 hwy가 가장 높은가.
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(meanhwy=mean(hwy)) %>% 
  arrange(desc(meanhwy)) %>% 
  head(3)

#14. 어떤 회사에서 compact를 가장 많이 생산하냐?
# 각 회사별 compact 차종 수를 내림차순으로 정렬
mpg %>% 
  filter(class=='compact') %>% 
  group_by(manufacturer) %>% 
  summarise(cnt=n()) %>%  # 갯수 구함\
  arrange(desc(cnt))

df <- data.frame(gender=c('m','f',NA,'m','f'),
           score = c(5,4,3,4,NA))
df
