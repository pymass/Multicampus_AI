import urllib.request
d = urllib.request.urlopen("https://wikidocs.net")

data =  d.read()
data =  data.decode("utf-8")
print(   data  )   #크롤웹 페이지

import re
print(re.search("[가-힣]",data) )