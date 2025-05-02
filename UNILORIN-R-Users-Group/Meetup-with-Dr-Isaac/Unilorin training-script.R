
## -----------------------------------------------------------------------------
#Install and load essential libraries
#install.packages("tidyverse")
library(tidyverse)

# Basic operations
x <- c(10, 20, 30, 40, 50)
mean(x)  # Compute mean
sd(x)    # Compute standard deviation
summary(x)  # Get a statistical summary


## -----------------------------------------------------------------------------
# Create Students' Scores Dataset
students_scores <- data.frame(
  Name = c("Ade", "Chuks", "Bayo", "Mary", "Afusat"),
  Score = c(85, 78, 90, 70, 88),
  Study_Hours = c(10, 8, 12, 6, 11)
)

print(students_scores)


## -----------------------------------------------------------------------------
# Load the dataset
students <- students_scores
print(students)

# Descriptive statistics
summary(students)

# Histogram of scores
library(ggplot2)
ggplot(students, aes(x = Score)) + geom_histogram(binwidth = 5, fill = "blue", color = "black")

# Hypothesis test (on sample t-test)
t.test(students$Score, mu = 75)  # Checking if the average score is significantly different from 75

# Linear regression: Study Hours vs Score
model <- lm(Score ~ Study_Hours, data = students)
summary(model)


## -----------------------------------------------------------------------------
# Import the dataset
students <- read.csv("students_scores_nigeria_1000.csv")

# Check for missing values
sum(is.na(students))

# Check distribution of Scores using boxplot
ggplot(students, aes(y = Score)) + geom_boxplot(fill="skyblue", color="black")

# Pairwise correlation analysis
cor(students[, c("Score", "Study_Hours")])


## -----------------------------------------------------------------------------
# Categorize students based on performance
students <- students %>%
  mutate(Performance_Category = case_when(
    Score >= 85 ~ "Excellent",
    Score >= 70 & Score < 85 ~ "Good",
    TRUE ~ "Needs Improvement"
  ))

# View the first few rows
head(students)



## -----------------------------------------------------------------------------
# Descriptive statistics
summary(students)

# Histogram of scores
library(ggplot2)
ggplot(students, aes(x = Score)) + geom_histogram(binwidth = 5, fill = "blue", color = "black")

# Hypothesis test (t-test)
t.test(students$Score, mu = 75)  # Checking if the average score is significantly different from 75

# Linear regression: Study Hours vs Score
model <- lm(Score ~ Study_Hours, data = students)
summary(model)


## -----------------------------------------------------------------------------
# Create Sales Data Dataset
sales_data <- data.frame(
  Date = as.character(seq(as.Date("2024-01-01"), by = "day", length.out = 5)),
  Sales = c(500, 700, 800, 400, 650),
  Category = c("Electronics", "Clothing", "Electronics", "Clothing", "Electronics")
)

print(sales_data)


## -----------------------------------------------------------------------------
# ANOVA to compare sales among different product categories
anova_model <- aov(Sales ~ Category, data = sales_data)
summary(anova_model)



## -----------------------------------------------------------------------------
# Load dataset
sales <- read.csv("sales_data.csv")

# Convert Date column to Date format
sales$Date <- as.Date(sales$Date, format="%Y-%m-%d")

summary(sales) # Summary statistics

# Filter sales for Electronics only
library(dplyr)
electronics_sales <- filter(sales, Category == "Electronics")

# Aggregate total sales by category
total_sales <- sales %>% group_by(Category) %>% 
summarise(Total = sum(Sales))
print(total_sales)

# Plot time series sales trend
ggplot(sales, aes(x = Date, y = Sales, color = Category)) + geom_line() + geom_point()


## -----------------------------------------------------------------------------
# Import dataset
sales <- read.csv("sales_data_1000.csv")

# Convert Date column to Date format
sales$Date <- as.Date(sales$Date, format="%Y-%m-%d")

summary(sales) # Summary statistics

# Filter sales for Electronics only
library(dplyr)
electronics_sales <- filter(sales, Category == "Electronics")

# Aggregate total sales by category
total_sales <- sales %>% group_by(Category) %>% 
summarise(Total = sum(Sales))
print(total_sales)

# Plot time series sales trend
ggplot(sales, aes(x = Date, y = Sales, color = Category)) + geom_line() + geom_point()


## -----------------------------------------------------------------------------
# Create Employee Performance Dataset
employee_performance <- data.frame(
  Employee = c("A", "B", "C", "D", "E"),
  Work_Hours = c(35, 40, 45, 50, 38),
  Performance_Score = c(78, 85, 90, 92, 80)
)

print(employee_performance)


## -----------------------------------------------------------------------------
# Load dataset
performance <- read.csv("employee_performance.csv")

# Scatter plot
ggplot(performance, aes(x = Work_Hours, y = Performance_Score)) + geom_point() + geom_smooth(method="lm")

# Linear regression model
perf_model <- lm(Performance_Score ~ Work_Hours, data = performance)
summary(perf_model)

# Predict performance for a new employee working 42 hours
new_data <- data.frame(Work_Hours = 42)
predict(perf_model, new_data)


## -----------------------------------------------------------------------------
# Load dataset
performance <- read.csv("employee_performance_1000.csv")

# Scatter plot
ggplot(performance, aes(x = Work_Hours, y = Performance_Score)) + geom_point() + geom_smooth(method="lm")

# Linear regression model
perf_model <- lm(Performance_Score ~ Work_Hours, data = performance)
summary(perf_model)

# Predict performance for a new employee working 42 hours
new_data <- data.frame(Work_Hours = 42)
predict(perf_model, new_data)

