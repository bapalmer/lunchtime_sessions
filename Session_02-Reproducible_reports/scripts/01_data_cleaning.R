#########################################################################
# Lunchtime sessions 
# R Markdown
# 2018-12-03
# 01_data_cleaning.R
#########################################################################
# Load the required packages
library(tidyverse)

# Section 1: Load the data ----
# This data frame has 2 lines of meta data that must be skipped over
who_tb_data <- read_csv("data/raw_data/who_tb_data.csv",
                        skip = 2) %>%
  
  gather(new_ep_f014:new_sp_m65, # columns to be collapsed
         key = "key", 
         value = "cases", na.rm = TRUE) %>%
  
  # Two separate steps required to process the "key" column
  separate(key, 
           c("new", "type", "sexage"), 
           sep = "_") %>%
  
  separate(sexage, 
           c("sex", "age"), 
           sep = 1) %>% 
  
  select(-iso2, -iso3, -new) %>% # Removes the redundant columns 
  
  spread(sex, cases) %>% # Places males and females in separate columns
  
  mutate(total = m + f) 

#Section 2: Save the cleaned data ----
# This is commented out
# I only use this when I need to keep a record of what I've done
# write_csv(who_tb_data,
#           paste("data/",Sys.Date(),"_clean_who_tb_data.csv",
#                 sep=""))

# Section 3: Prepare the data for downstream analysis ----
who_tb_data <- who_tb_data %>%
  
  mutate(country = factor(country),
         age = factor(age),
         type = factor(type)) %>%
  
  #Change/clarify the factor levels for age
  mutate(age = recode_factor(who_tb_data$age, `014` = "0-14", 
                `1524` = "15-24", 
                `2534` = "25-34",
                `3544` = "35-44",
                `4554` = "45-54",
                `5564` = "55-64",
                `65` = "65+"))
