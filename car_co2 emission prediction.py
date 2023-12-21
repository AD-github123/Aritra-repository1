import pandas as pd
from sklearn import linear_model
survey={"name":["toyota","skoda","fiat","mini","vw"],
         "volume":[1000,1000,900,1500,1000],
         "weight":[790,929,865,1140,929],
         "co2":[99,95,90,105,105]}
df=pd.DataFrame(survey)
df.to_csv('survey.csv')
df2=pd.read_csv('survey.csv')
x=df2[['weight','volume']]
y=df2['co2']
model=linear_model.LinearRegression()
model.fit(x,y)
predict=model.predict([[1200,2000]])
print(predict)
