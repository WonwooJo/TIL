# 1. 네이버 지식인 질문의 제목을 스크래핑(검색어: 파이썬)
# # https://search.naver.com/search.naver?where=kin&sm=tab_jum&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC
# (현재 페이지 or 전체 페이지)

from bs4 import BeautifulSoup
from selenium import webdriver
driver = webdriver.Chrome("C:\\Users\\joww0\\Desktop\\myPython\\chromedriver.exe")

url = 'https://search.naver.com/search.naver?where=kin&sm=tab_jum&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC'
driver.get(url)
nList1 = []
html = driver.page_source
soup = BeautifulSoup(html,'html.parser')
title = soup.select('dt.question>a')
for i in range(len(title)):
    nList1 = title[i].getText()
    print(nList1)

