import urllib.request
req = urllib.request
d = req.urlopen("http://wikidocs.net")
data = d.read()
data = data.decode("utf-8")
print(data )  # 웹페이지      #print(   d.read().decode("utf-8"  )    )
status = d.getheaders()
for s in status :
    print(s)