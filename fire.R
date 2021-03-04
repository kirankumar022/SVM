#####Support Vector Machines 

# Load the Dataset
fire <- read.csv(file.choose())

summary(fire)
fire=fire[1:517,3:31]
for(unique_value in unique(fire$size_category)){
  
  
  fire[paste("Size_cateogary", unique_value, sep = ".")] <- ifelse(fire$size_category== unique_value, 1, 0)
}
fire$size_category=NULL
summary(fire)
# Partition Data into train and test data
fire_train <- fire[1:413, ]
fire_test  <- fire[414:517, ]

# Training a model on the data ----
# Begin by training a simple linear SVM

library(kernlab)

fire_classifier <- ksvm(area ~ ., scaled = TRUE,data = fire_train, kernel = "vanilladot")
?ksvm

## Evaluating model performance ----
# predictions on testing dataset
fire_predictions<- predict(fire_classifier,fire_test)
table(fire_predictions, fire_test$area)
agreement <- fire_predictions == fire_test$area
table(agreement)
prop.table(table(agreement))

## Improving model performance ----
fire_classifier_rbf <- ksvm(area ~ ., data = fire_train, kernel = "rbfdot")
fire_predictions_rbf <- predict(fire_classifier_rbf, fire_test)
agreement_rbf <- fire_predictions_rbf == fire_test$area
table(agreement_rbf)
prop.table(table(agreement_rbf))


