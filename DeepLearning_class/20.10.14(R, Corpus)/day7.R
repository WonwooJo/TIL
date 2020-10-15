sms_raw<-read.csv("data/sms_spam_ansi.txt", stringsAsFactors = FALSE)
str(sms_raw)

sms_raw$type<-factor(sms_raw$type)
str(sms_raw)

table(sms_raw$type)

#tm??Ű?? -> ???۽?(corpus, ????ġ) ????

# install.packages("tm") #?ؽ?Ʈ???̴? ??
library(tm)

# corpus? Ư�� ?????ο??? ?????Ǵ? ?ܾ? ????
# ex) ???????۽?

stopwords("en") #?ҿ???

removeWords("of the people",stopwords("en"))

IMDB<-read.csv("data/IMDB-Movie-Data.csv")
str(IMDB) #numeric > integer
summary(IMDB)

sum(is.na(IMDB$Metascore))
colSums(is.na(IMDB))

#????ġ ��??
IMDB2<-na.omit(IMDB) #???? ?????? ???? ???????? 1?????? ?ִٸ?, ?ش? ??�� ��??
colSums(is.na(IMDB2))

#Ư�� ????(12?? ??)?? ???? ???????? ?ִ? ???? ?ش? ??�� ??��
IMDB3<-IMDB[complete.cases(IMDB[,12]),]
colSums(is.na(IMDB3))
colSums(is.na(IMDB))

IMDB$Metascore2<-IMDB$Metascore
IMDB$Metascore2[is.na(IMDB$Metascore2)]<-50

#na.rm=TURE

mean(IMDB$Revenue..Millions., na.rm=TRUE)


#?ش?ġ ��??(IMDB$Revenue..Millions., Q3+1.5*IQR, Q1-1.5*IQR)

#1??��??
Q1<-quantile(IMDB$Revenue..Millions., probs=c(0.25), na.rm=TRUE)
#3??��??
Q3<-quantile(IMDB$Revenue..Millions., probs=c(0.75), na.rm=TRUE)

LC=Q1-1.5*(Q3-Q1)
UC=Q3+1.5*(Q3-Q1)

IMDB2<-subset(IMDB, IMDB$Revenue..Millions.>LC & IMDB$Revenue..Millions. < UC) #��????�� ??????

IMDB$Actors[1] #"Chris Pratt, Vin Diesel, Bradley Cooper, Zoe Saldana"
substr(IMDB$Actors[1],1,5)

#???ڿ? ???̱?
paste(IMDB$Actors[1], "_", "A", sep="") 
#???ڿ? ?и?
strsplit(IMDB$Actors[1], split=",")
#???ڿ? ??ü
IMDB$Genre2<-gsub(",", " ", IMDB$Genre)

#  gsub?Լ? ?̿??Ͽ?, "?츮???? ?ѱ? ???ѹα? ???? ?ڸ??? ??��??..." => "???ѹα?"
IMDB$Genre2

#?ؽ?Ʈ???̴?#
#1)???۽????? -> 2) ?ܾ?(T)????(D)????(M);TDM or(?????ܾ?????;DTM) -> 3)???? ??ó??(?ҿ???, ��??, ???? ��?? ??...)-> ?м?/?𵨸?
#
#     ????1 ????2... ????N
# hello
# hi
# sky
# ...
# TDM -> Transpose -> DTM

CORPUS=Corpus(VectorSource(IMDB$Genre2)) #???۽? ????
CORPUS_TM=tm_map(CORPUS, removePunctuation) #Ư?????? ��??
CORPUS_TM=tm_map(CORPUS_TM, removeNumbers)#???? ��??
CORPUS_TM=tm_map(CORPUS_TM, tolower)#?ҹ??? ????

#???????? ????
DTM<-DocumentTermMatrix(CORPUS_TM)
DTM

# 
# DTM(1000*20 => 20000?? ???? ????)
# documents: 1000, terms: 20
# Non-/sparse entries: 2555(0?? ?ƴ?)/17445(0)
# Sparsity(0?? ?????ϴ? ????:87%)
# #dense<->sparse(????????)

inspect(DTM)

IMDB$Genre2[1]
inspect(DTM)
IMDB$Genre2[1]

DTM<-as.data.frame(as.matrix(DTM)) #????(??ȭ):1000, ?ܾ?(?帣 ��??):20 ???۽? ????
head(DTM)

IMDB_GENRE<-cbind(IMDB, DTM)


IMDB$Description #?ܾ? ?ߺ?, ��??, ????, ????,...
#?ҿ??? ��??
CORPUS<-Corpus(VectorSource(IMDB$Description)) #IMDB$Description?? ?????ϴ? ?ܾ? ????��?? ???۽??? ????
CORPUS_TM<-tm_map(CORPUS, stripWhitespace) #????(????, ?? ????)
CORPUS_TM<-tm_map(CORPUS_TM, removeNumbers) #????��?Ű?
CORPUS_TM<-tm_map(CORPUS_TM, tolower) #?ҹ???
CORPUS_TM<-tm_map(CORPUS_TM, removePunctuation) #????�� ��?Ű?

DTM<-DocumentTermMatrix(CORPUS_TM)
inspect(DTM)

#IMDB$Description[155]

CORPUS_TM<-tm_map(CORPUS_TM, removeWords, c(stopwords("english"), "my", "custom", "words"))
#?ҿ?? ��??, ?߰???��?? "my", "custom", "words" ?ܾ??鵵 ��??


TDM<-TermDocumentMatrix(CORPUS_TM)

m<-as.matrix(TDM)
m

rowSums(m)
#IMDB$Description
#                 ??ȭ1 ... ??ȭ1000
# control           0   ...      0     =====> ?? ?հ?(rowSums:9)
# criminals         
# ...

v<-sort(rowSums(m), decreasing = TRUE) #????????

names(v)
d<-data.frame(word=names(v), freq=v)

# install.packages("SnowballC") #????????,  runs, running, run,... => run
library(SnowballC)
# install.packages("wordcloud")
library(wordcloud)
# install.packages("RColorBrewer")
library(RColorBrewer)


wordcloud(words=d$word, freq=d$freq, min.freq=5,
          max.words=200, random.order=FALSE,
          colors=brewer.pal(8, "Dark2"))






Corpus(VectorSource(sms_raw$text))



sms_corpus<-VCorpus(VectorSource(sms_raw$text))
sms_corpus
inspect(sms_corpus[1:3])

sms_raw$text[3]

as.character(sms_corpus[[1]])
lapply(sms_corpus[1:3], as.character)
#sms_corpus[1:3] text?????? ????�� Ȯ??

sms_corpus_clean<-tm_map(sms_corpus, removeNumbers)
sms_corpus_clean<-tm_map(sms_corpus_clean, content_transformer(tolower))
sms_corpus_clean<-tm_map(sms_corpus_clean, removePunctuation)
sms_corpus_clean<-tm_map(sms_corpus_clean, removeWords, stopwords())

removePunctuation("hello..., ; :hihihi")

myReplace<-function(x){
  gsub("[[:punct:]]+" , " ", x)
}
myReplace("hello......world")

wordStem(c("learn", "learned", "learning", "learns"))

sms_corpus_clean<-tm_map(sms_corpus_clean, stemDocument) #sms_corpus_clean?? ?ִ? ?ܾ??鿡 ???? ???? ????(wordStem)
sms_corpus_clean<-tm_map(sms_corpus_clean, stripWhitespace) #sms_corpus_clean?? ?ִ? ?ܾ??鿡 ???? ???? ????(wordStem)


#stripWhitespace : "a     b     c" => "a b c"

lapply(sms_corpus[1:3], as.character)
# "Hope you are having a good week. Just checking in"
# "K..give back my thanks."
# "Am also doing in cbe only. But have to pay."

lapply(sms_corpus_clean[1:3], as.character)
# "hope good week just check"
# "kgive back thank"
# "also cbe pay"

sms_dtm<-DocumentTermMatrix(sms_corpus_clean)
sms_dtm

#5559*6906 ????38390454
#38347198+43256=5559*6906

##################???????? ?????? ??ó??##################

# 1. Ʈ???̴?/ ?׽?Ʈ ????
# 2. ????Ŭ??????(?ð?ȭ, ????/??)


sms_train_labels<-sms_raw[1:4169,]$type #Ʈ???̴? ?????? ��??
sms_tests_labels<-sms_raw[4170:5559,]$type#?׽?Ʈ ?????? ��??

sms_dtm_train<-sms_dtm[1:4169,]
sms_dtm_test<-sms_dtm[4170:5559,]


prop.table(table(sms_train_labels))

prop.table(table(sms_tests_labels))

# 트레이닝 데이터 → 베이지안 필터기 → 테스트 데이터 
# → 분류결과(예측), 실제(정답) 비교


wordcloud(sms_corpus_clean, min.freq=50, random.order=FALSE)

spam<-subset(sms_raw, type=="spam")
ham<-subset(sms_raw, type=="ham")
ham

wordcloud(spam$text, max.words=50, random.order=FALSE)
wordcloud(ham$text, max.words=50, random.order=FALSE)



# sms_dtm_train => sms_train_labels
# sms_dtm_test  => sms_tests_labels

# install.packages('e1071') # 베이지안 필터기 라이브러리
library(e1071)

sms_dtm_train

# 0이 많은 애들
sms_dtm_freq_train<-removeSparseTerms(sms_dtm_train,0.999)
sms_dtm_freq_train

# 5번 이상 언급된 단어들
sms_freq_words<-findFreqTerms(sms_dtm_train,5)

str(sms_freq_words) # 1151개 단어 벡터

sms_dtm_freq_train<-sms_dtm_train[,sms_freq_words]
sms_dtm_freq_test<-sms_dtm_test[,sms_freq_words]

# 나이브베이즈 분류기는 범주형 데이터에 대해 훈련!
# 현재 희소행렬(단어 횟수를 나타내는 숫자로 표현) → 범주형으로 변환 필요.
# 셀의 값이 1이상이면 yes, 아니면 no로 변환! → 범주형이지.

inspect(sms_dtm_freq_train)
inspect(sms_dtm_freq_test)

convertCounts<-function(x){
  x<-ifelse(x>0,"yes","No")
}

sms_train<-apply(sms_dtm_freq_train, MARGIN = 2, convertCounts)
# MARGIN =1 은 행 / 2는 열
sms_test<-apply(sms_dtm_freq_test, MARGIN = 2, convertCounts)
sms_test

sms_train[,1]
sms_train[1,]

help(naiveBayes)

smsClassifier<-naiveBayes(sms_train,sms_train_labels,laplace = 1) # 모델 완성
# 단어 1151개, 이메일 5569개
# 단어로 우도표를 만들었어!(naiveBayes)

sms_test_pred<-predict(smsClassifier,sms_test)

# install.packages('gmodels')
library(gmodels)
CrossTable(sms_test_pred,sms_tests_labels, dnn = c("predicted","actual"))

