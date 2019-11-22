"""
다음 url은  영화의 리뷰 정보가 있습니다. (인코딩은 utf-8)
1) 웹페이지를 크롤링하고,
 웹페이지를 분석하여
2) 리뷰정보만 출력하세요.
3) 리뷰정보를 텍스트 파일에 저장하세요. """

import urllib.request
target_url = "https://movie.daum.net/moviedb/grade?movieId=110902&type=netizen"
d = urllib.request.urlopen(target_url )
data =  d.read()
data =  data.decode("utf-8")

import re
from bs4 import BeautifulSoup
bs = BeautifulSoup(data, features="html.parser")
reviews =   bs.find_all(class_="desc_review")

with open("lab02_daum_movie_review.txt", "w",encoding="utf-8") as reviewFile :
    for review in reviews :
        result = review.get_text()
        result = re.sub("[\s]+"," ", result )
        print(result)
        reviewFile.write(result+"\n"  )
