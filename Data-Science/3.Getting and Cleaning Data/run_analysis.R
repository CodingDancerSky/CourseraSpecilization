## full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

setwd("Desktop/Course/12.Big Data/Data Science/Getting and Cleaning Data")

# 1. Merges the training and the test sets to create one data set.
bind <- function(trainFile, testFile){
  tmp1 <- read.table(paste("UCI HAR Dataset/train/", trainFile, sep = ""))
  tmp2 <- read.table(paste("UCI HAR Dataset/test/", testFile, sep = ""))
  r <- rbind(tmp1, tmp2)
  r
}

X <- bind("X_train.txt", "X_test.txt")
S <- bind("subject_train.txt", "subject_test.txt")
Y <- bind("y_train.txt", "y_test.txt")

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
keepfeatures <- grep("-mean\\(\\)|-std\\(\\)", features$V2, perl=TRUE)
X <- X[, keepfeatures]
names(X) <- features[keepfeatures, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities$V2 = gsub("_", "", tolower(as.character(activities$V2)))
Y$V1 = activities[Y$V1, 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.
names(S) <- "subject"
tidyData <- cbind(S, Y, X)
write.table(tidyData, "tidyData.txt")

# 5. Creates a seconnd, independent tidy data set with the average of each variable for each activity and each subject.
average <- aggregate(x = tidyData, 
                     by = list(activities = tidyData$activity, 
                               subject = tidyData$subject), 
                     FUN = mean)
str(average)
write.table(average, 'averageData.txt')