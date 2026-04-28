
# Random Forest Classifiers ========================================================================================================

# This script contains the code for training each random forest model (from unbalanced, manually over/undersampled, or smote 
# rebalanced data) for region-level and country-level predictions

# Takes about 1 hr 20 mins to run in total 

print('Starting...')

# import libraries
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report
import pickle

# Region level predictors ==========================================================================================================

# Unbalanced -----------------------------------------------------------------------------------------------------------------------

# read in dataset
NR_data_region = pd.read_csv('path/NR_region_ready.csv', index_col = 0) 

print('file read')

# split label from data
NR_data_region_numbers = NR_data_region.drop('region', axis = 1)

NR_data_region_labels = NR_data_region['region']

# train model - use default 100 trees
NR_region_model = RandomForestClassifier(n_estimators = 100, random_state = 22)
NR_region_model.fit(NR_data_region_numbers, NR_data_region_labels)

# save model
with open('NR_region_model.pkl', 'wb') as file:
    pickle.dump(NR_region_model, file)

print('Unbalanced region model trained - saved as NR_region_model.pkl')


# Manual Over/Under sampling -------------------------------------------------------------------------------------------------------

# read in dataset
MO_data_region = pd.read_csv('path/MO_region_ready.csv', index_col = 0) 

print('file read')

# split label from data
MO_data_region_numbers = MO_data_region.drop('region', axis = 1)

MO_data_region_labels = MO_data_region['region']

# train model - use default 100 trees
MO_region_model = RandomForestClassifier(n_estimators = 100, random_state = 22)
MO_region_model.fit(MO_data_region_numbers, MO_data_region_labels)

# save model
with open('MO_region_model.pkl', 'wb') as file:
    pickle.dump(MO_region_model, file)

print('Manual Over/undersampling region model trained - saved as MO_region_model.pkl')


# SMOTE ----------------------------------------------------------------------------------------------------------------------------

# read in dataset
SM_data_region = pd.read_csv('path/smote_region_ready.csv', index_col = 0) 

print('file read')

# split label from data
SM_data_region_numbers = SM_data_region.drop('region', axis = 1)

SM_data_region_labels = SM_data_region['region']

# train model - use default 100 trees
SM_region_model = RandomForestClassifier(n_estimators = 100, random_state = 22)
SM_region_model.fit(SM_data_region_numbers, SM_data_region_labels)

# save model
with open('SM_region_model.pkl', 'wb') as file:
    pickle.dump(SM_region_model, file)

print('SMOTE rebalanced region model trained - saved as SM_region_model.pkl')

print(f'Region level models complete - 50% done')

# Country level predictors =========================================================================================================

# Unbalanced -----------------------------------------------------------------------------------------------------------------------

# read in dataset
NR_data_country = pd.read_csv('path/NR_country_ready.csv', index_col = 0) 

print('file read')

# split label from data
NR_data_country_numbers = NR_data_country.drop('country', axis = 1)

NR_data_country_labels = NR_data_country['country']

# train model - use default 100 trees
NR_country_model = RandomForestClassifier(n_estimators = 100, random_state = 22)
NR_country_model.fit(NR_data_country_numbers, NR_data_country_labels)

# save model
with open('NR_country_model.pkl', 'wb') as file:
    pickle.dump(NR_country_model, file)

print('Unbalanced country model trained - saved as NR_country_model.pkl')

# Manual Over/Under sampling -------------------------------------------------------------------------------------------------------

# read in dataset
MO_data_country = pd.read_csv('path/MO_country_ready.csv', index_col = 0) 

print('file read')

# split label from data
MO_data_country_numbers = MO_data_country.drop('country', axis = 1)

MO_data_country_labels = MO_data_country['country']

# train model - use default 100 trees
MO_country_model = RandomForestClassifier(n_estimators = 100, random_state = 22)
MO_country_model.fit(MO_data_country_numbers, MO_data_country_labels)

# save model
with open('MO_country_model.pkl', 'wb') as file:
    pickle.dump(MO_country_model, file)

print('Manual Over/Undersampled country model trained - saved as MO_country_model.pkl')

# SMOTE ----------------------------------------------------------------------------------------------------------------------------

# read in dataset
SM_data_country = pd.read_csv('path/smote_country_ready.csv', index_col = 0) 

print('file read')

# split label from data
SM_data_country_numbers = SM_data_country.drop('country', axis = 1)

SM_data_country_labels = SM_data_country['country']

# train model - use default 100 trees
SM_country_model = RandomForestClassifier(n_estimators = 100, random_state = 22)
SM_country_model.fit(SM_data_country_numbers, SM_data_country_labels)

# save model
with open('SM_country_model.pkl', 'wb') as file:
    pickle.dump(SM_country_model, file)

print('SMOTE rebalanced country model trained - saved as SM_country_model.pkl')

print(f'Complete - 100% done')