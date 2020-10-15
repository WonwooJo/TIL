sms_raw<-read.csv("data/sms_spam_ansi.txt",stringsAsFactors = FALSE)
str(sms_raw)
sms_raw$type<-factor(sms_raw$type)
str(sms_raw)

table(sms_raw$type)

############### 우도표
# tm패키지 → 코퍼스(corpus) 구축
# corpus? 특정 도메인에서 통용되는 단어 집합
# ex) 법령코퍼스
# install.packages('tm') # 텍스트 마이닝 툴
library(tm)

stopwords('en') # 불용어어

removeWords("of the people", stopwords('en'))

IMDB<-read.csv("data/IMDB-Movie-Data.csv")
str(IMDB)
summary(IMDB)
colSums(is.na(IMDB))

# 결측치 제거
IMDB2<-na.omit(IMDB) # 모든 변수에 대해 결측값이 1개라도 있는 행 제거
colSums(is.na(IMDB2))

# 12번열에 대해 결측값이 있는 경우 해당 행을 삭제
IMDB3<-IMDB[complete.cases(IMDB[,12]),]
colSums(is.na(IMDB3))

IMDB$Metascore2<-IMDB$Metascore
# NA값을 50으로 대체
IMDB$Metascore2[is.na(IMDB$Metascore2)]<- 50
IMDB$Metascore2

# na.rm = TRUE

mean(IMDB$Revenue..Millions.,na.rm=TRUE)

# 극단치 제거 IMDB$Revenue..Millions., Q3+1.5*IQR, Q1-1.5*IQR

# 1분위수
Q1<-quantile(IMDB$Revenue..Millions.,probs=c(0.25),na.rm = TRUE)
Q3<-quantile(IMDB$Revenue..Millions.,probs=c(0.75),na.rm = TRUE)

LC<-Q1-1.5*(Q3-Q1)
UC<-Q3+1.5*(Q3-Q1)

# 정상범위 데이터
IMDB2<-subset(IMDB, IMDB$Revenue..Millions.>LC & IMDB$Revenue..Millions.<UC) 

######## 텍스트 마이닝

# 1) 코퍼스 생성 → 2) 단어(T)문서(D)행렬(M): TDM or (문서단어행렬:DTM)
#   TDM → Transpose → DTM
# 3) 문자 전처리(불용어, 조사) 

IMDB$Actors[1]

# 부분 문자열 추출
substr(IMDB$Actors[1],1,5) # 5글자

# 문자열 붙일때
paste(IMDB$Actors[1],'_','A',sep = "")

# 문자열 분리
strsplit(IMDB$Actors[1], split = ',')

# 문자열 대체
IMDB$Genre2<-gsub(","," ",IMDB$Genre)
IMDB$Genre2

# 1) 코퍼스 생성
CORPUS<-Corpus(VectorSource(IMDB$Genre2))

# 특수문자제거, 숫자제거, 소문자 통일
CORPUS_TM<-tm_map(CORPUS, removePunctuation) # 특수문자 제거
CORPUS_TM<-tm_map(CORPUS, removeNumbers) # 숫자 제거
CORPUS_TM<-tm_map(CORPUS, tolower) # 소문자 통일일

# 2) 문서행렬생성
DTM<-DocumentTermMatrix(CORPUS_TM) 
# Doc: 1000, terms: 20  → 1000x20
# Non-/sparse entries: 2555(0이 아님)/17445(0)
# Sparsity(희소성)   : 87% 전체 중 0이 차지하는 비율
# Maximal term length: 9 (단어의 길이가 가장 긴 것)
# Weighting          : term frequency (tf)  (단어빈도수로 Weighting이 되어있음)

inspect(DTM)
# Docs action adventure comedy crime drama horror mystery romance sci-fi thriller
# 1       1         1      0     0     0      0       0       0      1        0
# 1번 문서는 actrion, adventure, sci-fi임. IMDB$Genre2[1]과 같지.

# DTM을 데이터프레임으로 변경
DTM<-as.data.frame(as.matrix(DTM)) # 문서(영화): 1000개, 단어(장르 종류): 20
head(DTM)

IMDB_GENRE<-cbind(IMDB,DTM)

IMDB$Description # 단어중복, 조사, 동사, 명사, ...
# 불용어 제거
# 코퍼스 만들기(벡터 객체 먼저 만들고)
CORPUS<-Corpus(VectorSource(IMDB$Description))

CORPUS_TM<-tm_map(CORPUS, stripWhitespace) # 공백, 엔터, 탭 제거
CORPUS_TM<-tm_map(CORPUS, removeNumbers) # 숫자 제거
CORPUS_TM<-tm_map(CORPUS, tolower) # 소문자로 변환
CORPUS_TM<-tm_map(CORPUS, removePunctuation) # 특수문자 제거거

# DTM 만들기
DTM<-DocumentTermMatrix(CORPUS_TM)
inspect(DTM) # 1000행, 6044열

# IMDB$Description[155]


CORPUS_TM<-tm_map(CORPUS_TM,removeWords,c(stopwords("english"),"my","custom",'words'))
# 불용어를 제거, 추가적으로 my, custom, words 단어들도 제거거

TDM<- TermDocumentMatrix(CORPUS_TM)
m<-as.matrix(TDM)
m
# 행 단위로 단어들의 합계
rowSums(m)

v<-sort(rowSums(m),decreasing = TRUE) # 내림차순 정렬

names(v)
d<-data.frame(word=names(v),freq=v)
# install.packages("SnowballC") # 어근 추출 ex) runs,running, run... → run
library(SnowballC)
# install.packages("wordcloud")
library(wordcloud)
# install.packages('RColorBrewer')
library(RColorBrewer)
help(wordcloud)

wordcloud(words=d$word, freq=d$freq,min.freq=5,max.words=200, 
          random.order=FALSE, colors = brewer.pal(8,'Dark2'))

sms_corpus<-VCorpus(VectorSource(sms_raw$text))

inspect(sms_corpus[1:3])

sms_raw$text[1]

as.character(sms_corpus[[1]])

# sms_corpus[1:3] text에 대한 내용 확인
lapply(sms_corpus[1:3],as.character)

sms_corpus_clean<-tm_map(sms_corpus,removeNumbers)
sms_corpus_clean<-tm_map(sms_corpus,removePunctuation)
sms_corpus_clean<-tm_map(sms_corpus,tolower)
sms_corpus_clean<-tm_map(sms_corpus,content_transformer(tolower))
sms_corpus_clean<-tm_map(sms_corpus,removeWords,stopwords())
removePunctuation("hello...; :hihihi")

myReplace<-function(x){
  gsub("[[:punct:]]+", ' ',x)
}
myReplace("hello....world")

wordStem(c('learn','learned','learning','learns'))

# sms_corpus_clean에 있는 단어들에 대해 어근 추출(wordStem)
sms_corpus_clean<-tm_map(sms_corpus_clean,stemDocument) 
sms_corpus_clean<-tm_map(sms_corpus_clean,stripWhitespace) 

lapply(sms_corpus_clean[1:3],as.character)

sms_dtm<-DocumentTermMatrix(sms_corpus_clean)
sms_dtm

######## 여기까지 데이터 전처리 ########
# 1. 트레이닝 / 테스트 분할
# 2. 워드클라우드(시각화, 스팸/햄)

sms_train_labels<-sms_raw[1:7534,]$type
sms_tests_labels<-sms_raw[7534:11534,]$type

sms_dtm_train<-sms_dtm[1:7534,]
sms_dtm_test<-sms_dtm[7535:11534,]

prob.table(table(sms_train_labels))
prob.table(table(sms_tests_labels))

# 트레이닝 데이터 → 베이지안 필터기 → 테스트 데이터 
  # → 분류결과(예측), 실제(정답) 비교

wordcloud(sms_corpus_clean, min.freq = 50, random.order = FALSE)
spam<-subset(sms_raw,type=='spam')
ham<-subset(sms_raw,type=='ham')

wordcloud(spam$text,min.freq = 50,random.order = FALSE)

# install.packages('e1071') # 베이지안 필터기 라이브러리
library(e1071)
