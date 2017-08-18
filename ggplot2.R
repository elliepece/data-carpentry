##Data visualization

surveys_complete <- read.csv('data_output/surveys_complete.csv')

##ggplot2
#initial structure  , aes=aestetics, what are x and y
ggplot(data = surveys_complete, aes(x = weight, y=hindfoot_length)

##geom_point = dots, if you start typing geom it will show you other options
       
ggplot(data = surveys_complete, aes(x = weight, y=hindfoot_length)) + geom_point()

##alpha = transparency of the points
ggplot(data = surveys_complete, aes(x = weight, y=hindfoot_length)) + geom_point(alpha = 0.05)

##color all the points the same color
ggplot(data = surveys_complete, aes(x = weight, y=hindfoot_length)) + geom_point(alpha = 0.1, color = "blue")

##Different color for the different species

ggplot(data = surveys_complete, aes(x = weight, y=hindfoot_length)) + geom_point(alpha = 0.1, aes(color = species_id))


## Use what you just learned to create a scatter plot of weight over species_id
## with the plot types showing in different colors. Is this a good way to show
## this type of data?
ggplot(data = surveys_complete, aes(x = species_id, y=weight)) + geom_point(alpha = 0.1, aes(color = plot_type)


##labs = labels, title = title, facets = two different plots in one plot facet_grid(sex ~ .) or facet_grid(. ~ sex)
ggplot(data = surveys_complete, aes(x = species_id, y=weight)) + geom_boxplot(alpha = 0.1, aes(color = plot_type)) +
  facet_grid(sex ~ .) + 
  labs(x = "Species",
        y = "Weight",
        title = "Small mammals plot")

## Time series ----
       
yearly_counts <- surveys_complete %>%
  group_by(year, species_id) %>%
  tally

##
ggplot(data = yearly_counts, aes(x = year, y = n)) +
  geom_line()

## group= a varible you can gropu your data by (in this case each line is a different species)
ggplot(data = yearly_counts, aes(x = year, y = n, group = species_id)) +
  geom_line()

## color= same as group but paints them a differen color, facet_wrap = shows a differen plot for each species but all together in
#the same figure 
ggplot(data = yearly_counts, aes(x = year, y = n, color = species_id)) +
  geom_line() +
  facet_wrap(~ species_id)

##make yearly counts by sex
yearly_sex_counts <- surveys_complete %>%
  group_by(year, species_id, sex) %>%
  tally

## same plot as above but it separates them but male and female
ggplot(data = yearly_sex_counts, aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id)

##with facet grid (looks weird)

ggplot(data = yearly_sex_counts, aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(species_id ~ .)

## Challenge: Use what you just learned to create a plot that
## depicts how the average weight of each species
## changes through the years.

avg_species_weight <- surveys_complete %>%
  group_by(year, species_id) %>%
  summarize(mean_weight = mean(weight)
            
            
my_plot <- ggplot(data = avg_species_weight, aes(x = year, y = mean_weight, color = species_id)) +
  geom_line() +
  facet_wrap(~ species_id)+
labs(x = "Year", 
     y = "Mean weight (g)") +
  theme_bw()+             ##how the graph looks like, they have different themes
theme(axis.text.x = element_text(angle = 90),   
      legend.position="none") ##how to get rid of the legend

ggsave("my_plot.png", my_plot)