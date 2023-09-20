# Load libraries, set directory and read csv file
library(rpart)
library(rpart.plot)
library(pROC)
setwd('H:/GPEL_HPENVY/Documents/UNSW/07_ZZBU6511/Assessment3/')
employees <- read.csv(file = 'employees2.csv')

# Make Attrition a factor
employees$Attrition = factor(ifelse(employees$Attrition == "Yes", 1, 0))
employees$Over18 = NULL # don't use this column

# Split the data to training and testing
set.seed(57)
rows <- sample(nrow(employees), 0.8*nrow(employees))
training <- employees[rows, ]
testing <- employees[-rows, ]

# Make decison tree using all variables
tree1 <- rpart(  
  formula = Attrition ~ . - Attrition,
  data = training,
  method = "class"
)

# Predict on training and testing dataset
training$Prob1 <- predict(  
  object = tree1,  newdata = training,  type = "prob"
)

testing$Prob1 <- predict(  
  object = tree1,  newdata = testing,  type = "prob"
)

# Plot the ROC curves and show AUC
par(mfrow=c(1, 2), cex.main=0.8)
train1 <- roc(  
  formula = training$Attrition ~ training$Prob1[ , "1"],
  main=paste("Tree1:Training set\nAUC =", round(train1$auc, digits=4)),
  plot = TRUE,
  auc = TRUE,
  print.thres = TRUE
)

test1 <- roc(  
  formula = testing$Attrition ~ testing$Prob1[ , "1"],
  main=paste("Tree1: Testing set\nAUC =", round(test1$auc, digits=4)),
  plot = TRUE,
  auc = TRUE,
  print.thres = TRUE
)
