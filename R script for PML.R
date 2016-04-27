## Installing ML package 

install.packages("caret")
library(caret)

## Loading training and testing dataset

Training=read.csv(file="~/Desktop/Data Science/Coursera/Practical Machine Learning/Project/pml-training.csv",head=TRUE,sep=",",na.strings=c("NA","#DIV/0!",""))
Testing=read.csv(file="~/Desktop/Data Science/Coursera/Practical Machine Learning/Project/pml-testing.csv",head=TRUE,sep=",",na.strings=c("NA","#DIV/0!",""))

## Exploring data
summary(Training)
dim(Training)
table(Training$classe)

## Partition training data into training and validation sets
set.seed(123456)
data <- createDataPartition(Training$classe, p = 0.8, list = FALSE)
training <- Training[data,]
validation <- Training[-data,]

## Cleaning data: Excluding near zero value columns, not essential columns, columns with NA prevaling 

training<-training[,-seq(1:7)]
validation<-validation[,-seq(1:7)]
hasNA<-as.vector(sapply(training[,1:152],function(x) {length(which(is.na(x)))!=0}))
training<-training[,!hasNA]
validation<-validation[,!hasNA]

## installing randomForest package 

install.packages("randomForest")
library(randomForest)

## Running RF model
rfModel <- randomForest(classe ~ ., data = training, importance = TRUE, ntrees = 10)

## Running a prediction and evaluating accuracy:  
predtraining <- predict(rfModel, training)
print(confusionMatrix(predtraining, training$classe))

## Running a prediction on validation set: 
predvalidation <- predict(rfModel, validation)
print(confusionMatrix(predvalidation, validation$classe))

predtest <- predict(rfModel, Testing)
## Printing the results
predtest

