html = """ 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>나의 홈페이지</title>
</head>
<body  >
  <p align="center"><font color="blue" size="10px">
      홈페이지에 오신 것을 환영합니다.</font> </p>
  나의 사진 입니다.<br>
  <img src="Penguins.jpg" width="300" height="100" />
  <br>
  나의 기본 정보 입니다.
  <table border="1">
        <tr><td> 이름 </td> <td>전화번호</td><td>주소</td></tr>
        <tr><td> 홍길동 </td> <td>010-1111-2222</td><td>서울 광진구</td></tr>
  </table>
  <br>
  <br> 나의 관심 정보들입니다. 클릭하면 해당 사이트로 넘어갑니다.
  <br><a href="https://www.python.org/" >파이썬</a>
  <br><a href="https://www.tensorflow.org/" >텐서플로</a>
  <br><a href="https://www.naver.com" >네이버</a>
  <br><br> 취미 리스트 입니다.
  <ul>
        <li>스케이팅</li>
        <li>영화</li>
        <li>공연</li>
  </ul>
  <div style = "border:1px solid #110; width:500px; height:50px ">
  <marquee > 반갑습니다.</marquee>
  </div>
</body>
</html>"""

from bs4 import BeautifulSoup
bs = BeautifulSoup(html, features="html.parser")
# 문제1)  img 태그 정보
p_tag = bs.find("img" )
print(  p_tag )

#문제2)  img 태그의 모든 속성
p_tag = bs.find("img" )
print(  p_tag.attrs )

# 문제3) 모든 li 태그
il_tags = bs.find_all("li")
for i in il_tags :
    print(i)

#문제4)  모든 li 태그의 텍스트만 출력
for i in il_tags :
    print(i.string)

#문제5)  모든 href 속성 값만 출력

a_tags = bs.find_all("a")
for a in a_tags :
    print (a ["href"])

#문제6) head  태그의 모든 자식 태그명
head_tag = bs.find("head")
for i in head_tag.children :
    print(i.name)
