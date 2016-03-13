---
title: "Readme"
author: "Shan-Chiou Lin"
date: "March 13, 2016"
output: html_document
---
## Readme
The tidy data in tidy.txt can be read into R with the following code:


```r
read.table("tidy.txt", header=TRUE, colClasses=c('factor', 'factor', rep('numeric', 66)))
```

```
## Warning in file(file, "rt"): cannot open file 'tidy.txt': No such file or
## directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

## Overview 

The tidy.txt file in this directory is a tidy subset of the data provided in the Human Activity Recognition Using Smartphones Data Set. The source data is available from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones# and it's also included in the UCI HAR Dataset directory in this repo.

tidy.txt includes the combined test and training data sets from the following files:

UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt

codebook.md describes the tidy data set.

Transformation done by run_analysis.R:

# Load Data Set

The data source will be: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

And its explanation could be found: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data Processing & Merging the dataset
Combine the values from the subject_test and subject_train files to create a single Subject_Com that identifies the study participant.

Combine the values from the Feature_Test(X_test.txt) and Feature_Train files(X_train.txt) to create additional variable columns, one column for each measurement and calculation included in the data set 

Combine the values from the Activity_test(Y_test) and Activity_Train(Y_train) data to create a single Activity column that indicates that activity class (for instance, walking or sitting).

And then Combine all three datasets into one dataset, FullData.

## Extracts only the measurements on the mean and standard deviation for each measurement.
Use the dplyr select function to create a subset of the data that only includes columns that have ".mean." and ".std." in their column names.

## Use descriptive activity names to name the activities in the data set.
Using looping function to match value with Activity Label

## Appropriately labels the data set with descriptive variable names
 BodyBody is replaced by Body
 Mag is replaced by Magnitude
 Acc is replaced by Accelerator
 Gyro is replaced by Gyroscope
 prefix f is replaced by frequency
 prefix t is replaced by time

Using gsub to matching and replacing

# Creates a second,independent tidy data set and ouput it
Using aggregate function to group by  "Subject" & "Activity"
write.table to output the Tidy dataset.  
