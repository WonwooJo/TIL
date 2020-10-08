library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)

# mpg 데이터 불러오기
mpg<- as.data.frame(ggplot2::mpg)

# drv, cty 이상치 할당
mpg[c(10,14,58,93),'drv']  <- 'k'
mpg[c(29,43,129,203),'cty'] <- c(3,4,39,42)

# 갯수 세기
table(mpg$drv)

# 4,f,r만 보겠다.
mpg$drv<-ifelse(mpg$drv %in% c('4','f','r'),mpg$drv,NA)

table(mpg$drv)
boxplot(mpg$cty)
boxplot(mpg$cty)$stats

boxplot(mpg$cty)$stats[1] # 아랫쪽 극단치 # 9
boxplot(mpg$cty)$stats[5] # 윗쪽 극단치 # 26

# 극단치를 NA로 대체
mpg$cty<-ifelse(mpg$cty <9 | mpg$cty > 26, NA, mpg$cty) 

boxplot(mpg$cty)

mpg %>% 
  filter(!is.na(drv)&!is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty=mean(cty))
