#########################################################################
# Lunchtime sessions 
# R Markdown
# 2018-12-03
# 02_plots.R
#########################################################################
# Read in the clean WHO TB data
source("scripts/01_data_cleaning.R")

# Irish data preliminary plot ----
# Pick any question you'd like to ask of the data
# I'm from Ireland, so I might be interested in TB data for Ireland

# Initial plot - early on in the project
who_ire <- who_tb_data %>%
  filter(country == "Ireland") %>%
  # Basic barplot with data by age shown
  ggplot() +
  geom_bar(mapping = aes(x = year, y = total, fill = age),
           stat = "identity") +
  labs(title = "Summary overview of all TB cases in Ireland", 
       x = "Year", y = "Total number of cases", fill = "Age group")

who_ire

# End of project ----
# This plot has a number of extra layers added to improve the quality

# 2007 looked like a bad year
# Your own area of interest may be paediatrics
# What is the breakdown for the type of TB in the youngest cohort?

# Some points on the plot are zero
# To avoid them being shown, change the limits of your y-axis
who_ire_final <- who_tb_data %>%
  filter(age == "0-14" & country == "Ireland") %>%
  ggplot() +
  geom_point(mapping = aes(x = as.character(year), y = total, 
                           colour = type, shape = type)) + 
  
  geom_hline(yintercept = 80, 
             linetype = "dashed",
             size = 0.5) +
  
  scale_shape_manual(values = c(3, 15, 16, 17),
                     labels = c(rel = "Relapse", 
                                sn = "-ve Pulmonary smear", 
                                sp = "+ve Pulmonary smear", 
                                ep = "Extrapulmonary")) +
  
  scale_color_manual(values = c("green", "black", "red", "blue"),
                     labels = c(rel = "Relapse", 
                                sn = "-ve Pulmonary smear", 
                                sp = "+ve Pulmonary smear", 
                                ep = "Extrapulmonary")) +
  
  ylim(y = c(0.1, 82)) + # This sets the limits
  
  labs(x = "Year", y = "Total number of cases", # Label axes
       title = "TB cases by type in Irish 0 - 14 years olds",
       colour = "TB Type",
       shape = "TB Type") +
  
  theme(axis.text.x = element_text(angle = 90),
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold", size = 10),
        axis.text = element_text(face = "bold", size = 8),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        legend.title = element_blank())

who_ire_final

# Once we're happy, we can save the plot to file in many formats
# It defaults to saving the last plot you can also specify which plot to save
ggsave("figs/who_ire_final_default.png")

# Or specify the size
ggsave(filename = "figs/who_ire_final.png",
       plot = who_ire_final,
       width = 14, 
       height = 10, 
       dpi = 300, 
       units = "cm")
