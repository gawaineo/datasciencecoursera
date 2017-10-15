# Getting and Cleaning Data - Week 4 Final Project
# Author: Gawaine O'Gilvie

library(dplyr)
library(data.table)

zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# destination zip
destfile <- paste0(getwd(), "/", "getting_cleaning_week4.zip")

# download and unzip file
print("Downloading zip file")
download.file(zipUrl, destfile, method = "curl")

print("Unzipping Data Files.")
unzip("./getting_cleaning_week4.zip")

print("Producing Tidy Data")

# LOAD DATA: Read features file
feature_names <- read.table("UCI HAR Dataset/features.txt", header = FALSE)

# LOAD DATA: Test Set
subjects_ID_num_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
training_set_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
activity_label_ID_test <- read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE)

# LOAD DATA: Train Set
subjects_ID_num_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
training_set_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
activity_label_ID_train <- read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE)

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
only_mean_columns_test <- training_set_test[mean_col_names]
only_std_columns_test <- training_set_test[std_col_names]
only_mean_columns_train <- training_set_train[mean_col_names]
only_std_columns_train <- training_set_train[std_col_names]

# REMOVE/CLEANUP: Remove original train and test data
rm(training_set_test, training_set_train)

# Combine columns on TEST set and on TRAIN set, and then combine by row 
test_set_narrow <- cbind(subjects_ID_num_test, activity_label_ID_test, only_mean_columns_test, only_std_columns_test)
train_set_narrow <- cbind(subjects_ID_num_train, activity_label_ID_train, only_mean_columns_train, only_std_columns_train)

# Add rows from TRAIN and TEST set to combine all the data sets using rbind
merged_feature_set <- rbind(test_set_narrow, train_set_narrow)

#-------------------------------------FINAL STEP------------------------------#
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- merged_feature_set %>% group_by(physical_activity_type, subject_id) %>% summarise_all(mean)

# Updated the physical activity type to descriptive labels
tidy_data$physical_activity_type[tidy_data$physical_activity_type == 6] <- c("LAYING")
tidy_data$physical_activity_type[tidy_data$physical_activity_type == 5] <- c("STANDING")
tidy_data$physical_activity_type[tidy_data$physical_activity_type == 4] <- c("SITTING")
tidy_data$physical_activity_type[tidy_data$physical_activity_type == 3] <- c("WALKING_DOWNSTAIRS")
tidy_data$physical_activity_type[tidy_data$physical_activity_type == 2] <- c("WALKING_UPSTAIRS")
tidy_data$physical_activity_type[tidy_data$physical_activity_type == 1] <- c("WALKING")

# Output the tidydata to a file
write.table(tidy_data, "tidy_data_by_activity_and_subject.txt", row.name=FALSE)


