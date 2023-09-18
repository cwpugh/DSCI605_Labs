# Add your code here for this assignment
# DSCI 605 - Module 2 - Programming Assignment
# Cindy Pugh

# install tidyverse package 
install.packages("tidyverse")

# load tidyverse library
library(tidyverse)

# set the working directory
setwd("r:/Module_2")

# load Salaries.csv dataset
salary_info <- read_csv("Salaries.csv")

# use the select() function to load the variables "rank", "discipline", "sex" and "salary"
selected_salary_info <- salary_info %>% 
  select(rank, discipline, sex, salary)

# use the filter() function to filter salaries where the salary is not null
filtered_salary_info <- selected_salary_info %>% 
  filter(!is.na(salary))

# use group_by()to group by "rank", "discipline", and "sex" and count the number of rows
grouped_salary_info <- filtered_salary_info %>%
  group_by(rank, discipline, sex)%>%
  summarize(tally = n())

# reshape the table from long to wide to transfer the "sex" column to more columns
# needs an additional column (row_counter) to make each record unique
wide_table <- salary_info %>%
  mutate(row_counter=row_number()) %>% 
  mutate(sex_logical=TRUE) %>% 
  spread(sex,sex_logical,fill=FALSE)

# return the wide_table back to a long format - need to gather() then filter() and select()
long_table <- wide_table %>% 
  gather(sex,Log_value,7:8) %>% 
  filter(Log_value==TRUE) %>% 
  select(1:5,7)

