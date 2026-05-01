# RF_phage_data_assignment

This repository contains all of the necessary scripts/models for the E. coli assignment, where I created a series of random forest classifiers to predict the origin of Shiga-toxigenic E. coli samples at the region and country level.

## Scripts:

### cleaning.R

Contains the code for all of the data prep and preprocessing.

### SMOTE.py

Performs synthetic minority oversampling technique (SMOTE) on datasets the balance groups.

### transforming.R

Transforms data to be compatible for machine learning.

### random_forest.py

Trains six separate random foest models - three for predicting region, three for predicting country. Of each three, one if trained on unbalaned data, one on manually over sampled data, and one on SMOTE-rebalanced data.

### predict.py

Tasks the models with predicting the origin of STEC samples, and records performance metrics.

### feature_processing.R

Extracts the most informative features from each model, as well as the top 3 features from the region/country SMOTE-trained models for further analysis (as this was the best performing model).

### graphing.R 

Produces graphs as seen in the paper.

