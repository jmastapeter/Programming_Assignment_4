#Getting and Cleaning Data Peer Graded Assignment
#Setting up workspace and extracting .zip files from online
library(data.table)

setwd("C:/Users/mastapeterj/Documents/Coursera_DataScience")

link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(link, destfile = "data.zip", method = 'curl')
unzip("data.zip")

#Double Check to view unzipped files
list.files("C:/Users/mastapeterj/Documents/Coursera_DataScience/UCI HAR Dataset")

# Set up path to location where files were unzipped
datapath <- file.path("C:/Users/mastapeterj/Documents/Coursera_DataScience", "UCI HAR Dataset")

#check files for complete list of files
files <- list.files(datapath, recursive = TRUE)

#review files
files

#set up train tables
train_X <- read.table(file.path(datapath, "train", "x_train.txt"),header = FALSE)
train_y <- read.table(file.path(datapath, "train", "y_train.txt"),header = FALSE)
subject_train <- read.table(file.path(datapath, "train", "subject_train.txt"), header = FALSE)

#set up test tables
test_X <- read.table(file.path(datapath, "test", "X_test.txt"),header = FALSE)
test_y <- read.table(file.path(datapath, "test", "y_test.txt"),header = FALSE)
subject_test <- read.table(file.path(datapath, "test", "subject_test.txt"), header = FALSE)

#set up feature data
feature_data <- read.table(file.path(datapath, "features.txt"),header = FALSE)

#set up activity labels
activity_labels <- read.table(file.path(datapath, "activity_labels.txt"),header = FALSE)

#set up column and sanity values for the train data tables
colnames(train_X) <- feature_data[,2]
colnames(train_y) <- "activityId"
colnames(subject_train) <- "subjectId"

#set up column ansd sanity values for test data tables
colnames(test_X) <- feature_data[,2]
colnames(test_y) <- "activityId"
colnames(subject_test) <- "subjectId"

#set up sanity check for activity label values
colnames(activity_labels) <- c('activityId', 'activityType')

#set up merges for the train and test data tables
train_mrg <- cbind(train_y, subject_train, train_X)
test_mrg <- cbind(test_y, subject_test, test_X)

#set up merge of both data tables
train_test_mrg <- rbind(train_mrg, test_mrg)

#read all the values that in the data table
Named_cols <- colnames(train_test_mrg)

#set up subset of all the standards and mean from the relative activityID and subjectID
standards_means <- (grepl("activityId", Named_cols) | grepl("subjectId", Named_cols) | grepl("mean..", Named_cols) | grepl("std..", Named_cols))

#set up a subset to be created for the required data table
standards_means_set <- train_test_mrg[, standards_means == TRUE]

#set names to match activity labels
set_activity_labels <- merge(standards_means_set, activity_labels, by = 'activityId', all.x = TRUE)

#create new tidy set
new_tidy_set <- aggregate(. ~subjectId + activityId, set_activity_labels, mean)
new_tidy_set <- new_tidy_set[order(new_tidy_set$subjectId, new_tidy_set$activityId),]

#print new data table
write.table(new_tidy_set, "new_tidy_set.txt", row.names = FALSE)
