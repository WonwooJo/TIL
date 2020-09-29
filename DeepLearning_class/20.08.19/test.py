name = input('파일명: ')
nameList = name.strip().split('.jpg')[:-1]
print(nameList)

for i in nameList:
    if len(i.strip()) == 1:
        print('00{}.jpg'.format(i))
    elif len(i.strip()) == 2:
        print('0{}.jpg'.format(i))
    elif len(i.strip()) == 3:
        print('{}.jpg'.format(i))