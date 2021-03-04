
library(readr)
# Partition Data into train and test data
salary_train <-read.csv("E:/Assignments/Assignment week 13/SVM/Assignment/SalaryData_Train.csv") 
salary_test  <-read.csv("E:/Assignments/Assignment week 13/SVM/Assignment/SalaryData_Test.csv")

# Training a model on the data ----
str(salary_train)
summary(salary_train)
sum(is.na(salary_train))
sum(is.na(salary_test))
salary_train$workclass=as.factor(salary_train$workclass)
salary_train$education=as.factor(salary_train$education)
salary_train$educationno=NULL
salary_train$maritalstatus=as.factor(salary_train$maritalstatus)
salary_train$occupation=as.factor(salary_train$occupation)
salary_train$relationship=NULL
salary_train$race=NULL
salary_train$native=as.factor(salary_train$native)
salary_train$sex=as.factor(salary_train$sex)
salary_train$Salary=as.factor(salary_train$Salary)
library(kernlab)
str(salary_train)
salary_classifier <- ksvm(Salary ~ ., data = salary_train, kernel = "vanilladot")
?ksvm
summary(salary_classifier)
salary_test_pred <- predict(salary_classifier, salary_test)

library(gmodels)
CrossTable(salary_test_pred, salary_test$Salary,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))

test_acc = mean(salary_test_pred == salary_test$Salary)
test_acc




# predictions on testing dataset
letter_predictions <- predict(salary_classifier, salary_test)

table(letter_predictions, salary_test$Salary)
agreement <- letter_predictions == salary_test$Salary
table(agreement)
prop.table(table(agreement))



# On Training Data
sms_train_pred <- predict(salary_classifier, salary_train)

train_acc = mean(sms_train_pred == salary_train$Salary)
train_acc
