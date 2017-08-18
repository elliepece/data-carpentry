## my script from data carprentry @ UC Merced August 18 2017 
## Elisabet Perez eperezcoronel@ucmerced.edu

##download data ----
# download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")



##read data into R ----
#surveys <- read.csv("data/portal_data_joined.csv")

## explore our data ----

##shows data on console
#surveys 

##shows first 6 rows of data
#head(surveys)

##shows last 12 rows of data
#tail(surveys, 12)

##structure of the data
#str(surveys)

##statistics
#summary(surveys)

##size of data
#dim(surveys)
#nrow(surveys)
#ncol(surveys)

##access one single column: the $ operator is for isolating columns
#str(surveys$weight)
#summary(surveys$weight)



##plot - scatterplot: plot(x, y) ----
#plot(surveys$year, surveys$weight)
#plot(surveys$hindfoot_length, surveys$weight)

##explore month ----
#summary(surveys$month)
#hist(surveys$month, col='grey', breaks = 12)

##explore a factor variable ----
#summary(surveys$taxa)
#levels(surveys$taxa)
#nlevels(surveys$taxa)
#hist(surveys$taxa) ##error because it is a factor, so make it a table so you ca plot it
#class(surveys$taxa)
#table(surveys$taxa)
#barplot(table(surveys$taxa))

##subset (select certain rows or columns from your database)  [rows, columns] ----

##return all the rows for genus Ammodramus
#surveys[surveys$genus == "Ammodramus" , ]

##return a few columns
#surveys[surveys$genus == "Ammodramus" ,
        c('record_id', 'month', 'weight') ]

##How many rows are in the spreadsheet in Jan and Feb? ----
#nrow(surveys[surveys$month==1 | surveys$month == 2, ]) ## | or operator
or
#length(which(surveys$month < 3))


