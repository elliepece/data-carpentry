
##upload data into this project
surveys <- read.csv(data/portal_data_joined.csv)

##installing tidyverse
install.packages("tidyverse")

##load tidyverse packages
library(tidyverse)

##select columns of a data frame. The first argument to this function is the data frame (surveys), and the subsequent arguments are the columns to keep.
select(surveys, plot_id, species_id, weight)

##choose rows based on a specific criteria
filter(surveys, year == 1995)

##Pipes let you take the output of one function and send it directly to the next
surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

##create a new object with this smaller version of the data, assigning it a new name:
surveys_sml <- surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

##create new columns based on the values in existing columns
surveys %>%
  mutate(weight_kg = weight / 1000,
         weight_kg2 = weight_kg * 2) %>%
  tail

##is.na is a function that lets you find the "na"s in your data and ! means different than
surveys %>%
  filter(!is.na(weight)) %>%     
  mutate(weight_kg = weight / 1000,
         weight_kg2 = weight_kg * 2) %>%
  tail

##Create a new data frame from the surveys data that meets the following criteria: 
#contains only the species_id column and a new column called hindfoot_half containing 
#values that are half the hindfoot_length values. In this hindfoot_half column,
#there are no NAs and all values are less than 30.

surveys %>% 
  select(species_id, hindfoot_length) %>%


surveys %>% 
  mutate(hindfoot_length / 2)

##you don't have to use select in the beggining of the argument, so first you divide halfoot hind and put in in a new object
#then you pipe it into filter to get rid of the NAs and the less than 30 results. Finally you pipe it into
#into select to onlye select the rows columns that you want

surveys %>% 
   mutate(hindfoot_half = hindfoot_length / 2) %>%
  filter(!is.na(hindfoot_half) & hindfoot_half<30) %>%
select(species_id, hindfoot_half) 

##group_by() takes as arguments the column names that contain the categorical variables for which you want to calculate the summary statistics.
#group_by() is often used together with summarize(), which collapses each group into a single-row summary of that group
#na.rm -> removes all the "na"s of your data
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

