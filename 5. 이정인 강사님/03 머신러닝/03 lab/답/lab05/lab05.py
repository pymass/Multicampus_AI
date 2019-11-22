import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

tmp = pd.read_excel("지역_위치별(주유소).xls" )
data = tmp[   tmp["고급휘발유"]   != '-' ]  # 고급휘발유 데이터가 '-' 인 행을 제외
data["고급휘발유"] = [  float(value1)  for value1 in data["고급휘발유"] ]

price_data =data[ ["휘발유","경유" ] ]
price_label =data["고급휘발유"]

train_data, test_data, train_label,test_label  = \
  train_test_split(price_data, price_label )


clf = LinearRegression()
clf.fit(price_data, price_label   )
pre = clf.predict(test_data)
print(pre)










