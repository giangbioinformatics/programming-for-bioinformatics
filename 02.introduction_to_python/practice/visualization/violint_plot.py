import pandas as pd
from scipy.stats import ttest_ind

# Load data from DataFrame
data = pd.read_csv("/home/nguyen/Desktop/Projects/Gastric-Cancer-Early-Detection/data/processed_data/train_GSE164174.csv")

# Separate data into two groups
group1 = data[data['target'] == 0]['MIMAT0022259'].values
group2 = data[data['target'] == 1]['MIMAT0022259'].values

# Perform t-test
t, p = ttest_ind(group1, group2)

# Print results
print("t-value:", t)
print("p-value:", p)