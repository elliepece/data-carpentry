
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

