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
logmod1 <- glm(
  formula = Is.Attrition ~ . - Attrition - Is.Attrition,
  data = training,
  family = binomial()
)
logmod2 <- glm(
  formula = Is.Attrition ~ BusinessTravel +  EnvironmentSatisfaction +
    JobInvolvement + JobSatisfaction + NumCompaniesWorked + OverTime,
  data = training,
  family = binomial()
)
logmod3 <- glm(
  formula = Is.Attrition ~ BusinessTravel +  EnvironmentSatisfaction +
    JobInvolvement + JobSatisfaction + OverTime,
  data = training,
  family = binomial()
)
# Get the probabilities on training and testing
training$logprob1 <- predict(logmod1, newdata=training, type="response")
testing$logprob1 <- predict( logmod1, newdata=testing, type="response")
training$logprob2 <- predict( logmod2, newdata=training, type="response")
testing$logprob2 <- predict( logmod2, newdata=testing, type="response")
training$logprob3 <- predict( logmod3, newdata=training, type="response")
testing$logprob3 <- predict( logmod3, newdata=testing, type="response")
# Get the ROC curves on training and testing
training.logroc1 <- roc(Is.Attrition ~ logprob1, data=training, plot=FALSE, quiet=TRUE
)
testing.logroc1 <- roc(Is.Attrition ~ logprob1, data=testing, plot=FALSE, quiet=TRUE
)
training.logroc2 <- roc(Is.Attrition ~ logprob2, data=training, plot=FALSE, quiet=TRUE
)
testing.logroc2 <- roc(Is.Attrition ~ logprob2, data=testing, plot=FALSE, quiet=TRUE
)
training.logroc3 <- roc(Is.Attrition ~ logprob3, data=training, plot=FALSE, quiet=TRUE
)
testing.logroc3 <- roc(Is.Attrition ~ logprob3, data=testing, plot=FALSE, quiet=TRUE
)
# Plot the ROC curves and show AUC
par(mfrow=c(3, 2), cex.main=0.8)
plot(
  training.logroc1,
  main=paste("Model1: Log model on training set\nAUC =", round(training.logroc1$auc, digits=4))
)
plot(
  testing.logroc1,
  main=paste("Model1: Log model on testing set\nAUC =", round(testing.logroc1$auc, digits=4))
)
plot(
  training.logroc2,
  main=paste("Model2: Log model on training set\nAUC =", round(training.logroc2$auc, digits=4))
)
plot(
  testing.logroc2,
  main=paste("Model2: Log model on testing set\nAUC =", round(testing.logroc2$auc, digits=4))
)
plot(
  training.logroc3,
  main=paste("Model3: Log model on training set\nAUC =", round(training.logroc3$auc, digits=4))
)
plot(
  testing.logroc3,
  main=paste("Model3: Log model on testing set\nAUC =", round(testing.logroc3$auc, digits=4))
)