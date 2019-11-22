import pandas as pd
import tensorflow as tf
import numpy as np

""" 
    bmi.csv 파일을 읽어, 
    키와 몸무게값으로  thin/normal/fat 을 학습하고, 
    정확도를 구하세요. 
    
    ANN으로 시도.  정확도가 낮으면 DNN으로 시도해봅니다.
""" 

# 키, 몸무게, 레이블이 적힌 CSV 파일 읽어 들이기  
csv = pd.read_csv("bmi.csv")


# 데이터 정규화 --- 
csv["height"] = csv["height"] / 200
csv["weight"] = csv["weight"] / 100
 

# ONE HOT ENCORDING 
# csv["label"] 의 값을 아래와 같이 각각 바꾸거나, 
# 아래와 같은  새로운 Y 데이터 생성  
# thin=(1,0,0) / normal=(0,1,0) / fat=(0,0,1) 
 

# softmax 정의하기  
# 세션 시작하기
  
# 학습시키기
# 정답률 구하기 
 
          
  

