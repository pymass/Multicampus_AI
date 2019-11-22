import os
print (os.getcwd())  # 현재 워킹 디렉토리 확인

f = open("test.txt", "a")

f.write(" 코드를 추가 합니다.  ")
f.close()

