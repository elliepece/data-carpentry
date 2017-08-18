
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

##Challenge: Create a new data frame from the surveys data that meets the following criteria: 
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

##group by multiple columns and summarize

#by removing all NAs
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

#by selecting male and female factors
surveys %>%
  filter(sex == "F" | sex == "M") %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

##to know the number of observations found for each factor or combination of factors (tally)
surveys %>%
  group_by(sex) %>%
  tally

##Chalenges----
### 1. How many individuals were caught in each plot_type surveyed?
surveys %>% 
  group_by(plot_type) %>%
  tally()


## 2. Use group_by() and summarize() to find the mean, min, and 
## max hindfoot length for each species (using species_id).
surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(species_id) %>%
  summarize(mean(hindfoot_length), 
            min(hindfoot_length),
            max(hindfoot_length))

##this doesn't work because tidyverse doesn't recognize summary as a function 
surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(species_id) %>%
  summarize(summary(hindfoot_length))
            
            
## 3. What was the heaviest animal measured in each year? Return
## the columns year, genus, species_id, and weight.
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(year) %>%
filter(weight == max(weight)) %>%
  select(year, genus, species_id, weight) %>%
  arrange(year)

## 4. You saw above how to count the number of individuals of each sex using a
## combination of group_by() and tally(). How could you get the same result using
## group_by() and summarize()? Hint: see ?n.
# n () The number of observations in the current group.

surveys %>%
  group_by(sex) %>%
  summarise(n())

##exporting data ----

##Surveys_complete 

filter(species_id != "") %>%         # remove missing species_id
       filter filter(!is.na(weight) %>%           # remove missing weight
       filter(!is.na(hindfoot_length) %>%  # remove missing hindfoot_length
       filter(sex != "")                # remove missing sex

       ##same as:
       
  filter(species_id != "",         # remove missing species_id
         !is.na(weight),           # remove missing weight
         !is.na(hindfoot_length),  # remove missing hindfoot_length
         sex != "")                # remove missing sex

surveys_complete <- surveys %>%
  filter(species_id != "",         
         !is.na(weight),           
         !is.na(hindfoot_length),  
         sex != "")                

##extract the most common species_id

species_counts <- surveys_complete %>%
  group_by(species_id) %>%
  tally %>%
  filter(n >= 50)

## Only keep the most common species
surveys_complete <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id)

#how many columns and rows (variables and observations)
dim(surveys_complete)

## save it as a CSV file in our data_output folder. 
##By default,  write.csv() includes a column with row names (in our case the names are just the row numbers), 
##so we need to add row.names = FALSE so they are not included

write.csv(surveys_complete, file = "data_output/surveys_complete.csv",
          row.names = FALSE)


