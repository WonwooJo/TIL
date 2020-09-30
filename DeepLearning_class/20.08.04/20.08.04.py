'''
정규표현식: 규칙(패턴)을 가진 문자열을 표현하는 방법
영화 댓글, 커뮤니티 질문/답변, 지식인 등...

###### 웹 크롤링(스크랩핑) ######

# Regular Expression #
import re
# 모듈: *.py가 붙은 파이썬 파일(함수, 클래스 등 포함)
# 패키지: 모듈, 패키지들의 집합.

'''
import re
# re.match('패턴','문자열')
# 문자열 속에 패턴이 있습니까?
re.match('hello','hello, world')
# re.match('python','hello, world')
# ^문자열 : 문자열이 맨 앞에 오냐?
# 문자열$ : 문자열이 맨 마지막에 오냐?
re.search('^hello', 'hello, world')
re.search('hello$', 'hello, world')

# | = or의 의미. hello or world가 있냐?
re.match('hello|world','hello')
jumin = '''
kim 850101-1234567
lee 950202-2345678
'''
res = []
for l in jumin.split('\n'):
    for w in l.split(' '):
        if len(w) == 14 and w[7:].isdigit():  #isdigit: 숫자냐 아니냐?
            print(w[:6]+'-'+'*******')


mypat = re.compile('(\d{6})[-]\d{7}') #match(패턴, 문자열),search / ():그룹
print(mypat.sub('\g<1>-*******', jumin)) # \g<1>: 1번 그룹은 그대로 출력, 그 뒷자리는 *로 출력 

# 정규표현식에서는 메타문자가 쓰인다.

# 메타문자: 본래 의미의 문자가 아니라 다른 의미로 쓰여진다.
# *(곱하기) → 문자 0개 이상, *(더하기) → (문자 1개 이상)
# ., &, ^, {}, [], () 등 많음.
# []: 대괄호 내부에 있는 문자들과 매치(숫자, 문자, 특수문자 가능.)
# [abc]: a와 b 또는 c와 매치되는지? 어느 한개의 문자와 매치가 되는가?
# 패턴식: [abc], 문자열:'a'  → 'a'가 abc에 포함되니까!
#                문자열:'d'  → 매치 안됨.
# [abc], 문자열:'bye' → 첫글자 'b'만 매치

# [a-z]: 알파벳 소문자
# [a-zA-Z0-9]: 알파벳, 숫자 모두 포함
# [가-힣ㄱ-ㅎ]: 한글 모두 포함
# [^A-Z]: []안에 ^를 쓰면 'not'의 의미, 알파벳 대문자를 제외한 모두와 매치.
# [^0-9]: 숫자를 제외한 모두와 매치.
# \d: 숫자와 매치 == [0-9]
# \D: 숫자를 제외하고 매치 == [^0-9]
# \w: 문자와 숫자 전부 매치 → [a-zA-Z0-9_] 알파벳 소문자, 대문자, 숫자, 언더바(특수문자 중 하나만)
# \W: 문자와 숫자를 제외하고 매치 == [^a-zA-Z0-9_]

# . (dot): 모든 문자와 매치(\n 제외)
# 정규표현식 패턴: a.b  →  a 다음 아무거나 와도 되고 그 다음 b
# 문자열: akb, a2b는 a.b에 매치됨.
# aby → 매치 안됨. (왜? a와 b 사이에 무조건 문자 하나가 와야함.)
# 정규표현식: a.b → a[.]b: 문자열 a.b와 매치.(즉, []안에 .을 넣어서 그냥 문자로 인식.)

# +: 1번 이상 반복
# 정규표현식: do+g
# 문자열: dog, doog, doooooooog 도 매치됨.   ('o'가 최소한 1번 이상은 나와야 함.)
#       : dg → 매치안됨.

# *: 0번 이상 반복
# 정규표현식:do*g
# 문자열: dog, doog, dooooooog, dg → 매치됨.

# {}: 반복횟수의 범위 지정
# 정규표현식: do{2}g → o문자가 반드시 2번 출현해야함. → doog만 매치.
# do{2,5}g: doog, dooog, dooooog → 매치됨 / dog → 매치안됨.
# do{1,}g: d[o]+g → o가 1번이상 나와야 함.

# ?: {0,1}과 같음. → 문자가 없어도 되고, 최대 1번까지 있어도 됨.
# 정규표현식: ab?c → abc, ac 매치됨

