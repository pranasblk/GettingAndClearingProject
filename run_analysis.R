# Prepare data directory with extracted train ant test data 
scriptWd <- getwd()
if (!file.exists("data")) {
  dir.create("data")
  setwd("data")
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","Dataset.zip", method = "curl")
  unzip("Dataset.zip")
} else {
  setwd("data")
}

# Set working directory to raw data root
setwd("UCI HAR Dataset")

## Extracts only the measurements on the mean and standard deviation for each measurement.
meanStdFields <- read.table(pipe("grep -e \"std()\" -e \"mean()\" features.txt"), 
                            header=F,
                            col.names=c("rawColNo", "colName"),
                            colClasses=c("numeric", "character"))
colClasses <- rep("NULL", 561)
colClasses[meanStdFields$rawColNo] <- rep("numeric", length(meanStdFields$rawColNo)) 

## Appropriately labels the data set with descriptive variable names. 
meanStdFields$colName <- lapply(meanStdFields$colName, FUN = function(s) {
  t <- sub("mean()", "Mean", s, fixed = T)
  t <- sub("std()", "Sd", t, fixed = T)
  t <- gsub("-", "", t, fixed = T) 
  t <- sub("^(f)([A-Z])", "fft\\2", t)
  t <- sub("^(t)([A-Z])", "time\\2", t)
  t <- sub("(Gyro)([A-Z])", "Gyroscope\\2", t)
  t <- sub("(Acc)([A-Z])", "Acceleration\\2", t)
  t <- sub("(Mag)([A-Z])", "Magnitude\\2", t)
  t
} )
activityLevels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

# Read train data
xTrain <- read.table("train/X_train.txt", header = F, colClasses=colClasses)
colnames(xTrain) <- meanStdFields$colName

activityTrain <- read.table("train/y_train.txt", header = F, colClasses=c("factor"), col.names = c("activity"))
levels(activityTrain$activity) <- activityLevels

subjectTrain <- read.table("train/subject_train.txt", header = F, 
                            colClasses=c("numeric"), col.names = c("subject"))

# Read test data
xTest <- read.table("test/X_test.txt", header = F, colClasses=colClasses)
colnames(xTest) <- meanStdFields$colName

activityTest <- read.table("test/y_test.txt", header = F, colClasses=c("factor"), col.names = c("activity"))
levels(activityTest$activity) <- activityLevels

subjectTest <- read.table("test/subject_test.txt", header = F, 
                           colClasses=c("numeric"), col.names = c("subject"))
setwd(scriptWd)

## Merges the training and the test sets to create one data set.
subject <- rbind(subjectTest, subjectTrain)
activity <- rbind(activityTest ,activityTrain)
x <- rbind(xTrain, xTest)

## From the data, creates a second, 
## independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- aggregate(x, by=list(activity$activity, subject$subject), FUN=mean, na.rm = TRUE)
names(tidyData)[1:2] <- c("activity", "subject")
write.table(tidyData, "tidyData.txt", row.name=FALSE) 
