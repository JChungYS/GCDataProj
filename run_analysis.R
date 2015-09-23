#Course Project-Getting and Cleaning Data Septenmber 2015
##step 1 Merges the training and the test sets to create one data set
#read and merge trainsetx and trainsety
Xtrain <- read.csv("X_train.txt", header = FALSE, stringsAsFactors = FALSE)
Ytrain <- read.csv("Y_train.txt", header = FALSE, stringsAsFactors = FALSE)
xytrain <- cbind(Ytrain, Xtrain)
idtrain <- read.csv("subject_id_train.txt", header = FALSE)
xytrain <- cbind(idtrain,xytrain)
#read and merge testsetx and testsety
Xtest <- read.csv("X_test.txt", header = FALSE, stringsAsFactors = FALSE)
Ytest <- read.csv("Y_test.txt", header = FALSE, stringsAsFactors = FALSE)
xytest <- cbind(Ytest, Xtest)
idtest <- read.csv("subject_id_test.txt", header = FALSE)
xytest <- cbind(idtest, xytest)

#rbind trainset and testset
xy <- rbind(xytrain,xytest)

