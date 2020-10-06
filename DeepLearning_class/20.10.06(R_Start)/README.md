# R

> 머신러닝에 주로 쓰이는 언어. 체감상 파이썬보다는 문법이 쉽다.



## 주요내용

> 하루하루 교육받으며 유용한 것들 정리.



### 1. 라이브러리(패키지) 설치

> python에서는 `pip install libraryName`,  Anaconda에서는 `conda install libraryName`였다.

- `install.packages('libraryName')`으로 library명을 입력하면 된다.
- 또는 https://cran.r-project.org/ 여기에 들어가서 직접 받아도 된다.



### 2.기초를 배우며 느낀 파이썬과 다른 점

> python에서는 따로 벡터를 만든다는 개념은 없었다. 리스트나 딕셔너리, 튜플 등으로 만들었다.

- `eng <- c(50,60,70)`과 같이 python에서는 `=`역할을 R에서는 `<-`으로 한다.

- Dataframe을 만들때도 python에서는 `pd.DataFrame()`을 활용했지만 R에서는 `data.frame()`으로 만든다. 

- python에서는 `.`으로 dataframe에 종속된 column을 뽑을 수 있었는데, R에서는 `$`을 활용한다. 그래서 python에서는 `df.eng`가 R에서는 `df$eng`로 표현된다.
- 데이터를 불러올 때 python에서는 `pd.read_csv("fileName")`으로 쓰였는데 이와 비슷하게 `read_excel('fileName')`로 쓸 수 있다.
- dataframe의 정보를 볼때 python에서는 `df.info()`였으나 R에서는 `str(df)`으로 쓰인다.
- head, tail도 비슷하게 쓰인다. R에서 `head(df)`,`tail(df)`
- `View(df)`를 활용해서 이쁜 표로 볼 수 있다(V 대문자 주의)
- python에서 `df.shape()`은 R에서 `dim(df)`로 쓰인다.
- python에서 `df.describe()`은 R에서 `summary(df)`로 쓰인다.

- python에서 `where()`을 이용해 조건문, 참, 거짓을 활용했다면, R에서는 `ifelse()`를 통해 똑같이 활용할 수 있다(중첩도 가능)

- dataframe 합칠때 python: `merge()`or`concat()`을 썼으나 R에서는 `left_join()`을 활용.

- R의 파이프 연산자가 굉장히 편했다

  - ex) `df %>% filter(math>=70 & english>=70)`

  - ​      `df %>% filter(math >=70 | englishj>=70)`

  - `df %>% filter(class==1 | class ==3 | class == 5)`와 같은 의미는

    `df %>% filter(%in% c(1,3,5))`로 표현이 가능하다

  - `filter`와 같이 많이 쓰이는 함수는 선택-`select`, 정렬- `arrange`가 있다. 특히 `arrange`의 defalut는 오름차순이기에 내림차순으로 하려면 `arrange(desc())`를 활용하면 된다.

  - 기존 변수들의 함수로 파생변수 추가 생성: `mutate` 활용

  - 많은 값을 하나의 요약값으로 합쳐라: `summarize`

  - `group_by`를 통해 python처럼 그룹화 가능.

  

  Python과 R의 다른 함수 정리	

| Python                                                     | R                                 | usage                         |
| ---------------------------------------------------------- | --------------------------------- | ----------------------------- |
| `pip install packageName`<br />`conda install packageName` | `install.packages('packageName')` | 패키지 설치                   |
| `pd.DataFrame()`                                           | `data.frame()`                    | dataframe 생성                |
| `.`<br /> `df.eng`                                         | `$`<br />`df%eng`                 | dataframe 종속 column 뽑을 때 |
| `eng = [50,60,70]`                                         | `eng <- c(50,60,70)`              | 변수 선언                     |
| `pd.read_xlsx("FileName.xlsx")`                            | `read_excel("FileName.xlsx")`     | csv 파일 불러오기             |
| `df.info()`                                                | `str(df)`                         | df 정보                       |
| `df.shape()`                                               | `dim(df)`                         | df 행x열 구조                 |
| `df.describe()`                                            | `summary(df)`                     | df 기술통계                   |
| `where()`                                                  | `ifelse()`                        | 조건문, 참, 거짓 함수         |
| `merge()`, `concat()`                                      | `left_join()`<br />`bind_rows()`  | df 합치기                     |

- 패키지명::데이터셋 (제공데이터셋 활용)
  - ex) `ggplot2::mpg

