#########################################################################
# Lunchtime sessions 
# R Markdown
# 2018-12-03
# 03_tables.R
#########################################################################
# Load the packages ----
# library(tidyverse)
library(stargazer)

# Table 1 ----
# A basic, descriptive table
# The mtcars data set is stored within the datasets module
# The data was extracted from the 1974 Motor Trend US magazine, 
# and comprises fuel consumption and 10 aspects of automobile design and 
# performance for 32 automobiles (1973–74 models).
mtcars <- mtcars
?mtcars

# Descriptive statistics for cars with automatic transmission
# Option A
mtcars %>% 
  
  filter(am == 0) %>% # Automatic transmission
  
  select(mpg, hp) %>%
  
  stargazer(title = "Automatic transmission", 
            covariate.labels = c("Miles/(US)gallon","Gross horsepower"),
            type = "text", # Output summary data as a text file
            summary = TRUE,
            digits = 1, 
            out = paste("tables/",Sys.Date(),"_table1.txt", sep = ""))

# Option B (more of a visually pleasing output)  
mtcars %>% 
  
  filter(am == 0) %>%
  
  select(mpg, hp) %>%
  
  stargazer(title = "Automatic transmission",
            covariate.labels = c("Miles/(US)gallon","Gross horsepower"),
            type = "html", # Output summary data as a html file
            summary = TRUE,
            digits = 1, 
            out = paste("tables/",Sys.Date(),"_table1.htm", sep = ""))
