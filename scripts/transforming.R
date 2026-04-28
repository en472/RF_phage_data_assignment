
## This script contains the code for normalisation and scaling of the data prior to random forest ======


# unbalanced =======================================================================

# region -----------------------------

NR_region <- read.csv('kmer_region.csv', row.names = 1)

# normalise

NR_region_norm <- sweep(NR_region[, 1:21627], 2, colSums(NR_region[, 1:21627]) , '/') * 100

# scale

NR_region_scale <- scale(NR_region_norm[, 1:21627], center = TRUE, scale = TRUE)

# add back on the label column

NR_region_ready <- cbind(NR_region_scale, NR_region$region)
colnames(NR_region_ready)[21628] <- 'region'

# country ------------------------------------------

NR_country <- read.csv('kmer_country_filtered.csv', row.names = 1)

# normalise

NR_country_norm <- sweep(NR_country[, 1:21627], 2, colSums(NR_country[, 1:21627]) , '/') * 100

# scale

NR_country_scale <- scale(NR_country_norm[, 1:21627], center = TRUE, scale = TRUE)

# add back on the label column

NR_country_ready <- cbind(NR_country_scale, NR_country$country)
colnames(NR_country_ready)[21628] <- 'country'

# export

write.csv(NR_region_ready, 'NR_region_ready.csv')

write.csv(NR_country_ready, 'NR_country_ready.csv')


# manual over/under sampling =================================================

# region ---------------------------------------------------------------------

MO_region <- read.csv('region_oversampled_data.csv', row.names = 1)

# normalise

MO_region_norm <- sweep(MO_region[, 1:21627], 2, colSums(MO_region[, 1:21627]) , '/') * 100

# scale

MO_region_scale <- scale(MO_region_norm[, 1:21627], center = TRUE, scale = TRUE)

# add back label col
MO_region_ready <- cbind(MO_region_scale, MO_region$region)
colnames(MO_region_ready)[21628] <- 'region'

# country ---------------------------------------------------------------------

MO_country <- read.csv('country_oversampling.csv', row.names = 1)

# normalise

MO_country_norm <- sweep(MO_country[, 1:21627], 2, colSums(MO_country[, 1:21627]) , '/') * 100

# scale

MO_country_scale <- scale(MO_country_norm[, 1:21627], center = TRUE, scale = TRUE)

# add back on the label column

MO_country_ready <- cbind(MO_country_scale, MO_country$country)
colnames(MO_country_ready)[21628] <- 'country'

# export

write.csv(MO_region_ready, 'MO_region_ready.csv')

write.csv(MO_country_ready, 'MO_country_ready.csv')

# SMOTE =========================================================================

# region ------------------------------------------------------------------------

smote_region <- read.csv('smote_region.csv', row.names = 1)

# normalise

smote_region_norm <- sweep(smote_region[, 1:21627], 2, colSums(smote_region[, 1:21627]) , '/') * 100

# scale

smote_region_scale <- scale(smote_region_norm[, 1:21627], center = TRUE, scale = TRUE)

# add back label col
smote_region_ready <- cbind(smote_region_scale, smote_region$region)
colnames(smote_region_ready)[21628] <- 'region'

# country ----------------------------------------------------------------------

smote_country <- read.csv('smote_country.csv', row.names = 1)

# normalise

smote_country_norm <- sweep(smote_country[, 1:21627], 2, colSums(smote_country[, 1:21627]) , '/') * 100

# scale

smote_country_scale <- scale(smote_country_norm[, 1:21627], center = TRUE, scale = TRUE)

# add back label col
smote_country_ready <- cbind(smote_country_scale, smote_country$country)
colnames(smote_country_ready)[21628] <- 'country'

# export

write.csv(smote_region_ready, 'smote_region_ready.csv')

write.csv(smote_country_ready, 'smote_country_ready.csv')


# testing data ==================================================================

# read in 
testing_data <- read.csv('testing_data.csv', row.names = 1)

# take list of k-mers included for filtering test dataset
kmers_included <- colnames(NR_region_scale)

# filter for only kmers which are included in the training data
testing_data_numbers <- testing_data %>%
  select(all_of(kmers_included))

# normalise
testing_data_norm <- sweep(testing_data_numbers[, 1:21627], 2, colSums(testing_data_numbers[, 1:21627]) , '/') * 100

# scale
testing_data_scale <- scale(testing_data_norm[, 1:21627], center = TRUE, scale = TRUE)

# add back the labels
testing_data_labelled <- cbind(testing_data_scale, testing_data$region)
colnames(testing_data_labelled)[21628] <- 'region'

testing_data_labelled <- cbind(testing_data_labelled, testing_data$country)
colnames(testing_data_labelled)[21629] <- 'country'

# export
write.csv(testing_data_labelled, 'testing_data_ready.csv')

