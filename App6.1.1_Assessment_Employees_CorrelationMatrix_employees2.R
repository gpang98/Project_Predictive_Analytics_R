# set file path
# read csv file
setwd('H:/GPEL_HPENVY/Documents/UNSW/07_ZZBU6511/Assessment3/')
employees <- read.csv(file = 'employees2.csv')

# Inspect file
head(employees)

# Add new binary variables to the employees data frame
employees$Is.Attrition = ifelse(employees$Attrition == "Yes", 1, 0)
employees$Is.OverTime = ifelse(employees$OverTime == "Yes", 1, 0)
employees$Is.Male = ifelse(employees$Gender == "Male", 1, 0)
employees$Is.BusNonTravel = ifelse(employees$BusinessTravel == "Non-Travel", 1, 0)
employees$Is.BusTravelRare = ifelse(employees$BusinessTravel == "Travel_Rarely", 1, 0)
employees$Is.BusTravelFreq = ifelse(employees$BusinessTravel == "Travel_Frequently", 1, 0)

# Create group of the numeric variables only
select_employees <- employees[c(
  "Is.Attrition", "Is.OverTime", "Age", "DistanceFromHome", "Education", "EnvironmentSatisfaction",
  "Is.Male", "JobInvolvement", "JobSatisfaction", "MonthlyIncome", "NumCompaniesWorked",
  "SalaryIncrease", "RelationshipSatisfaction", "StockOptionLevel", "Is.BusNonTravel", "Is.BusTravelRare",
  "Is.BusTravelFreq", "TotalWorkingYears", "TrainingTimesLastYear", "WorkLifeBalance",
  "YearsAtCompany", "YearsInCurrentRole", "YearsSinceLastPromotion",
  "YearsWithCurrManager", "HighPerformance"
  )]

# Calculate Correlation
cor_values <- cor(select_employees)

# Print the correlation values
cor_values









# Plotting the result
Plot(cor_values)






