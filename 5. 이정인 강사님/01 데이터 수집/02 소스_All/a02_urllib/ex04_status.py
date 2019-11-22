import urllib.request

d = urllib.request.urlopen("https://www.naver.com")
print ( d.status )

if d.status == 200 :
    print( d.read().decode("utf-8 "))