import pandas as pd
from sklearn import svm, metrics
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import  MinMaxScaler

data = pd.read_csv("bmi.csv")
label = data["label"]

# w = data["weight"]/100
# h = data["height"]/200
# wh = pd.concat([w,h],axis=1)

scaler = MinMaxScaler()
wh =scaler.fit_transform(data.loc[:,["weight","height"]])

data_train, data_test, label_train, label_test = \
  train_test_split(wh, label)

clf = svm.SVC()
clf.fit(data_train,label_train)

pre = clf.predict(data_test)

ac_score = metrics.accuracy_score(label_test,pre)
cl_report = metrics.classification_report(label_test,pre)

print(ac_score)
print(cl_report)