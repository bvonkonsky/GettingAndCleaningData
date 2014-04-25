## Author: Brian von Konsky
## Course: Getting and Cleaning Data
## Date Created: 20 April 2014

## Get a list of valid activity labels
getActivityLabels <- function() {
  
  ## OS independent path to file mapping of label IDs to labels
  labelFilename <- file.path("UCI HAR Dataset", "activity_labels.txt")
  labels <- read.table(labelFilename)
  names(labels) <- c("ActivityID", "Activity")
  activityLabels <- labels$Activity
  return (activityLabels)
}

## Return a list of Subjects IDs for each observation in the set
getSubjectIDs <- function(fileName) {
  subjectIDs <- read.table(fileName)
  names(subjectIDs) <- "SubjectID"
  
  return (subjectIDs)
}

## Return the activities asscoiated with each observation in the set
getActivities <- function(fileName) {
  
  ## Get the list of valid activities
  activityLookupTable <- getActivityLabels()
  
  ## Convert the list of ActivityIDs to meaningful labels.
  ## Assume labels in the activity lookup table are in sequential order with no gaps.
  activitiesID <- read.table(fileName)
  activities <- lapply(activitiesID, function (x,tbl) tbl[x], tbl=activityLookupTable)
  names(activities) <- "Activity"
  
  return (activities)
}

## Return a tidy data frame for data in the set
getData <- function(fileName) {
  
  ## Get features from file specified in the OS indepedent file path
  featuresFilename <- file.path("UCI HAR Dataset", "features.txt")
  featureTable <- read.table(featuresFilename)
  names(featureTable) <- c("FeatureIndex", "Feature")
  features <- featureTable$Feature
  
  ## Read the raw data and set the names for each attribute
  data <- read.table(fileName)
  names(data) <- features
  
  ## Keep rows that end in mean() or std() and drop the others
  rexpr <- "(mean|std)\\(\\)$"
  rexpr <- "(mean|std)\\(\\)"
  keep <- grepl(rexpr, features)
  data <- data[keep]
  
  ## Clean the attribute names to make them more readable
  theNames <- names(data)
  theNames <- gsub("\\(\\)","", theNames)                ## Get rid of pairs of parenthesis
  theNames <- gsub("Mag", "Magnitude", theNames)         ## Change Mag to Magnitude
  theNames <- gsub("Acc", "Acceleration", theNames)      ## Change Acc to Acceleration
  theNames <- gsub("std", "StandardDeviation", theNames) ## Change std to StandardDeviation
  theNames <- gsub("mean", "Mean", theNames)             ## Change mean to Mean
  theNames <- gsub("[-.]", "", theNames)                 ## Remove dots and hyphens
  names(data) <- theNames
  
  return(data)
}

## Get and clean data for a given set (e.g. trianing or test)
getAndClean <- function(subjectsFilename, labelsFilename, dataFilename) {
  
  ## Get the different parts of the data frame for this set
  subjectIDs <- getSubjectIDs(subjectsFilename)
  activities <- getActivities(labelsFilename)
  data <- getData(dataFilename)
  
  ## Combine all parts of the data frame for this set
  df <- data.frame(subjectIDs, activities, data)
  return (df)
}

## Average the data for each measurement in the merged data frame for each combination of subject and activity
averageTidy <- function(mergedDF) {
  
  ## Aggregate the data using the mean function on factor variables for SubjectID and Activity, and use the same column names
  averagedDF <- aggregate(data.matrix(mergedDF[3:ncol(mergedDF)]) ~ mergedDF$SubjectID + mergedDF$Activity, mergedDF, mean)
  names(averagedDF) <- names (mergedDF)
  return (averagedDF)
}

#if the subdirectory wiht the original doesn't exist, download and unzip it
downloadData <- function() {
  ## Set file names
  original <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  local    <- "data.zip"
  directory<- "UCI HAR Dataset"
  
  ## If the file doesn't exist, then get tt
  if (!file.exists(directory)) {
    
    ## Download and unzip
    download.file(original,local, method="curl" )
    unzip(local)
  }

}

main <- function(){
  
  ## Files in the Training Set - specified using file.path() so will work on different operating systems
  trainSubjectsFilename <- file.path("UCI HAR Dataset", "train", "subject_train.txt")
  trainLabelsFilename <- file.path("UCI HAR Dataset", "train", "y_train.txt")
  trainDataFilename <- file.path("UCI HAR Dataset", "train", "X_train.txt")
  
  ## Files in the Test Set - specified using file.path() so will work on different operating systems
  testSubjectsFilename <- file.path("UCI HAR Dataset", "test", "subject_test.txt")
  testLabelsFilename <- file.path("UCI HAR Dataset", "test", "y_test.txt")
  testDataFilename <- file.path("UCI HAR Dataset", "test", "X_test.txt")
  
  ## Output csv filnames
  tidyMergedFilename <- "tidyMerged.csv"
  tidyAveragedFilename<- "tidyAveraged.csv"
  
  # Download the data if necessary
  downloadData()
  
  # Build complete tidy data frames for both the training and test data sets
  trainDF <- getAndClean(trainSubjectsFilename, trainLabelsFilename, trainDataFilename)
  testDF  <- getAndClean(testSubjectsFilename, testLabelsFilename, testDataFilename)
  
  ## Merge the test and traing data sets and write it out as a single CSV file
  mergedDF <- merge(trainDF, testDF, all=TRUE, sort=FALSE)
  write.csv(mergedDF, tidyMergedFilename, row.names=FALSE)
  
  ## Compute the average for each variable by subject ID and activity
  ## and write it out as a CSV file
  averagedDF <- averageTidy(mergedDF)
  write.csv(averagedDF, tidyAveragedFilename, row.names=FALSE)
}

main()