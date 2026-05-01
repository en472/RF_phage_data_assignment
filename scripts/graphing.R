

# ================ this script contains the code for the graphs shown in the paper =================

# no rebalancing

NR_region <- read.csv('kmer_region.csv')

# plot A

NR_region %>%
  group_by(region) %>%
  summarise(
    n = n()
  ) %>%
  arrange() %>%
  ggplot(aes(x = reorder(region, -n), y = n)) +
  geom_bar(stat = 'identity', fill = '#f4a261') +
  geom_text(aes(label = n), vjust = -1) +
  ylim(0, 2100) +
  theme_minimal() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15)) +
  theme(axis.text.x = element_text(angle = 45), vjust = 1.5) 


NR_country <- read.csv('kmer_country_filtered.csv', row.names = 1)

NR_country %>%
  select(country) %>%
  group_by(country) %>%
  summarise(
    n = n()
  ) %>%
  print(n = 36) # good

# change this so that a few end ones are grouped into one

df_for_plotting <- NR_country %>%
  group_by(country) %>%
  summarise(
    n = n()
  ) %>%
  arrange(n) 

rows_to_sum <- df_for_plotting %>%
  filter(n < 16)

sum_row <- rows_to_sum %>%
  summarise(across(where(is.numeric), sum, na.rm = TRUE)) %>%
  mutate(country = "Other (n = 27)") %>%  # Add label for new row
  select(country, everything()) 

NR_country_summed <- df_for_plotting %>%
  filter(n > 16) %>%
  arrange() %>%
  add_row(sum_row) 

NR_country_summed$country <- factor(NR_country_summed$country, levels = c("UK", "Spain", "Turkey", "Morocco", "Egypt", "Cyprus", "Greece", "Italy", "France", "Other (n = 27)"))

# plot B

NR_country_summed %>%
  ggplot(aes(x = country, y = n)) +
  geom_bar(stat = 'identity', fill = '#f4a261') +
  geom_text(aes(label = n), vjust = -1) +
  ylim(0, 2100) +
  theme_minimal() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15)) +
  theme(axis.text.x = element_text(angle = 45), vjust = 1.5) 


# plot all (messy - exclude)
NR_country %>%
  group_by(country) %>%
  summarise(
    n = n()
  ) %>%
  arrange() %>%
  ggplot(aes(x = reorder(country, -n), y = n)) +
  geom_bar(stat = 'identity', fill = '#f4a261') +
  geom_text(aes(label = n), vjust = -1) +
  ylim(0, 2100) +
  theme_minimal() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15)) +
  theme(axis.text.x = element_text(angle = 45), vjust = 1.5) 

# pre smote (use as example of UK-cut data distribution)

SM_region <- read.csv('data_for_smote_region.csv')

# plot C

SM_region %>%
  select(region) %>%
  group_by(region) %>%
  summarise(
    n = n()
  ) %>%
  arrange() %>%
  ggplot(aes(x = reorder(region, -n), y = n)) +
  geom_bar(stat = 'identity', fill = '#e9c46a') +
  geom_text(aes(label = n), vjust = -1) +
  ylim(0, 1200) +
  theme_minimal() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15)) +
  theme(axis.text.x = element_text(angle = 45), vjust = 1.5) 


SM_country <- read.csv('data_for_smote_country.csv')

df_for_plotting <- SM_country %>%
  select(country) %>%
  group_by(country) %>%
  summarise(
    n = n()
  )

rows_to_sum <- df_for_plotting %>%
  filter(n < 16)

sum_row <- rows_to_sum %>%
  summarise(across(where(is.numeric), sum, na.rm = TRUE)) %>%
  mutate(country = "Other (n = 27)") %>%  # Add label for new row
  select(country, everything()) 

SM_country_summed <- df_for_plotting %>%
  filter(n > 16) %>%
  arrange() %>%
  add_row(sum_row) 

SM_country_summed$country <- factor(SM_country_summed$country, levels = c("UK", "Spain", "Turkey", "Morocco", "Egypt", "Cyprus", "Greece", "Italy", "France", "Other (n = 27)"))

# plot D

SM_country_summed %>%
  ggplot(aes(x = country, y = n)) +
  geom_bar(stat = 'identity', fill = '#e9c46a') +
  geom_text(aes(label = n), vjust = -1) +
  ylim(0, 600) +
  theme_minimal() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15)) +
  theme(axis.text.x = element_text(angle = 45), vjust = 1.5) 



# after smote

# read in region data 

smote_region <- read.csv('smote_region.csv')

smote_region$region <- factor(smote_region$region, levels = c("UK", "S. Europe", "M. East", "N. Africa", "C. Europe", "Asia", "Subsaharan Africa", "C. America", "N. Europe", "N. America", "Australasia", "S. America"))

# plot E

smote_region %>%
  select(region) %>%
  group_by(region) %>%
  summarise(
    n = n()
  ) %>%
  ggplot(aes(x = region, y = n)) +
  geom_bar(stat = 'identity', fill = '#2a9d8f') +
  geom_text(aes(label = n), vjust = -1) +
  ylim(0, 1200) +
  theme_minimal() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15)) +
  theme(axis.text.x = element_text(angle = 45), vjust = 1.5) 

# read in country data 

smote_country <- read.csv('smote_country.csv')

smote_country_to_plot <- smote_country %>%
  select(country) %>%
  group_by(country) %>%
  summarise(
    n = n()
  ) %>%
  filter(country %in% c("UK", "Spain", "Turkey", "Morocco", "Egypt", "Cyprus", "Greece", "Italy", "France", "Portugal", "India", "Mexico")) 

smote_country_to_plot$country <- factor(smote_country_to_plot$country, levels = c("UK", "Spain", "Turkey", "Morocco", "Egypt", "Cyprus", "Greece", "Italy", "France", "Portugal", "India", "Mexico"))

# plot F

smote_country_to_plot%>% 
  ggplot(aes(x = country, y = n)) +
  geom_bar(stat = 'identity', fill = '#2a9d8f') +
  geom_text(aes(label = n), vjust = -1) +
  ylim(0, 600) +
  theme_minimal() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15)) +
  theme(axis.text.x = element_text(angle = 45), vjust = 1.5)



