## Loading Data

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

unzip(zipfile="./data/Dataset.zip",exdir="./data")


## Merges the training and the test sets to create one data set.

# Read Subject Data 
Subject_Test <- read.table(file.path("./data" , "UCI HAR Dataset", "test" , "subject_test.txt" ),header = FALSE)
Subject_Train <- read.table(file.path("./data" , "UCI HAR Dataset", "train" , "subject_train.txt" ),header = FALSE)

# Read Feature Data

Feature_Test <- read.table(file.path("./data" , "UCI HAR Dataset", "test", "X_test.txt"), header = FALSE)
Feature_Train <- read.table(file.path("./data" , "UCI HAR Dataset", "train", "X_train.txt"), header = FALSE)

# Read Activity Data

Activity_Test <- read.table(file.path("./data" , "UCI HAR Dataset", "test", "Y_test.txt"), header = FALSE)
Activity_Train <- read.table(file.path("./data" , "UCI HAR Dataset", "train", "Y_train.txt"), header = FALSE)


# Subject Combination

Subject_Com <- rbind(Subject_Test, Subject_Train)

# Feature Combination

Feature_Com <- rbind(Feature_Test, Feature_Train)


# Activity Combination

Activity_Com <- rbind(Activity_Test, Activity_Train)

# Name to Activity, Feature, & Subject
names(Subject_Com)<-c("subject")
names(Activity_Com)<- c("activity")
FeaturesName <- read.table(file.path("./data" , "UCI HAR Dataset", "features.txt"),head=FALSE)
names(Feature_Com)<- FeaturesName$V2

# Data Merge by column

Sub_Act_Merge <- cbind(Subject_Com, Activity_Com)

FullData <- cbind(Sub_Act_Merge, Feature_Com)


## Extracts only the measurements on the mean and standard deviation for each measurement.

 Extract_Feature_Mean_ST<- FeaturesName$V2[grep("mean\\(\\)|std\\(\\)", FeaturesName$V2)]

selectedNames<-c(as.character(Extract_Feature_Mean_ST), "subject", "activity" )

FullData_Selected <- subset(FullData, select=selectedNames)

## Uses descriptive activity names to name the activities in the data set

Activity_Labels <- read.table(file.path("./data" , "UCI HAR Dataset","activity_labels.txt"),header = FALSE)

FullData_Selected$activity <- as.character(FullData_Selected$activity)
for (i in 1:6){
FullData_Selected$activity[FullData_Selected$activity == i] <- as.character(Activity_Labels[i,2])
}

str(FullData_Selected$activity)

## Appropriately labels the data set with descriptive variable names

# BodyBody is replaced by Body
# Mag is replaced by Magnitude
# Acc is replaced by Accelerator
# Gyro is replaced by Gyroscope
# prefix f is replaced by frequency
# prefix t is replaced by time


names(FullData_Selected)<-gsub("Mag", "Magnitude", names(FullData_Selected))
names(FullData_Selected)<-gsub("BodyBody", "Body", names(FullData_Selected))
names(FullData_Selected) <- gsub("Acc", "Accelerator", names(FullData_Selected))
names(FullData_Selected) <- gsub("Gyro", "Gyroscope", names(FullData_Selected))
names(FullData_Selected) <- gsub("^t", "time", names(FullData_Selected))
names(FullData_Selected) <- gsub("^f", "frequency", names(FullData_Selected))

# Creates a second,independent tidy data set and ouput it

Tidy_FullData_Selected <- aggregate(. ~ subject + activity, FullData_Selected, mean)
Tidy_FullData_Selected <- Tidy_FullData_Selected[order(Tidy_FullData_Selected$subject,Tidy_FullData_Selected$activity),]

write.table(Tidy_FullData_Selected, file = "Tidy.txt", row.names = FALSE)

#Prouduce Codebook

library(knitr)
knit2html("codebook.Rmd");
