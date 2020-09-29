# 3
###### 도메인 주소(URL) 검사기 ######
#   시작: http:// or https://
#   가능한 주소: http://www.abc.com/sub/sub2/index.do?k=id=test  # ?, =, 알파벳 가능
#             http://www.abc.com/sub/sub2/index.html
#             http://www.abc.com/sub/sub2/index.do
#   안되는 주소: http://www.abc.com/sub/sub2/
#             http://www.abc.com/sub/sub2
import re

inputAdr = input('Write URL: ')
res = re.match('(?P<http>http[s]{0,1}\:\/\/)www.[a-zA-Z0-9./]+(\?*)[a-zA-Z0-9]+\=*[a-zA-Z0-9]+'
,inputAdr)

print(res)
