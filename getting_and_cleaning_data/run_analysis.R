# Getting and Cleaning Data - Week 4 Final Project
library(dplyr)
library(data.table)

# '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

setwd("./UCI_HAR_Dataset/")
#---------------------TEST DATA SET---------------------#

feature_names <- read.table("./features.txt", header = FALSE)
# Test Set
subjects_ID_num_test <- read.table("./test/subject_test.txt", header = FALSE)
training_set_test <- read.table("./test/X_test.txt", header = FALSE)
activity_label_ID_test <- read.table("./test/Y_test.txt", header = FALSE)
# Train Set
subjects_ID_num_train <- read.table("./train/subject_train.txt", header = FALSE)
training_set_train <- read.table("./train/X_train.txt", header = FALSE)
activity_label_ID_train <- read.table("./train/Y_train.txt", header = FALSE)

# Add column names based on the features list, activity, subjects ID
names(training_set_test) <- feature_names[,2]
names(training_set_train) <- feature_names[,2]
names(activity_label_ID_test) <- c("physical_activity(test)")
names(subjects_ID_num_test) <- c("subject_id(test)")

# Columns in data frame that are only related to mean and standard deviation, get the index of those columns
std_col_name_index <- grep("std()", colnames(training_set_test))
mean_col_name_index <- grep("mean()", colnames(training_set_test))
# Reduce the number of columns to show only mean() and std()
only_mean_columns_test <- select(training_set_test, as.vector(mean_col_name_index))
only_std_columns_test <- select(training_set_test, as.vector(std_col_name_index))
only_mean_columns_train <- select(training_set_train, as.vector(mean_col_name_index))
only_mean_columns_train <- select(training_set_train, as.vector(std_col_name_index))

# Name columns for mean and std data frames
names(only_mean_columns_test) <- names(training_set_test[mean_col_name_index])
names(only_std_columns_test) <- names(training_set_test[std_col_name_index])

# Combine columns on TEST set, 
#test_set_narrow <- cbind(only_mean_columns_test, only_std_columns_test, activity_label_ID_test)

# Add rows from TRAIN set to combine all the data sets using rbind

# include other data sets in the Inertia folder

#----------------------END------------------------------#
