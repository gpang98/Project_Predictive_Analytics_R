# Import the rpart library, set file path and read csv file
library(rpart)
library(rpart.plot)
library(pROC)
setwd('H:/GPEL_HPENVY/Documents/UNSW/07_ZZBU6511/Assessment3/')
employees <- read.csv(file = 'employees2.csv')

employees$Over18 = NULL # don't use this column

# Split the data to training and testing
set.seed(57)
rows <- sample(nrow(employees), 0.8*nrow(employees))
training <- employees[rows, ]
testing <- employees[-rows, ]

# Making the predictions. 
tree <- rpart(
  formula = Attrition ~ . - Attrition,
  data = training,
  method = "class"
)
rpart.plot(tree)
tree

# Apply it to the training data
training$Prediction <- predict(
  object = tree,
  newdata = training, type = "prob"
)
training$Prediction <- ifelse(
  training$Prediction[ , 2] >= 0.145, 1, 0
)
emp_train_roc <- roc(
  training$Attrition ~ training$Prediction,
  auc = TRUE
)
emp_train_roc
# Plot the ROC curves and show AUC
par(mfrow=c(1, 2), cex.main=0.8)
plot(
  emp_train_roc,
  main=paste("Tree on training set\nAUC =", round(emp_train_roc$auc, digits=4))
)
train_conf_matrix <- table(training$Prediction, training$Attrition)
train_conf_matrix
message("Accuracy: ", sum(diag(train_conf_matrix))/sum(train_conf_matrix))
message("Sensitivity: ", train_conf_matrix[2,2]/sum(train_conf_matrix[,2]))
message("Specificity: ", train_conf_matrix[1,1]/sum(train_conf_matrix[,1]))
testing$Prediction <- predict(
  tree,
  testing,
  type = "prob"
)
# Apply it to the testing data
testing$Prediction <- ifelse(
  testing$Prediction[ , 2] >= 0.145, 1, 0
)
emp_test_roc <- roc(
  testing$Attrition ~ testing$Prediction,
  auc = TRUE
)
emp_test_roc
# Plot the ROC curves and show AUC
plot(
  emp_test_roc,
  main=paste("Tree on test set\nAUC =", round(emp_test_roc$auc, digits=4))
)
test_conf_matrix <- table(testing$Prediction, testing$Attrition)
test_conf_matrix
message("Accuracy: ", sum(diag(test_conf_matrix))/sum(test_conf_matrix))
message("Sensitivity: ", test_conf_matrix[2,2]/sum(test_conf_matrix[,2]))
message("Specificity: ", test_conf_matrix[1,1]/sum(test_conf_matrix[,1]))