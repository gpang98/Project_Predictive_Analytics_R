# Import the pROC library, set file path and read csv file
library(pROC)
setwd('H:/GPEL_HPENVY/Documents/UNSW/07_ZZBU6511/Assessment3/')
employees <- read.csv(file = 'employees2.csv')

# Add new binary variables to the employees data frame
employees$Is.Attrition = ifelse(employees$Attrition == "Yes", 1, 0)

# Split the data to training and testing
set.seed(57)
rows <- sample(nrow(employees), 0.8*nrow(employees))
training <- employees[rows, ]
testing <- employees[-rows, ]

# Making the predictions.  Don't include Over18 since all is Yes.  Select upto 1* stat significant
logmod <- glm(
  formula = Is.Attrition ~ BusinessTravel + OverTime + Gender + MaritalStatus +
    DistanceFromHome + JobSatisfaction + EnvironmentSatisfaction + JobInvolvement + 
     JobRole + NumCompaniesWorked + TotalWorkingYears + WorkLifeBalance,
  data = training,
  family = binomial()
)
# Print summary of the prediction
summary(logmod)

# Do prediction using the training parameters
# Get the probabilities from the model and add them into a new column
training$Probability <- predict(
  object = logmod,
  newdata = training,
  # To get probabilities we set the type to "response"
  type = "response"
)
# Compute ROC and Printing the area under the ROC curve
roc(
  formula = training$Is.Attrition ~ training$Probability,
  auc = TRUE
)
# Turn the probabilities into predictions
training$Prediction = ifelse(training$Probability >= 0.15, 1, 0)

# Get the confusion matrix
conf_matrix_train <- table(training$Prediction, training$Is.Attrition)

# Show the confusion matrix
conf_matrix_train

# Calculate and show the accuracy
accuracy <- sum(diag(conf_matrix_train))/sum(conf_matrix_train)
message("Accuracy: ", accuracy)

# Calculate and show the sensitivity
sensitivity <- conf_matrix_train[2,2]/sum(conf_matrix_train[,2])
message("Sensitivity: ", sensitivity)

# Calculate and show the specificity
specificity <- conf_matrix_train[1,1]/sum(conf_matrix_train[,1])
message("Specificity: ", specificity)

# Testing the model - using the testing dataset and using the Prediction models
testing$ProbabilityTest <- predict(logmod, newdata = testing, type = "response")
testing$PredictionTest <- ifelse(testing$ProbabilityTest >= 0.15, 1, 0)
conf_matrix_test <- table(testing$PredictionTest, testing$Is.Attrition)
message("Confusion matrix for model 2:")
conf_matrix_test

# Calculate and show the accuracy
accuracy <- sum(diag(conf_matrix_test))/sum(conf_matrix_test)
message("Accuracy: ", accuracy)

# Calculate and show the sensitivity
sensitivity <- conf_matrix_test[2,2]/sum(conf_matrix_test[,2])
message("Sensitivity: ", sensitivity)

# Calculate and show the specificity
specificity <- conf_matrix_test[1,1]/sum(conf_matrix_test[,1])
message("Specificity: ", specificity)
