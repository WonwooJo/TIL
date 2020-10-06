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
  group_by(model) %>% 
  summarise(mean(hwy))

  

