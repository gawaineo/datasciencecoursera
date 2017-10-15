# Getting and Cleaning Data - Week 4 Final Project
library(dplyr)
library(data.table)

# '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

setwd("./UCI_HAR_Dataset/")
#---------------------TEST DATA SET---------------------#

feature_names <- read.table("./features.txt", header = FALSE)
# LOAD DATA: Test Set
subjects_ID_num_test <- read.table("./test/subject_test.txt", header = FALSE)
training_set_test <- read.table("./test/X_test.txt", header = FALSE)
activity_label_ID_test <- read.table("./test/Y_test.txt", header = FALSE)
# LOAD DATA: Train Set
subjects_ID_num_train <- read.table("./train/subject_train.txt", header = FALSE)
training_set_train <- read.table("./train/X_train.txt", header = FALSE)
activity_label_ID_train <- read.table("./train/Y_train.txt", header = FALSE)

# ADD: column names based on the features list, activity, subjects ID
names(training_set_test) <- feature_names[,2]
names(training_set_train) <- feature_names[,2]
names(activity_label_ID_test) <- c("physical_activity_type")
names(subjects_ID_num_test) <- c("subject_id")
names(activity_label_ID_train) <- c("physical_activity_type")
names(subjects_ID_num_train) <- c("subject_id")

# FILTER: Columns in data frame that are only related to mean and standard deviation
std_col_names <- grep("std()", colnames(training_set_test), value = TRUE)
mean_col_names <- grep("mean()", colnames(training_set_test), value = TRUE)

# REDUCE: Reduce the number of columns to show only mean() and std() columns
only_mean_columns_test <- training_set_test[mean_col_name_index]
only_std_columns_test <- training_set_test[std_col_name_index]
only_mean_columns_train <- training_set_train[mean_col_name_index]
only_std_columns_train <- training_set_train[std_col_name_index]

# REMOVE/CLEANUP: Remove original train and test data
rm(training_set_test, training_set_train)

# Combine columns on TEST set and on TRAIN set, and then combine by row 
test_set_narrow <- cbind(subjects_ID_num_test, activity_label_ID_test, only_mean_columns_test, only_std_columns_test)
train_set_narrow <- cbind(subjects_ID_num_train, activity_label_ID_train, only_mean_columns_train, only_std_columns_train)

# Add rows from TRAIN and TEST set to combine all the data sets using rbind
merged_set <- rbind(test_set_narrow, train_set_narrow)

# FINAL STEP: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Update physical activity label colum with real names for the activity
# test_set_narrow$physical_activity[test_set_narrow$physical_activity == 6,] <- c("LAYING")
# test_set_narrow$physical_activity[test_set_narrow$physical_activity == 5,] <- c("STANDING")
# test_set_narrow$physical_activity[test_set_narrow$physical_activity == 4,] <- c("SITTING")
# test_set_narrow$physical_activity[test_set_narrow$physical_activity == 3,] <- c("WALKING_DOWNSTAIRS")
# test_set_narrow$physical_activity[test_set_narrow$physical_activity == 2,] <- c("WALKING_UPSTAIRS")
# test_set_narrow$physical_activity[test_set_narrow$physical_activity == 1,] <- c("WALKING")
# 
# train_set_narrow$physical_activity[train_set_narrow$physical_activity == 6,] <- c("LAYING")
# train_set_narrow$physical_activity[train_set_narrow$physical_activity == 5,] <- c("STANDING")
# train_set_narrow$physical_activity[train_set_narrow$physical_activity == 4,] <- c("SITTING")
# train_set_narrow$physical_activity[train_set_narrow$physical_activity == 3,] <- c("WALKING_DOWNSTAIRS")
# train_set_narrow$physical_activity[train_set_narrow$physical_activity == 2,] <- c("WALKING_UPSTAIRS")
# train_set_narrow$physical_activity[train_set_narrow$physical_activity == 1,] <- c("WALKING")




# Use GroupBy to average each column by physical activity and subject

#----------------------END------------------------------#
