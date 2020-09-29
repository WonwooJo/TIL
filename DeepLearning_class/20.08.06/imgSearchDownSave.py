from urllib.request import urlopen
from urllib.parse import quote_plus # 한글 >> 유니코드 자동 변환 
from bs4 import BeautifulSoup
baseUrl = 'https://search.naver.com/search.naver?where=image&sm=tab_jum&query='
word = input("검색어 입력: ") # ex) 강아지, 고양이 ...
num = int(input("크롤링 할 데이터 갯수: ")) # ex) 30

url = baseUrl + quote_plus(word)
html = urlopen(url)

soup = BeautifulSoup(html, 'html.parser')
img = soup.find_all(class_='_img') # _img 찾기

n=1
for i in img:
    imgUrl = i['data-source']
    with urlopen(imgUrl) as f:
        with open("c:\\img/dog"+str(n)+".jpg",'wb') as na:
            img = f.read()
            na.write(img)
    n+=1
    if n>num:
        break


# n=1
# for i in img:
#     imgUrl = i['data-source']
#     img = urlopen(imgUrl).read()
#     open("C:\\img/dog"+str(n)+".jpg",'wb')  #down1.jpg, down2.jpg... / wb: 바이너리 형식
#     f.write(img)
#     n+=1  # cpu 연산량 줄일 수 있엉 0.00001초? 큰 차이 없음 그러나 데이터 양이 많으면 ? 쌓여서 커질 수 있어.
#     f.close()
#     if num < n:
#         break
