# Git I

Git 기초 - 코드 관리 & 원격 저장



## SCM & VCS

- Source Code Management(SCM): 코드 관리 도구

- Version Control System(VCS): 버전 관리 시스템
-  코드 관리 도구 
- how? **버전** 관리 (**commit**, 해당 폴더의 특정 시점의 사진/**스냅샷**)



## `git`의 역할

1. 코드 관리 도구
2. 코드 저장 도구
3. 협업 도구
4. 배포 도구



## 코드 관리 도구

> git은 `폴더 단위`로 코드를 관리
>
> ​	- git 저장소(repository) == git으로 관리되는 폴더

> git 저장소 상위 폴더에서 git을 시작하지 않음

### (1) `git init`

- git 저장소를 시작한다 == 현재 폴더를 git 저장소로 만든다. == git으로 관리되는 프로젝트 생성

```
Initialized empty Git repository in C:/Users/i/git/.git/
```

- `(master)`라는 표시가 프롬프트에 뜸
- `.git` 폴더가 생성
  - `.git` 폴더를 삭제하면 git 관리가 끝남



### (2) `git status`

- git의 현재상태를 알려줌

1. 최소 상태

```
On branch master
   -> master라는 branch에 있다.
No commits yet
   -> commit(버전, 스냅샷) 아직 없다.
nothing to commit (create/copy files and use "git add" to track)
   -> commit 할게 없다. (파일 만들어서, git add 해줘)
```



​	2. 파일 생성 후 상태

```
On branch master

No commits yet

Untracked files: (추적되지 않은 파일들)
  (use "git add <file>..." to include in what will be committed)
  -> "git add 파일명"을 사용하세요. 포함하기 위해서.
        a.txt

nothing added to commit but untracked files present (use "git add" to track)

```



### (3) `git add [파일명/폴더명]`

- 스냅샷을 찍기(commit 하기, 버전생성을) 위해 파일을 추가

- git add 후, status

```
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   a.txt
```



### (4) `git commit -m '메시지' ` 

- git 설치 후 최초로 commit을 하면,

```
*** Please tell me who you are.

Run

  git config --global user.email "hphk.john@gmail.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

```



### (5) `git log`

현재까지의 버전(commit, 스냅샷)을 모두 출력

- `--oneline` : 한줄로 표시
- `-숫자`: 특정 갯수만 출력 



### (6) `git checkout [커밋해시]`

- 특정 시점의 커밋을 체크

```
Note: switching to '709250'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 709250c First commit
```



## 코드 저장 도구

집, 캠퍼스 동시 작업시,



### (1) github 원격 저장소 생성

`https://github.com/[유저네임]/[원격저장소이름].git`



### (2) `git remote`

- 현재 등록된 원격저장소들의 목록

- `-v` 옵션: 자세한 정보 출력 



### (3) `git remote add [저장소이름] [저장소주소URL]` 

- 새로운 원격저장소를 추가

- 첫번째(원본) 원격저장소의 이름은 `origin` 하는 것이 관례(convention)



### (4) `git push [저장소이름] [브랜치이름]`

- 원격저장소에 코드 저장