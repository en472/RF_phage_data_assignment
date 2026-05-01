
# libraries

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from imblearn.over_sampling import SMOTE
import csv


# read in data

data = pd.read_csv("C:/Users/enewc/Documents/assignments/Lauren/data_for_smote_country.csv", index_col=0)

# check data imported correctly

print(data.head())

# use multi-smote to adjust class imbalance ===========

# split labels from main data
country_numbers = data.drop(columns = ['country'])

country_labels = data['country']

# plot imbalanced data for example

idx, c = np.unique(country_labels, return_counts = True)
sns.barplot(x = idx, y = c)
plt.show()

country_data_resampled, country_labels_resampled = SMOTE(random_state = 123, k_neighbors = 2).fit_resample(country_numbers, country_labels)

idx, c = np.unique(country_labels_resampled, return_counts = True)
sns.barplot(x = idx, y = c)
plt.show()

# join labels and data again

smote_country = pd.concat([country_data_resampled, country_labels_resampled], axis=1)

print(smote_country.head())

# export data

smote_country.to_csv('smote_country.csv')


