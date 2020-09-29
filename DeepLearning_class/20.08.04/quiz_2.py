# 2
###### 이메일 주소 검사기 ######
# 이메일: ID + @ + mail

import re

inputEmail = str(input("Write e-mail address: "))
res = re.match('(?P<ID>[a-zA-Z0-9_.]+)@(?P<domain_adr>[a-zA-Z0-9]+[.a-z]+)',inputEmail)
print('ID: {} 입력'.format(res.group('ID')))
print('domain: {} 입력'.format(res.group('domain_adr')))



