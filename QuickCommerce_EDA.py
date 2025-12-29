import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("D:\\Movies\\Project\\ AQI-data-set\\ecommerce_delivery_analytics.csv")

#print(df)
#print("Shape :",df.shape)
#print("Info :",df.info())
#print("Describe :",df.describe())
#print("Sum Null :",df.isnull().sum())
#print("Duplicate :",df.duplicated().sum())

# Convert datetime safely
df['Order Date & Time'] = pd.to_datetime(
    df['Order Date & Time'],
    errors='coerce'
)

# Feature Engineering
df['Delayed'] = np.where(df['Delivery Delay'] == 'Yes', 1, 0)
df['Refund_Flag'] = np.where(df['Refund Requested'] == 'Yes', 1, 0)
df['Order_Hour'] = df['Order Date & Time'].dt.hour

#print(df[['Order Date & Time','Order_Hour']].head())

#### Complete Analysis

### Delivery Time Distribution
plt.figure()
sns.histplot(df['Delivery Time (Minutes)'], bins=30)
plt.title("Delivery Time Distribution")
plt.show()

### Rating vs Delivery Time
plt.figure()
sns.boxplot(x='Service Rating', y='Delivery Time (Minutes)', data=df)
plt.title("Delivery Time vs Rating")
plt.show()

### Refund vs Delivery Delay
refund_delay = df.groupby('Delivery Delay')['Refund_Flag'].mean() * 100
refund_delay.plot(kind='bar')
plt.title("Refund % by Delivery Delay")
plt.show()

### CORRELATION ANALYSIS
plt.figure()
sns.heatmap(df[['Delivery Time (Minutes)', 'Service Rating', 'Refund_Flag']].corr(), annot=True)
plt.title("Correlation Heatmap")
plt.show()
