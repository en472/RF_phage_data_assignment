
# identify top 5 features for BLAST

library(tidyverse)

# select SMOTE data as this had best performance metrics for weighted and macro
# avg F1 score

# read in data

region_features <- read.csv('SM_region_top_features.csv')

# order by importance and take top 10 
top_region_features <- region_features %>%
  arrange(desc(importance)) %>%
  slice(1:10) %>%
  # then take the longest k-mers (more likley to give informative results on BLAST)
  arrange(desc(nchar(names))) %>%
  # and take top 3
  slice(1:3) %>%
  mutate(level = 'region')

# repeat for country features

country_features <- read.csv('SM_country_top_features.csv')

# order by importance and take top 10 
top_country_features <- country_features %>%
  arrange(desc(importance)) %>%
  slice(1:10) %>%
  # then take the longest k-mers (more likley to give informative results on BLAST)
  arrange(desc(nchar(names))) %>%
  # and take top 3
  slice(1:3) %>%
  mutate(level = 'country')

# bind together

top_features <- rbind(top_region_features, top_country_features)

# export

write.csv(top_features, 'top_features.csv')


# identify top features in dataset ===================================================================

# read in whole metadata 
metadata_testing_data <- read.table("19metadata", sep = ",", header = T, row.names = 1, stringsAsFactors = TRUE, comment.char = "")

# find year proportions
metadata_testing_data %>%
  group_by(Year) %>%
  summarise(
    n = n()
  )

# read in test dataset
testing_data <- read.csv('testing_data.csv', row.names = 1)


top_features <- testing_data %>%
  select('TTTTTTTGAGATTAGGTGTGTGTATTTAGAATTTTTATGATGTGTTTATTTTGTGGGGTATTTTAGAAAAAATATATTAATCCTTATTAATAATAGCTGC',
         'TTTTTTAATTGCCGGATGTTCCGGCAAACGAAAAATTACTTCTTCTTCGCTTTCGGGTTCGGCAGGTCAGTAATGCTACCTTCGAACACTTCTGCCGCCA',
         'TTTTTTAATTTTTATAATTATTGTTGAAGATGATGATATTGATTATAGGGATACCATTACAAGGAGCTGTTCCCCTCGTTGACGTCGCGGTTTACCCACC',
         'TTTTTGAATGCTTTCTTATCTCACGATTTAACAGGGAATAGTTCAGGCTGTGTTGATGTATCAAACCCGCAGAACATACCAAAACAGCAATAACATTGCG',
         'TTTTTTAAAACGTTCGCAGCAGTTTGTTATTCCCATTTATCAACGGACTTATTCATGGACAGAACAACAATGTCGGCAACTTTGGGACGACATCATTCGT',
         'TTTTTGAATGACCAGAAGATATCTTGCGAATCTAAGTTATGCATCTTAAATAGTCTTATTTAAGATGTTCAGATCTCTTTGTGTGTTTAACTAACTGATA')

colnames(top_features) <- c('region1', 'region2', 'region3', 'country1', 'country2', 'country3')

region1_negative_list <- top_features %>%
  select(region1) %>%
  filter(region1 == 0)

# UK, Hungary, UK, UK, UK, UK, UK, Portugal

region2_negative_list <- top_features %>%
  select(region2) %>%
  filter(region2 == 0)

# all UK samples

metadata_testing_data %>%
  rownames_to_column('ID') %>%
  filter(ID %in% rownames(region2_negative_list))

region3_negative_list <- top_features %>%
  select(region3) %>%
  filter(region3 == 0)

metadata_testing_data %>%
  rownames_to_column('ID') %>%
  filter( ID %in% rownames(region3_negative_list))

# UK, France, Hungary, Turkey, Portugal and Indonesia

country1_negative_list <- top_features %>%
  select(country1) %>%
  filter(country1 == 0)

metadata_testing_data %>%
  rownames_to_column('ID') %>%
  filter( ID %in% rownames(country1_negative_list))

# UK, Poland

country2_negative_list <- top_features %>%
  select(country2) %>%
  filter(country2 == 0)

metadata_testing_data %>%
  rownames_to_column('ID') %>%
  filter( ID %in% rownames(country2_negative_list))

# UK and Malta

country3_negative_list <- top_features %>%
  select(country3) %>%
  filter(country3 == 0)

metadata_testing_data %>%
  rownames_to_column('ID') %>%
  filter( ID %in% rownames(country3_negative_list))

# UK and Indonesia




