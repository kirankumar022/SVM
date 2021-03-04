import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
le=LabelEncoder()
forest = pd.read_csv("E:/Assignments/Assignment week 13/SVM/Assignment/forestfires.csv")
forest.describe()
forest.columns
forest['size_category']=le.fit_transform(forest['size_category'])
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split

train,test = train_test_split(forest, test_size = 0.20)

train_X = train.iloc[:, 2:]
train_y = train.iloc[:, 30]
test_X  = test.iloc[:, 2:]
test_y  = test.iloc[:, 30]

# kernel = linear
help(SVC)
model_linear = SVC(kernel = "linear")
model_linear.fit(train_X, train_y)
pred_test_linear = model_linear.predict(test_X)

np.mean(pred_test_linear == test_y)

# kernel = rbf
model_rbf = SVC(kernel = "rbf")
model_rbf.fit(train_X, train_y)
pred_test_rbf = model_rbf.predict(test_X)
np.mean(pred_test_rbf==test_y)

