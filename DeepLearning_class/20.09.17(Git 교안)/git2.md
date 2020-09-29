# Git II



## 협업 3가지 시나리오

### 1. Push & Pull

- 단점: 앞의 태스크가 완료되어야 뒤의 태스크가 이어질 수 있는 일: 끝말잇기

### 2. Branch & PR(Pull Request)

- 표준 협업 모델

### 3. Fork & PR

- 오픈소스 운영



## Branch

> (대부분의 feature) branch는 일회용

### (1) `git branch`

- 현재 존재하는 branch들을 출력



### (2) `git branch [브랜치이름]`

- 새로운 branch 생성



### (3) `git checkout [브랜치이름]`

- 특정 브랜치로 이동



### (4) `git merge [합칠브랜치이름]`

> S V O: master merges test

- **주의**: 메인이 되는 브랜치로 이동

- `git checkout master` & `git merge test`



### (5) `git branch -d [브랜치이름]`

- 병합(merge)된 브랜치를 삭제할 경우

- `git branch -D [브랜치이름]` : 병합되지 않은 브랜치를 삭제할 경우



## Merge 시나리오

> 같은 파일을 건드리지 않았을 경우,  (동일 라인이 변경 되지 않았을 경우)
>
> -> git이 자동으로 merge

### (1) Fast-forward Merge

- 분기된 상태에서 한 브랜치에만 커밋이 있을 경우
- Merge 하면, 추가 커밋이 생기지 않는다.

### (2) Auto-Merge

- 분기된 상태에서 양쪽 브랜치에 모두 커밋이 있을 경우
- Merge하면, 추가 커밋(merge commit)이 생긴다.

---

### (3) Conflict

> git이 자동으로 merge하지 못 하는 경우,

- 해당 파일이 영향이 갈 경우, merge 를 하지 않는다.



## Git pull은 반드시 해당 브랜치로 이동 후 실행한다.

- `git pull origin master` : master로 이동하여 pull 한다.

