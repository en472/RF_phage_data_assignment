
# predictions ==========================================================================================

print('Starting...')

import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report
import pickle

# read in test data ===================================================================================

test_data = pd.read_csv('C:/Users/enewc/Documents/assignments/Lauren/testing_data_ready.csv', index_col = 0) 

# split labels from data
test_data_numbers = test_data.drop('region', axis = 1)

test_data_numbers = test_data_numbers.drop('country', axis = 1)

test_data_region_labels = test_data['region']

test_data_country_labels = test_data['country']

print('test data read in')

# region-level predictions ============================================================================

# RF model trained on unbalanced data -----------------------------------------------------------

# read in model
with open('C:/Users/enewc/Documents/assignments/Lauren/models/NR_region_model.pkl', 'rb') as f:
    NR_region_model = pickle.load(f)

print('model loaded')

# run prediction
predicted_region_labels = NR_region_model.predict(test_data_numbers)

print('prediction complete')

# assess accuracy
accuracy = accuracy_score(test_data_region_labels, predicted_region_labels)

class_report = classification_report(test_data_region_labels, predicted_region_labels)

# find most important features

NR_region_feature_values = NR_region_model.feature_importances_

NR_region_feature_names = NR_region_model.feature_names_in_

# save these features as csv file

NR_region_top_features = pd.DataFrame({"names" : NR_region_feature_names, "importance" : NR_region_feature_values})

NR_region_top_features.to_csv("NR_region_top_features.csv", index = False)

print('NR REGION MODEL PREDICION:')

print(accuracy)

print(class_report)

print('NR REGION MODEL PREDICTION COMPLETE')


# RF model trained on manually balanced data -----------------------------------------------------------

# read in model
with open('C:/Users/enewc/Documents/assignments/Lauren/models/MO_region_model.pkl', 'rb') as f:
    MO_region_model = pickle.load(f)

print('model loaded')

# run prediction
predicted_region_labels = MO_region_model.predict(test_data_numbers)

print('prediction complete')

# assess accuracy
accuracy = accuracy_score(test_data_region_labels, predicted_region_labels)

class_report = classification_report(test_data_region_labels, predicted_region_labels)

# find most important features

MO_region_feature_values = MO_region_model.feature_importances_

MO_region_feature_names = MO_region_model.feature_names_in_

# save these features as csv file

MO_region_top_features = pd.DataFrame({"names" : MO_region_feature_names, "importance" : MO_region_feature_values})

MO_region_top_features.to_csv("MO_region_top_features.csv", index = False)

print('MO REGION MODEL PREDICION:')

print(accuracy)

print(class_report)

print('MO REGION MODEL PREDICTION COMPLETE')


# RF model trained on SMOTE rebalanced data -----------------------------------------------------------

# read in model
with open('C:/Users/enewc/Documents/assignments/Lauren/models/SM_region_model.pkl', 'rb') as f:
    SM_region_model = pickle.load(f)

print('model loaded')

# run prediction
predicted_region_labels = SM_region_model.predict(test_data_numbers)

print('prediction complete')

# assess accuracy
accuracy = accuracy_score(test_data_region_labels, predicted_region_labels)

class_report = classification_report(test_data_region_labels, predicted_region_labels)

# find most important features

SM_region_feature_values = SM_region_model.feature_importances_

SM_region_feature_names = SM_region_model.feature_names_in_

# save these features as csv file

SM_region_top_features = pd.DataFrame({"names" : SM_region_feature_names, "importance" : SM_region_feature_values})

SM_region_top_features.to_csv("SM_region_top_features.csv", index = False)

print('SM REGION MODEL PREDICION:')

print(accuracy)

print(class_report)

print('SM REGION MODEL PREDICTION COMPLETE')

# Country-level predictions =====================================================================

# RF model trained on unbalanced data -----------------------------------------------------------

# read in model
with open('C:/Users/enewc/Documents/assignments/Lauren/models/NR_country_model.pkl', 'rb') as f:
    NR_country_model = pickle.load(f)

print('model loaded')

# run prediction
predicted_country_labels = NR_country_model.predict(test_data_numbers)

print('prediction complete')

# assess accuracy
accuracy = accuracy_score(test_data_country_labels, predicted_country_labels)

class_report = classification_report(test_data_country_labels, predicted_country_labels)

# find most important features

NR_country_feature_values = NR_country_model.feature_importances_

NR_country_feature_names = NR_country_model.feature_names_in_

# save these features as csv file

NR_country_top_features = pd.DataFrame({"names" : NR_country_feature_names, "importance" : NR_country_feature_values})

NR_country_top_features.to_csv("NR_country_top_features.csv", index = False)

print('NR COUNTRY MODEL PREDICION:')

print(accuracy)

print(class_report)

print('NR COUNTRY MODEL PREDICTION COMPLETE')


# RF model trained on manually balanced data -----------------------------------------------------------

# read in model
with open('C:/Users/enewc/Documents/assignments/Lauren/models/MO_country_model.pkl', 'rb') as f:
    MO_country_model = pickle.load(f)

print('model loaded')

# run prediction
predicted_country_labels = MO_country_model.predict(test_data_numbers)

print('prediction complete')

# assess accuracy
accuracy = accuracy_score(test_data_country_labels, predicted_country_labels)

class_report = classification_report(test_data_country_labels, predicted_country_labels)

# find most important features

MO_country_feature_values = MO_country_model.feature_importances_

MO_country_feature_names = MO_country_model.feature_names_in_

# save these features as csv file

MO_country_top_features = pd.DataFrame({"names" : MO_country_feature_names, "importance" : MO_country_feature_values})

MO_country_top_features.to_csv("MO_country_top_features.csv", index = False)

print('MO COUNTRY MODEL PREDICION:')

print(accuracy)

print(class_report)

print('MO COUNTRY MODEL PREDICTION COMPLETE')


# RF model trained on SMOTE rebalanced data -----------------------------------------------------------

# read in model
with open('C:/Users/enewc/Documents/assignments/Lauren/models/SM_country_model.pkl', 'rb') as f:
    SM_country_model = pickle.load(f)

print('model loaded')

# run prediction
predicted_country_labels = SM_country_model.predict(test_data_numbers)

print('prediction complete')

# assess accuracy
accuracy = accuracy_score(test_data_country_labels, predicted_country_labels)

class_report = classification_report(test_data_country_labels, predicted_country_labels)

# find most important features

SM_country_feature_values = SM_country_model.feature_importances_

SM_country_feature_names = SM_country_model.feature_names_in_

# save these features as csv file

SM_country_top_features = pd.DataFrame({"names" : SM_country_feature_names, "importance" : SM_country_feature_values})

SM_country_top_features.to_csv("SM_country_top_features.csv", index = False)

print('SM COUNTRY MODEL PREDICION:')

print(accuracy)

print(class_report)

print('SM COUNTRY MODEL PREDICTION COMPLETE')

print('END - PREDICTIONS COMPLETE')
