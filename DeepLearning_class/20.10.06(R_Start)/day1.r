# 스크립트창 → 파일 저장
# 콘솔창 → 실행결과 확인 / 간단한 코드 실행 결과 확인
print('hello')

# readxl 라이브러리 설치
install.packages('readxl')

# python import와 같은 library
library(readxl)

# 벡터 만들기 python '=' == R <-
eng <- c(50,60,70)
mat <- c(70,80,90)

# dataframe 만들기
df <- data.frame(eng,mat)
df

class <- c(1,1,2)
dfm <- data.frame(eng,mat,class)
dfm

# . == $  /  dataframe$columnName
mean(dfm$eng)

read_excel('data/excel_exam.xlsx')
read_excel('data/excel_exam_novar.xlsx',col_names = F)

read_excel('data/excel_exam_sheet.xlsx',sheet = 3)

data <- read.csv('data/csv_exam.csv')

# structure: 구조를 보자. info() == str
str(data)

# 파일 저장
write.csv(data,file='savefile.csv')

exam <- read.csv('data/csv_exam.csv')

# 상위 6개 데이터 출력
head(exam)

# 하위 6개 데이터 출력
tail(exam)

# 이쁘게 표로 나오넹
View(exam)

# numpy에서 shape이랑 같군. 20x5
dim(exam)

# 2번째 위치의 숫자 출력
dim(exam)[2]

# describe와 같군. 기술통계값 구할때
summary(exam)

# R에서 많이 쓰는 라이브러리
install.packages('dplyr')
library(dplyr)

help("dplyr")

exam

# english를 eng로 변경
reexam <- rename(exam, eng = english)
reexam

reexam$plus_me <- reexam$math + reexam$eng
reexam$plus_me

# np.where와 거의 유사함.
reexam$result <- ifelse(reexam$math >= 70, 'pass','fail')
reexam
install.packages('ggplot2')

library(ggplot2)
qplot(reexam$result)

# ifelse를 중첩시켜서 조건문을 완성, 
# reexam$hakjum 변수에 math<50 => 'c', math<=80 => 'B', math<=100 => 'A' 저장

reexam$hakjum <- ifelse(reexam$math<50,'C',
                        ifelse(reexam$math<=80,'B','A'))
reexam

table(reexam$hakjum) # value_counts와 동일

exam <- read.csv('data/csv_exam.csv')

# 파이프 연산자!!! %>%, %in% 
# filter 말 그래도 필터
exam %>% filter(class==1)
# crtl + shift + m exam에서 class == 1인 데이터만 뽑아내라 
# pipe line?  → 파이프 여러개 연결해놓음

exam %>% filter(math>=70 & english >70) # and
exam %>% filter(math>=70 | english >70) # or

# 똑같은 코딩임 (후자가 더 간단해보이네.)
exam %>% filter(class == 1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1,3,5))

# select: 특정 열 추출 
exam %>% select(math)
exam %>% select(-math,-class) # - 빼고 나머지

exam %>% 
  filter(class==1) %>% 
  select(english)

exam %>% 
  select(id,math) %>% 
  head

# 정렬!!
exam %>% 
  arrange(math) # math 기준 오름차순 정렬

exam %>% 
  arrange(desc(math)) # math 기준 내림차순 정렬

exam %>% 
  arrange(class, math) # 1차 class로 오름차순, 
# 만약 class가 같다면 2차 math 오름차순

# 파생변수 추가
exam %>% 
  mutate(total=math+english+science, mean=total/3) %>% 
  arrange(desc(total))

exam %>% 
  mutate(res = ifelse(science>=60,'pass','fail')) %>% 
  arrange((desc(science))) %>% 
  head

# groupby: 집계
exam %>% 
  summarise(mean_math = mean(math))

exam %>%
  group_by(class) %>% 
# Groups:   class [5] -> 5개의 그룹
  summarise(mean_math=mean(math))

exam %>%
  group_by(class) %>% 
  # Groups:   class [5] -> 5개의 그룹
  summarise(mean_math=mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n=n()) # n: 빈도
# max, min, sd, var, ...

# 패키지명 :: 데이터셋 (제공데이터셋)


mpg = as.data.frame(ggplot2::mpg)
mpg
str(mpg)

mpga <- mpg %>% 
  filter(displ <=4)

mpgb <- mpg %>% 
  filter(displ >4)

mean(mpga$hwy)

# data.frame 합치기
a<-data.frame(id=c(1,2),
              test=c(50,90))

b<-data.frame(id=c(3,4),
              test=c(30,100))
bind_rows(a,b)

exam

name<-data.frame(class=c(1,2,3,4,5),
           tea=c('kim','park','lee','cho','jung'))
name

# exam과 name 결합 → class 기준으로 합치자
left_join(exam,name,by='class')


# k-means algorithm 청소년 심리상태 분석 해봅시다.