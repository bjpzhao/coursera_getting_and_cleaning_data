Coursera Getting and Cleaning Data: Course Project
==================================

## Introduction
This repository contains my work for the course project of Coursera Getting and Cleaning Data Course.

## run_analysis.R
The cleanup script (run_analysis.R) does the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Running the script
* Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
* Make sure the folder "getdata-projectfiles-UCI HAR Dataset" and the run_analysis.R script are both in the current working directory.
* Use source("run_analysis.R") command in RStudio.
* You will find two output files are generated in the current working directory:
 - 1. CleanData.txt (7.95 Mb): it contains a data frame called cleanData with 10299*68 dimension.
 - 2. DataWithMeans.txt (218 Kb): it contains a data frame called DataWithMeans with 180*68 dimension.




Peng Zhao


