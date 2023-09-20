library(rpart)
library(pROC)
# set file path and read csv file
setwd('H:/GPEL_HPENVY/Documents/UNSW/07_ZZBU6511/Assessment3/')
employees <- read.csv(file = 'employees2.csv')
# Add new binary variables to the employees data frame
employees$Is.Attrition = ifelse(employees$Attrition == "Yes", 1, 0)
employees$Over18 <- NULL  # Don't include Over18 since all response is Yes.

set.seed(57)
rows <- sample(nrow(employees), 0.8*nrow(employees))
training <- employees[rows, ]
testing <- employees[-rows, ]
# Create the models
logmod4 <- glm(
  formula = Is.Attrition ~ BusinessTravel + OverTime + JobRole +
    DistanceFromHome + JobSatisfaction + EnvironmentSatisfaction + JobInvolvement + 
    NumCompaniesWorked + WorkLifeBalance,
  data = training,
  family = binomial()
)
logmod5 <- glm(
  formula = Is.Attrition ~ BusinessTravel + OverTime + Gender + MaritalStatus +
    DistanceFromHome + JobSatisfaction + EnvironmentSatisfaction + JobInvolvement + 
    JobRole + NumCompaniesWorked + TotalWorkingYears + WorkLifeBalance,
  data = training,
  family = binomial()
)
# Get the probabilities on training and testing
training$logprob4 <- predict(
  logmod4, newdata=training, type="response"
  )
testing$logprob4 <- predict( 
  logmod4, newdata=testing, type="response"
  )
training$logprob5 <- predict( 
  logmod5, newdata=training, type="response"
  )
testing$logprob5 <- predict( 
  logmod5, newdata=testing, type="response"
  )
# Get the ROC curves on training and testing
training.logroc4 <- roc(Is.Attrition ~ logprob4, data=training, plot=FALSE, quiet=TRUE
)
testing.logroc4 <- roc(Is.Attrition ~ logprob4, data=testing, plot=FALSE, quiet=TRUE
)
training.logroc5 <- roc(Is.Attrition ~ logprob5, data=training, plot=FALSE, quiet=TRUE
)
testing.logroc5 <- roc(Is.Attrition ~ logprob5, data=testing, plot=FALSE, quiet=TRUE
)
# Plot the ROC curves and show AUC
par(mfrow=c(2, 2), cex.main=0.8)
plot(
  training.logroc4,
  main=paste("Model4: Log model on training set\nAUC =", round(training.logroc4$auc, digits=4))
)
plot(
  testing.logroc4,
  main=paste("Model4: Log model on testing set\nAUC =", round(testing.logroc4$auc, digits=4))
)
plot(
  training.logroc5,
  main=paste("Model5: Log model on training set\nAUC =", round(training.logroc5$auc, digits=4))
)
plot(
  testing.logroc5,
  main=paste("Model5: Log model on testing set\nAUC =", round(testing.logroc5$auc, digits=4))
)
