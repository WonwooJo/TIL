from bs4 import BeautifulSoup
from selenium import webdriver
import time
driver = webdriver.Chrome("c:/mychrome/chromedriver.exe")
# driver = webdriver.Chrome("c:/mychrome/chromedriver.exe")

def insta_searching(word): # word 검색
    url = 'https://www.instagram.com/explore/tags/'+word
    return url
    
    
word = '제주도맛집'
url = insta_searching(word)
# print(url) # 본 url을 통해 스크래핑!
# driver.get(url)
first = driver.find_element_by_css_selector("div._9AhH0")    # 인스타 사진 클릭 후 내용까지 가지고 옴
first.click()
time.sleep(2)
driver.page_source
