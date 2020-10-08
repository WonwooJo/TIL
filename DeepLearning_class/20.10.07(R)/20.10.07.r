# install.packages('foreign')
library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)
raw_welfare <- read.spss('data/Koweps_hpc10_2015_beta1.sav', to.data.frame = T)
welfare <- raw_welfare
head(welfare)
View(welfare)

dim(welfare)
str(welfare)
summary(welfare)

welfare <- rename(welfare, 
       sex = h10_g3,
       birth = h10_g4,
       marriage = h10_g10,
       religion = h10_g11,
       income = p1002_8aq1,
       code_job = h10_eco9,
       code_region = h10_reg7)

table(welfare$sex) # 성별에 따른 데이터 갯수 출력

table(is.na(welfare$sex)) # NA가 있냐? FALSE만 있으면 결측치 없음.

# ifelse문 사용 sex == 1 male, sex == 2 Female
welfare$sex <- ifelse(welfare$sex == 1, 'male','female')
qplot(welfare$sex)

welfare$income

summary(welfare$income)

# NA 대체값 or 제외

qplot(welfare$income)+xlim(0,1000) #  그래프 범위


# 이상치
welfare$income<-ifelse(welfare$income %in% c(0,5000),NA,welfare$income)
table(is.na(welfare$income))


# NA가 아닌 데이터에 대해 성별에 따른 급여 평균 조사
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

ggplot(data=sex_income,aes(x=sex,y=mean_income))+geom_col() 
# geom_col -> y값 그대로 들어감
# 성별에 따른 급여 차이 있음.

#qplot의 y축은 빈도, ggplot은 값 

summary(welfare$birth)
qplot(welfare$birth)

table(is.na(welfare$birth)) # 결측치 없음

welfare$birth<- ifelse(welfare$birth == 999, NA, welfare$birth)
table(is.na(welfare$birth))

# age열 추가
# age = 2015+birth+1 값
# summary, qplot 출력

welfare$age<-2015-welfare$birth+1
summary(welfare$age)
qplot(welfare$age)

# 나이에 따른 급여 평균
age_income<-welfare %>% 
  filter(!is.na(income)) %>%  # income NA가 아닌 것
  group_by(age) %>% 
  summarise(mean_income = mean(income))

ggplot(data=age_income,aes(x=age,y=mean_income))+geom_col()

ggplot(data=age_income,aes(x=age,y=mean_income))+geom_line()

# 연령대(young<30 / middle<60 / old >=60)
welfare<-welfare %>% 
  mutate(ageg=ifelse(age<30,'young',
                     ifelse(age<=59, 'middle','old')))
table(welfare$ageg) # count 확인

qplot(welfare$ageg)

# 연령대 별 월급 평균
ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income=mean(welfare$income))
ggplot(data=ageg_income, aes(x=ageg,y=mean_income))+geom_col()+
  scale_x_discrete(limits=c('young','middle','old')) # x축 순서 정해주기

# 성별 월급 차이가 연령대별로 다를까?
sex_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income=mean(income))

# 각 연령대 별 성별에 따른 수입. 쌓여서 나옴
ggplot(data=sex_income,aes(x=ageg,y=mean_income,fill=sex))+geom_col()+
  scale_x_discrete(limits=c('young','middle','old'))

# 막대 분리해서 출력
ggplot(data=sex_income,aes(x=ageg,y=mean_income,fill=sex))+geom_col(position = 'dodge')+
  scale_x_discrete(limits=c('young','middle','old'))

# 그냥 age로 하면 그룹이 69개 나오네.
sex_age<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income=mean(income))
sex_age

ggplot(data=sex_age,aes(x=age,y=mean_income,col=sex))+geom_line()

# 직업군 별 급여 비교
table(welfare$code_job)


library(readxl)
list_job <- read_excel('data/Koweps_Codebook.xlsx', col_names = T, sheet = 2)
dim(list_job) # 직종코드: 149개

# welfare에 list_job을 연결해라
welfare<-left_join(welfare,list_job,id='code_job')

str(welfare)

welfare %>% 
  filter(!is.na(code_job)) %>%  # code_job이 na 아닌것
  select(code_job,job) %>% 
  head(10)

# 직업 별 월급의 평균
job_income<-welfare %>% 
  filter(!is.na(income)&!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income=mean(income)) %>% 
  arrange(desc(mean_income))

top20<-job_income %>% 
  head(20)
top20

ggplot(data=top20,aes(x=job,y=mean_income))+geom_col()+
  coord_flip()

bottom10<-job_income %>% 
  arrange(mean_income) %>% 
  head(10)
bottom10
ggplot(data=bottom10,aes(x=job,y=mean_income))+geom_col()+
  coord_flip()+ylim(0,500)

# 남성 직업 빈도 상위 10개 출력
job_male<-welfare %>% 
  filter(sex=='male'&!is.na(job)) %>% 
  group_by(job) %>% 
  summarise(cnt=n()) %>% 
  arrange(desc(cnt)) %>% 
  head(10)
  
job_female<-welfare %>% 
  filter(sex=='female'&!is.na(job)) %>% 
  group_by(job) %>% 
  summarise(cnt=n()) %>% 
  arrange(desc(cnt)) %>% 
  head(10)


# 종교 있는 사람이 이혼을 더할까?
# 종교 유무에 따른 이혼율

table(welfare$religion)

welfare$religion<-ifelse(welfare$religion==1,'yes','no')
table(welfare$religion)

qplot(welfare$religion)

table(welfare$marriage)

# 이혼여부 변수 생성
welfare$group_marriage<-ifelse(welfare$marriage == 1,'marriage',
       ifelse(welfare$marriage == 3,'divorce','NA'))

table(welfare$group_marriage)

qplot(welfare$group_marriage)

# 종교, 결혼, 이혼율
# 있음  결혼   ??%
# 없음  이혼   ??%

religion_marriage<- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion,group_marriage) %>% 
  summarise(cnt=n()) %>% 
  mutate(tot_group=sum(cnt)) %>% 
  mutate(pct=round(cnt/tot_group*100,1))
  
divorce<-religion_marriage %>% 
  filter(group_marriage == 'divorce') %>% 
  select(religion, pct)

list_region<-data.frame(code_region=c(1:7),
           region=c('서울','수도권(인천/경기)','부산/경남/울산',
                    '대구/경북','대전/충남','강원/충북','광주/전남/전북/제주도'))
list_region
table(welfare$code_region)

welfare<-left_join(welfare, list_region, id='code_region')

welfare %>% 
  select(code_region,region) %>% 
  head()

str(welfare)

# 지역별 연령대 비율 조사
welfare %>% 
  group_by(region,ageg)