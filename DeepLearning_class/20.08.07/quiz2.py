# 2. 다나와 메뉴
# # http://prod.danawa.com/list/?cate=112758&15main_11_02
# - 가격 데이터 추출 및 저장
# - 화면 크기 정보 추출 및 저장
# - cpu가 intel / AMD 추출 및 저장
# - 코어 정보 ex. 옥타, 헥사, 쿼드.. 추출 및 저장
# - ssd의 용량 추출 및 저장
# - 램 용량 추출 및 저장
# - 제조사 추출 및 저장

# >> 딕셔너리로 저장

# 이거 가지고 분석 할 수 있지.
# 통계적 측면: 상관계수(ex. 가격에 영향을 미치는 요인 등.)

from bs4 import BeautifulSoup
from selenium import webdriver
driver = webdriver.Chrome("C:\\Users\\joww0\\Desktop\\myPython\\chromedriver.exe")

url = 'http://prod.danawa.com/list/?cate=112758&15main_11_02'
driver.get(url)
pName = []
pPrice = []
plength = []
html = driver.page_source
soup = BeautifulSoup(html,'html.parser')
pNameList = soup.select('p.prod_name > a')
pPriceList = soup.select('p.price_sect > a')
plengthList = soup.select('a.view_dic')

for i in range(len(pNameList)):
    pName.extend([pNameList[i].getText('',1)])
    
for i in range(len(pPriceList)):
    pPrice.extend([pPriceList[i].getText('',1)])

for i in range(len(plengthList)):
    plength.extend([plengthList[i].getText('',1)])
    
print(pName, pPrice, plength)
