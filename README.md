---
title: "readme"
author: "MNicola76"
date: "Saturday, June 21, 2014"
output: html_document
---

# Introduction

The script `run_analysis.R`
using the data from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html)
* merges the training and test sets to create one data set
* extracts only the measurements (features) on the mean and standard deviation
  for each measurement
* replaces `activity` values in the dataset with descriptive activity names
* appropriately labels the columns with descriptive names
* creates a second, independent tidy dataset with an average of each variable
  for each each activity and each subject. In other words, same type of
  measurements for a particular subject and activity are averaged into one value
  and the tidy data set contains these mean values only. The processed tidy data
  set is also exported as a text (txt) file.
  
# run_analysis.R

The script is parititioned into 5 steps such that each section performs one of the
steps described above (and aligned to the 5 steps outlined in the project instructions). 

# The original data set

The original data set is split into training and test sets (70% and 30%,
respectively) where each partition is also split into three files that contain
* measurements from the accelerometer and gyroscope
* activity label
* identifier of the subject

# Getting and cleaning data

The first step of the preprocessing is to merge the training and test
sets. Two sets combined, there are 10,299 observations where each
instance contains 561 features. After
the merge operation on the resulting data, the table contains 563 columns (561
measurements, subject identifier and activity label).

After the merge operation, mean and standard deviation features are extracted
for further processing. Out of 561 measurement features, 79 mean and standard
deviations features are extracted, yielding a data frame with 81 features
(additional two features are subject identifier and activity label).

Next, the activity labels are replaced with descriptive activity names, defined
in `activity_labels.txt` in the original data folder.

The final step creates a tidy data set with the average of each variable for
each activity and each subject. 10299 instances are split into 180 groups (30
subjects and 6 activities) and 79 mean and standard deviation features are
averaged for each group. The resulting data table has 180 rows and 81 columns.
The tidy data set is exported to `tidy_dataset.txt` where the first row is the
header containing the names for each column.
