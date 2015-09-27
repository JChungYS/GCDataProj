#Course Project-Getting and Cleaning Data Septenmber 2015
##source from 

##step 1 Merges the training and the test sets to create one data set

###read and bind trainsetx and trainsety using column bind result as xytrain
Xtrain <- read.table("X_train.txt", header = FALSE)
Ytrain <- read.table("Y_train.txt", header = FALSE)
xytrain <- cbind(Ytrain, Xtrain)

###read train subject id and bind with xytrain using column bind result as xytrain
idtrain <- read.table("subject_id_train.txt", header = FALSE)
xytrain <- cbind(idtrain,xytrain)

###read and bind testsetx and testsety using column bind result as xytest
Xtest <- read.table("X_test.txt", header = FALSE)
Ytest <- read.table("Y_test.txt", header = FALSE)
xytest <- cbind(Ytest, Xtest)

###read test subject id and bind with xytest using column bind result as xytest
idtest <- read.table("subject_id_test.txt", header = FALSE)
xytest <- cbind(idtest, xytest)

###bind xytrainset and xytestset using row bind result as xy

xy <- rbind(xytrain,xytest)

##Result of step 1 -- merged data set xy

##step 2 Extracts only the measurements on the mean and standard deviation for each measurement from 561 col of variable of reading in xy


###subset Reading of the combined train and test data (xy) with the above grep

###read the feature description
ftest <- read.csv("features.txt", header = FALSE)
ftest.name <- sub("^\\W.","", ftest$V1)

###rename the variable with feature descritpion

colnames(xy) <- c("UsrID","Activity", ftest.name)

###deive the data set for subset-xy
xy.name <- xy[,1:2]
xy.read <- xy[,3:563]

###get the subset of Mean and STD of xy.read
xy.read <- xy.read[,grep(".*(Mean|STD)\\w*", ftest$V1, value=FALSE)]

###combine name data set with the subset of xreading result as xy
xy <- cbind(xy.name,xy.read)

##End of step 2: subset merged data xy

##step 3: Uses descriptive activity names to name the activities in the data set

###Read the activity label
ActLabel <- read.table("activity_labels.txt", header = FALSE)
###Rename the column
colnames(ActLabel) <- c("Activity","ActName") # this may not need for read.table.

###Merge the ActLabel with the merged data xy of step 2
xy.merge <- merge(ActLabel,xy)

###remove the column of activity no, which represented by activity name
xy <- xy.merge[,-1] 


##end of step 3 result Added Activity Label to data xy

##step 4 Appropriately labels the data set with descriptive variable names[done in step 2]

##step 5 From the data set in step 4, creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject.

###melt data xy with merged UsrID(Subject) and ActName(Activity) as one observation row, and return average 
library(reshape2)
xy.melt <- melt(xy, id=c("UsrID","ActName"),na.rm = TRUE)
xy.cast <- acast(xy.melt, UsrID + ActName ~ variable, mean)


###Output the data to the file HARTT.txt with 
###  349(row) observation(Each observation:UsrID + Activity)
###  79 (col) mean of readings of the instrument(include either average or standard deveiation)

write.table(xy.cast, file ="HARTT.txt", row.names = FALSE)


## End of all steps(1 to 5) with dataset xy.cast, output as file:"HARTT.txt"

###Column one: The label of the user's identity in number underscore the Acitivity being tested

###Row One: The labael of the reading of the instrument, some have no.1, no.2, no.3 reading may prepresent three axis measurement, all reading are either mean or standard deviation of instrument's reading. No of instrument reading variable is 79(Mean or STD) of 561(total).

###The data: The data in the box is the average with the average of each variable(mean or standard deviation value of reading from the instrumenta) of the observation perform by subject with certain Activity(ActName)
####subject(UsrID) No of subject is 30
#####person of testing 
#####person in a controled environment to produce data to calibrate or to train
####Activity(ActName)
#####12 different kinds of activities

