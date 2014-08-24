## Course:      Getting and Cleaning Data
## Project:     Course Project - Human Activity Recognition Using Smart Phones

## Filename:    run_analysis.R
## Desc:        Merges datasets to create a tidy dataset with the average
##              of each variable for each activity and each subject.
## Author:      Bryan Sirtosky
## Date:        8/22/14

## Datasets:    Datasets and related information are in the UCI HAR Dataset
##              folder.

run_analysis <- function () {
    ## Get and combine test data
    testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
    testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt")
    
    dftest <- cbind(testActivity, testSubject, testData)

    ## Get and combine train data
    trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
    trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt")
    
    dftrain <- cbind(trainActivity, trainSubject, trainData)
    
    ## Combine test and train data
    df <- rbind(dftest, dftrain)

    ## Subset to activity, subject, and std and mean variables
    dataNames <- read.table("./UCI HAR Dataset/features.txt")
    colsOfInterest <- subset(dataNames,grepl("^.+(mean\\(|std\\().+$",V2))
    colsOfInterest$V1 <- colsOfInterest$V1 + 2
    colSubset <- c(1, 2, colsOfInterest$V1)
    df2 <- df[, colSubset ]

    ## Update to descriptive activity name
    activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    df2$V1 <- activityLabels[df2$V1, 2]
    
    ## Label dataset with descriptive variable names
    colsOfInterest$V2 <- gsub("-|\\(\\)", "", colsOfInterest$V2 )
    varNames <- c("activity", "subject", colsOfInterest$V2)
    names(df2) <- varNames
    
    ## Create tidy datset with average of each variable for each activity
    ## and each subject
    tidydf <- aggregate(df2[,3:68], by=list(df2$activity,df2$subject), FUN="mean")
    names(tidydf) <- varNames
    write.table(tidydf, file = "tidydata.txt", row.names=FALSE)
}
