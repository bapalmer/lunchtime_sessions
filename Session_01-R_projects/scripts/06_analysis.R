#########################################################################
# Lunchtime sessions 
# R-projects
# 19th November 2018
# 06_analysis.R
#########################################################################
# Building models, automating the outputs ----
m1 <- lm(mpg ~ hp, data = mtcars)
m2 <- lm(mpg ~ hp + drat, data = mtcars)

# To retrieve the outputs of the model the summerary() function is called
summary(m1)

# This summary output is useful enough if you just want to read it
# Converting it to a data frame that contains all the same information, 
# so that you can combine it with other models is not trivial

# Can this be improved on?
library(broom)

m1_tbl <- tidy(m1) # This gives you a data.frame representation
View(m1_tbl)

m1_resid <- augment(m1) # If you are interested in the fitted values and residuals
View(m1_resid)

glance(m1) # Allows you to access summary statistics for the regression

# These outputs can be prepared for automated reporting using R Markdown, e.g.
library(knitr)
kable(m1_tbl)

# We can also return to the stargazer package used earlier to do this
stargazer(m1, m2,
          type = "html",
          dep.var.labels = c("Miles/(US) gallon"),
          covariate.labels = c("Gross horsepower","Rear axle ratio"), 
          out = paste("tables/",Sys.Date(),"_made_up_models.htm", sep = ""))

# Finishing up ----
# Once the analysis is complete, you might want to capture your environment
# It can be recreated anytime you run this script
writeLines(capture.output(sessionInfo()), 
           paste("docs/",Sys.Date(),"_end_of_project_session_info.txt",
                 sep = ""))

rm(m1, m1_resid, m1_tbl, m2, mtcars)
