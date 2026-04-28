
## ===== This script contains the code for the data cleaning and rebalancing (NR - No Rebalancing and MO - Manual Over/Undersampling)  stage of the experiment =============

# Note: SMOTE was performed in python (SMOTE.py) but data is prepped for it in this file.

# libraries ------------------------------------------------------------------------------------------------------

library(tidyverse)
library(smotefamily) 

# read in training data ------------------------------------------------------------------------------------------

# kmers
kmer_table_training_data <- read.table("data/14-18kmerdata.txt", sep = "\t", header = T, row.names = 1, stringsAsFactors = FALSE, comment.char = "")

# metadata
metadata_training_data <- read.table("data/14-18metadata", sep = ",", header = T, row.names = 1, stringsAsFactors = TRUE, comment.char = "")

# cleaning ----------------------------------------------------------------------------------------------------------------------

# check for missing values
anyNA(kmer_table_training_data) # false

anyNA(metadata_training_data) # false

# summarise metadata
summary(metadata_training_data)

# get full list of regions
metadata_training_data %>%
  select(Region) %>%
  unique()

# get full list of countries
metadata_training_data %>%
  select(Country) %>%
  unique()

# rename 'N' in Country to 'UK' 
metadata_training_data$Country <- as.character(metadata_training_data$Country)
metadata_training_data$Country[metadata_training_data$Country == 'N'] <- 'UK'
metadata_training_data$Country[metadata_training_data$Country == 'Wales'] <- 'UK'
metadata_training_data$Country <- as.factor(metadata_training_data$Country)


# find counts for each k-mer to determine which ones will be informative ------------------------------------------------------

# this code is either directly taken or interpreted from Dr Lauren Crowley's lectures at the University of Bath:

kmer_counts_non_zero <- apply(kmer_table_training_data, 1, function(y) sum(length(which(y > 0))))

# plot
hist(kmer_counts_non_zero, breaks=100, col="grey", main="", ylab="Number of kmers", xlab="Number of Non-Zero Values")

# function for removing uninformative k-mers
remove_rare <- function( table , cutoff_pro ) {
  row2keep <- c()
  cutoff <- ceiling( cutoff_pro * ncol(table) )  
  for ( i in 1:nrow(table) ) {
    row_nonzero <- length( which( table[ i , ]  > 0 ) ) 
    if ( row_nonzero > cutoff ) {
      row2keep <- c( row2keep , i)
    }
  }
  return( table [ row2keep , , drop=F ])
}


# apply function and remove k-mers with non-zero values in <=25% of samples
kmer_table_rare_removed <- remove_rare(table = kmer_table_training_data, cutoff_pro = 0.25)

# find number/percentage of k-mers removed
nrow(kmer_table_rare_removed) / nrow(kmer_table_training_data) * 100 # 43% of samples remaining

# end of borrowed code

# rebalancing data ====================================================================================

# reformat unbalanced data ---------------------------------------------------------------------------------------

# transpose filtered kmer table into df
t_kmer <- data.frame(t(kmer_table_rare_removed))

# add region label
t_kmer$region <- metadata_training_data[rownames(t_kmer), 'Region']

kmer_region <- t_kmer

# export 
write.csv(kmer_region, 'kmer_region.csv')

# add country label
t_kmer$country <- metadata_training_data[rownames(t_kmer), 'Country']

kmer_country <- t_kmer

# export
write.csv(kmer_country, 'kmer_country.csv')


# under/oversampling ===========================================================

# ------------------------------------ region ----------------------------------

# sample 1000 random rows from UK data
region_UK <- kmer_region %>%
  filter(region == 'UK') %>%
  sample_n(1000)

# upsample by duplication all other regions

region_asia <- kmer_region %>%
  filter(region == 'Asia') %>%
  slice(rep(1:n(), length.out = 1000))

region_australasia <- kmer_region %>%
  filter(region == 'Australasia') %>%
  slice(rep(1:n(), length.out = 1000))

region_c_america <- kmer_region %>%
  filter(region == 'C. America') %>%
  slice(rep(1:n(), length.out = 1000))

region_c_europe <- kmer_region %>%
  filter(region == 'C. Europe') %>%
  slice(rep(1:n(), length.out = 1000))

region_m_east <- kmer_region %>%
  filter(region == 'M. East') %>%
  slice(rep(1:n(), length.out = 1000))

region_n_america <- kmer_region %>%
  filter(region == 'N. America') %>%
  slice(rep(1:n(), length.out = 1000))

region_n_europe <- kmer_region %>%
  filter(region == 'N. Europe') %>%
  slice(rep(1:n(), length.out = 1000))

region_s_america <- kmer_region %>%
  filter(region == 'S. America') %>%
  slice(rep(1:n(), length.out = 1000))

region_s_europe <- kmer_region %>%
  filter(region == 'S. Europe') %>%
  slice(rep(1:n(), length.out = 1000))

region_sub_africa <- kmer_region %>%
  filter(region == 'Subsaharan Africa') %>%
  slice(rep(1:n(), length.out = 1000))

# bind all together

region_duplicated_upsample <- rbind(region_UK, region_asia, region_australasia, region_c_america,
                                    region_c_europe, region_m_east, region_n_africa, region_n_america,
                                    region_n_europe, region_s_america, region_s_europe, region_sub_africa)

# export region manually over/undersampled data

write.csv(region_duplicated_upsample, 'region_oversampled_data.csv')


# prepare data for SMOTE (performed in script: SMOTE.py) -------------------------------------

region_no_UK <- kmer_region %>%
  filter(!region == 'UK')

# add in randomly sampled UK data

df_for_smote_region <- rbind(region_no_UK, region_UK)

# export

write.csv(df_for_smote_region, 'data_for_smote_region.csv')



# -------------------------------- country ---------------------------------------

# prepare data for smote -------------------------------------------------------

# randomly sample country UK data
country_UK <- kmer_country %>%
  filter(country == 'UK') %>%
  sample_n(500)

# exclude UK data
country_no_UK <- kmer_country %>%
  filter(!country == 'UK')

# join together

df_for_smote_country <- rbind(country_UK, country_no_UK)

# list countries with >= 3 samples
country_keep_list <- df_for_smote_country %>%
  group_by(country) %>%
  summarise(
    n = n()
  ) %>%
  filter(n >= 3) %>%
  select(country) %>%
  dplyr::pull()

# exclude countries with too few samples
df_for_smote_country <- df_for_smote_country %>%
  filter(country %in% country_keep_list)

# check proportions across countries
df_for_smote_country %>%
  group_by(country) %>%
  summarise(
    n = n()
  ) %>%
  print(n = 36)

# export
write.csv(df_for_smote_country, 'data_for_smote_country.csv')

# filter out countries with low counts for unbalanced --------------------------

# exclude countries with too few samples
kmer_country <- kmer_country %>%
  filter(country %in% country_keep_list)

# export
write.csv(kmer_country, 'kmer_country_filtered.csv')

# manual oversampling countries ------------------------------------------------

# use kmer_country (already filtered for countries with >=3 datapoints)

# extract 500 random UK samples
country_UK_oversampling <- kmer_country %>%
  filter(country == 'UK') %>%
  sample_n(500)

# iterate through each other country and duplicate to 500 samples

# remove UK from country keep list (not included in this instance)
country_keep_list <- country_keep_list[country_keep_list != 'UK']


country_oversampling <- data.frame()


for (c in country_keep_list) {
  
  tmp <- kmer_country %>%
    # extract data for each country
    filter(country == c) %>%
    # duplicate the values to make 500 rows
    slice(rep(1:n(), length.out = 500))
  
  # join each country to main data frame
  country_oversampling <- rbind(country_oversampling, tmp)
  
}

# finally add in UK samples
country_oversampling <- rbind(country_oversampling, country_UK_oversampling)

# export
write.csv(country_oversampling, 'country_oversampling.csv')

# testing data ====================================================================

# read in data 

test_data <- read.table("data/19kmerdata.txt", sep = "\t", header = T, row.names = 1, stringsAsFactors = FALSE, comment.char = "")

# check for missing values
anyNA(test_data) # false

# read in metadata
test_metadata <- read.table("data/19metadata", sep = ",", header = T, row.names = 1, stringsAsFactors = TRUE, comment.char = "")

# reformat data -------------------------------------------------------------------

# rename 'N' in Country to 'UK' 
test_metadata$Country <- as.character(test_metadata$Country)
test_metadata$Country[test_metadata$Country == 'N'] <- 'UK'
test_metadata$Country[test_metadata$Country == 'Wales'] <- 'UK'
test_metadata$Country <- as.factor(test_metadata$Country)

# transpose kmer table into df
t_test_data <- data.frame(t(test_data))

# add labels
t_test_data$region <- test_metadata$Region
t_test_data$country <- test_metadata$Country

# remove countries with < 3 data points in training data as before - 95% of samples are kept
t_test_data <- t_test_data %>%
  filter(country %in% country_keep_list)

# export
write.csv(t_test_data, 'testing_data.csv')


