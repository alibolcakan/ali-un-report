# Loading in the Data
library(tidyverse)  # loads the tidyverse package and loads the read_csv function
gapminder_data <- read_csv("data/gapminder_data.csv")  # loads data from csv

# Summarizing our Data
# get avg life exp across whole data set
summarize(gapminder_data, averageLifeExp=mean(lifeExp))

# get avg life exp across whole data set using the pipe (%>%), layering the analysis
gapminder_data %>% summarize(averageLifeExp=mean(lifeExp))

# store the summary in a variable
gapminder_data_summarized <- gapminder_data %>%
  summarize(averageLifeExp=mean(lifeExp))

# Filtering our data using filter() # == is used in r to check if two objects/values are equivalent, returns true or false

# Filter data to only contain rows where year is 2007
gapminder_data %>%
  filter(year == 2007)

# Get average of the lifeExp column for all rows where the year is 2007
gapminder_data %>%
  filter(year == 2007) %>%
  summarize(average=mean(lifeExp))

# Find earliest year in the dataset
gapminder_data %>%
  summarize(first_year=min(year))

# Get average GDP per capita for the earliest year in the dataset
gapminder_data %>%
  filter(year == 1952) %>%
  summarize(average_gdp=mean(gdpPercap))

# Grouping Rows using group_by()
# group the data by year and find mean life expectancy for each year
gapminder_data %>%
  group_by(year) %>%
  summarize(average=mean(lifeExp))

# find both average and minimum lifeExp for each continent 
gapminder_data %>%
  group_by(continent) %>%
  summarize(average=mean(lifeExp), min=min(lifeExp))

# Adding new columns with mutate()
# calculate gdp by multiplying pop and gdpPercap, saving to new column called gdp
gapminder_data %>%
  mutate(gdp = pop * gdpPercap)

# Mutate can make multiple new columns at the same time by seperating mutate calculations with a comma
# make one new column with gdp
# make second new column calculating population per million
gapminder_data %>%  mutate(gdp = pop * gdpPercap, popInMillions = pop / 1000000)  

# Subset columns or change their order with select()
# Select only the pop and year columns
gapminder_data %>% select(pop, year)

# We can also re-order and remove columns
# Remove the pop, gdpPercap
gapminder_data %>% select(-pop, -gdpPercap)

# it appeared with continent first using this:
  gapminder_data %>%
  select(-pop, -gdpPercap, -year) %>%
  select(continent, country) 
  # only this line is needed, because it removes every column except content & country.

# Generally you will want to either select only the columns you want (e.g. select(continent, country)), OR "un"select only the columns you don't want (e.g. select(-pop, -year)). 

# if you are interested in how to move columns without naming them all in select(), check out relocate(): https://dplyr.tidyverse.org/reference/relocate.html

# Here's a handy listing of different ways to select columns from a data frame beyond naming specific columns like Sarah showed us: https://tidyselect.r-lib.org/reference/language.html


#Changing the Shape of the data
#Long format data = every single row is a single observation
#Wide format data = observation is in columns rather than rows

#pivot_wider() converts from long to wide
#pivot_longer() converts from wide to long

# convert from long to wide format data using only country, continent, 
# year and lifeExp
gapminder_data %>%
  select(country, continent, year, lifeExp) %>%
  pivot_wider(names_from = year, values_from = lifeExp )

# Read in the gapminder_data.csv file
# Filter out the year 2007 and the continent “Americas.”
# Drop the year and continent columns from the dataframe
# Then save the new dataframe into a variable called gapminder_data_2007
gapminder_data_2007 <- read_csv("data/gapminder_data.csv") %>%
  filter(year == 2007 & continent == "Americas") %>%
  select(-year, -continent)