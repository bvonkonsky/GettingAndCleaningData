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
  keep <- grepl(rexpr, features)
  data <- data[keep]

  ## Clean the attribute names to make them more readable
  theNames <- names(data)
  theNames <- sub("\\(\\)$","", theNames)          ## Get rid of the training pair of parenthesis
  theNames <- sub("Mag", "Magnitude", theNames)    ## Change Mag to Magnitude
  theNames <- sub("Acc", "Acceleration", theNames) ## Change Acc to Acceleration
  theNames <- sub("std", "stddev", theNames)       ## Change std to stddev
  names(data) <- sub("\\(\\)$","", theNames)

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

## Average the data each measurement in the merged data frame for each subject by activity
averageTidy <- function(mergedDF) {
  
  # Get sorted list of all subjects and attribute name contained in the merged data frame
  subjectID <- sort(unique(mergedDF$SubjectID))
  theNames <- names(mergedDF)

  # Get the labels used to describe activities
  activityLabels <- as.character(sort(getActivityLabels()))
  
  # Build a table with an appropriate number of rows and columns to hold averaged
  # data for each attribute for each stubject and activity
  numCols <- length(theNames)
  numRows<- length(subjectID) * length(activityLabels)
  table <- array(dim=c(numRows, numCols))
  
  # Build a table with averages for all measurements for each subject and activity 
  for(id in 1:length(subjectID)) {
    for (a in 1:length(activityLabels)) {
      row <- (id-1)*length(activityLabels) + a
      table[row,1] <- id
      table[row,2] <- activityLabels[a]
      theData <- mergedDF[which(mergedDF$SubjectID==id & mergedDF$Activity==activityLabels[a]),]
      for (c in 3:numCols) {
        table[row,c] <- mean(theData[,c])
      }
    }
  }
  
  # Create a data frame with averaged data contained in the table
  # using the same column names as in the merged data frame
  df <- data.frame(table, stringsAsFactors =FALSE, check.names=FALSE, check.rows=FALSE)
  names(df) <- theNames

  return(df)
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
  
  # Build complete tidy data frames for both the training and test data sets
  trainDF <- getAndClean(trainSubjectsFilename, trainLabelsFilename, trainDataFilename)
  testDF  <- getAndClean(testSubjectsFilename, testLabelsFilename, testDataFilename)
  
  ## Merge the test and traing data sets and write it out as a single CSV file
  mergedDF <- merge(trainDF, testDF, all=TRUE, sort=FALSE)
  write.csv(mergedDF, tidyMergedFilename, row.names=FALSE)
  
  ## Compute the average for each variable by subject ID and activity and
  ## write it out as a CSV file
  averagedDF <- averageTidy(mergedDF)
  write.csv(averagedDF, tidyAveragedFilename, row.names=FALSE)
}

main()