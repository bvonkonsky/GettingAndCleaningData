### CodeBook - Getting and Cleaning Data Assignment
|                |                                                        |
|:---------------|:-------------------------------------------------------|
|**Author:**     | Brian von Konsky
|**Created:**    | April 2014
|**Course:**     | Getting and Cleaning Data
|**Repository:** | [https://github.com/bvonkonsky/GettingAndCleaningData](https://github.com/bvonkonsky/GettingAndCleaningData)

The [original data](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/) for this data cleaning assignment were measured in a study conducted by Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, and Davide Anguita.  More information about the data and the study that produced it is available on the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Papers arising from the original or cleaned data should reference:

> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. _International Workshop of Ambient Assisted Living (IWAAL 2012)_. Vitoria-Gasteiz, Spain. Dec 2012.

The original data were downloaded and subsequently cleaned using an [R script](http://www.r-project.org/) called [run_analysis.R](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/run_analysis.R).

The cleaned version merges the training and test data from the original study, and uses arguably more meaningful variable names. The mapping from original to modified variable names are shown in the table below.  Occurrences of **Mag** were changed to **Magnitude**, **Acc** to **Accelerate**, **std** to **StadardDeviation** and **mean** to **Mean**. All parentheses, dots and hyphens were removed. The **t** prefixes for **time** and **f** prefixes for **frequency domain** at the beginning of variable names were retained to avoid making names more unwieldy. A small modification to the script could easily expand this if desired.  

The cleaned version of the data only retains original variables that include **mean** or **std**.  Variables that did not contain **mean** or **std** were intentionally dropped from the cleaned data set.

The cleaned version of the data follows the four principles of a Tidy Dataset as described by [Jeff Leek](http://biostat.jhsph.edu/~jleek/) and the Leek Group in their document on [datasharing](https://github.com/jtleek/datasharing). Specifically:
* each variable is in its own column;
* each observation is contained in a single row, in this case labeled by subject ID and the activity that the subject was engaged in at the time of the measurement;
* one table for each kind of measurement, in this case measurements taken using Samsung mobile devices recorded while subjects were engaged in various activities; and
* multiple tables are readily linked, in this case, by subject ID and activity.

The [run_analysis.R](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/run_analysis.R) script produces cleaned and tidy data in two Comma Separated Value (CSV) files.  The [first CSV file](https://www.dropbox.com/s/8a5fmarat30p01b/tidyMerged.csv) contains merged training and test data.  The [second CSV file](https://www.dropbox.com/s/2ck82baeuyjceg8/tidyAveraged.csv) contains the average of all observations for a given subject and activity.

All units in the cleaned data are the same as those used in the original data.

**See Also:** [README.md](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/README.md)

|Column| Variable                                  | Definition                                                     |
|------|:------------------------------------------|:---------------------------------------------------------------|
|1     |SubjectID                                  | Unique integer referring to individual study participants.  Ranges between 1 and 30.
|2     |Activity                                   | Factor | variable describing the activity being measured. One of: WALKING, WALKING\_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
|3 |tBodyAccelerationMeanX| Pre-cleaning variable name: tBodyAcc-mean()-X
|4 |tBodyAccelerationMeanY| Pre-cleaning variable name: tBodyAcc-mean()-Y
|5 |tBodyAccelerationMeanZ| Pre-cleaning variable name: tBodyAcc-mean()-Z
|6 |tBodyAccelerationStandardDeviationX| Pre-cleaning variable name: tBodyAcc-std()-X
|7 |tBodyAccelerationStandardDeviationY| Pre-cleaning variable name: tBodyAcc-std()-Y
|8 |tBodyAccelerationStandardDeviationZ| Pre-cleaning variable name: tBodyAcc-std()-Z
|9 |tGravityAccelerationMeanX| Pre-cleaning variable name: tGravityAcc-mean()-X
|10 |tGravityAccelerationMeanY| Pre-cleaning variable name: tGravityAcc-mean()-Y
|11 |tGravityAccelerationMeanZ| Pre-cleaning variable name: tGravityAcc-mean()-Z
|12 |tGravityAccelerationStandardDeviationX| Pre-cleaning variable name: tGravityAcc-std()-X
|13 |tGravityAccelerationStandardDeviationY| Pre-cleaning variable name: tGravityAcc-std()-Y
|14 |tGravityAccelerationStandardDeviationZ| Pre-cleaning variable name: tGravityAcc-std()-Z
|15 |tBodyAccelerationJerkMeanX| Pre-cleaning variable name: tBodyAccJerk-mean()-X
|16 |tBodyAccelerationJerkMeanY| Pre-cleaning variable name: tBodyAccJerk-mean()-Y
|17 |tBodyAccelerationJerkMeanZ| Pre-cleaning variable name: tBodyAccJerk-mean()-Z
|18 |tBodyAccelerationJerkStandardDeviationX| Pre-cleaning variable name: tBodyAccJerk-std()-X
|19 |tBodyAccelerationJerkStandardDeviationY| Pre-cleaning variable name: tBodyAccJerk-std()-Y
20 |tBodyAccelerationJerkStandardDeviationZ| Pre-cleaning variable name: tBodyAccJerk-std()-Z
|21 |tBodyGyroMeanX| Pre-cleaning variable name: tBodyGyro-mean()-X
|22 |tBodyGyroMeanY| Pre-cleaning variable name: tBodyGyro-mean()-Y
|23 |tBodyGyroMeanZ| Pre-cleaning variable name: tBodyGyro-mean()-Z
|24 |tBodyGyroStandardDeviationX| Pre-cleaning variable name: tBodyGyro-std()-X
|25 |tBodyGyroStandardDeviationY| Pre-cleaning variable name: tBodyGyro-std()-Y
|26 |tBodyGyroStandardDeviationZ| Pre-cleaning variable name: tBodyGyro-std()-Z
|27 |tBodyGyroJerkMeanX| Pre-cleaning variable name: tBodyGyroJerk-mean()-X
|28 |tBodyGyroJerkMeanY| Pre-cleaning variable name: tBodyGyroJerk-mean()-Y
|29 |tBodyGyroJerkMeanZ| Pre-cleaning variable name: tBodyGyroJerk-mean()-Z
|30 |tBodyGyroJerkStandardDeviationX| Pre-cleaning variable name: tBodyGyroJerk-std()-X
|31 |tBodyGyroJerkStandardDeviationY| Pre-cleaning variable name: tBodyGyroJerk-std()-Y
|32 |tBodyGyroJerkStandardDeviationZ| Pre-cleaning variable name: tBodyGyroJerk-std()-Z
|33 |tBodyAccelerationMagnitudeMean| Pre-cleaning variable name: tBodyAccMag-mean()
|34 |tBodyAccelerationMagnitudeStandardDeviation| Pre-cleaning variable name: tBodyAccMag-std()
|35 |tGravityAccelerationMagnitudeMean| Pre-cleaning variable name: tGravityAccMag-mean()
|36 |tGravityAccelerationMagnitudeStandardDeviation| Pre-cleaning variable name: tGravityAccMag-std()
|37 |tBodyAccelerationJerkMagnitudeMean| Pre-cleaning variable name: tBodyAccJerkMag-mean()
|38 |tBodyAccelerationJerkMagnitudeStandardDeviation| Pre-cleaning variable name: tBodyAccJerkMag-std()|
|39 |tBodyGyroMagnitudeMean| Pre-cleaning variable name: tBodyGyroMag-mean()
|40 |tBodyGyroMagnitudeStandardDeviation| Pre-cleaning variable name: tBodyGyroMag-std()
|41 |tBodyGyroJerkMagnitudeMean| Pre-cleaning variable name: tBodyGyroJerkMag-mean()
|42 |tBodyGyroJerkMagnitudeStandardDeviation| Pre-cleaning variable name: tBodyGyroJerkMag-std()
|43 |fBodyAccelerationMeanX| Pre-cleaning variable name: fBodyAcc-mean()-X
|44 |fBodyAccelerationMeanY| Pre-cleaning variable name: fBodyAcc-mean()-Y
|45 |fBodyAccelerationMeanZ| Pre-cleaning variable name: fBodyAcc-mean()-Z
|46 |fBodyAccelerationStandardDeviationX| Pre-cleaning variable name: fBodyAcc-std()-X
|47 |fBodyAccelerationStandardDeviationY| Pre-cleaning variable name: fBodyAcc-std()-Y
|48 |fBodyAccelerationStandardDeviationZ| Pre-cleaning variable name: fBodyAcc-std()-Z
|49 |fBodyAccelerationJerkMeanX| Pre-cleaning variable name: fBodyAccJerk-mean()-X
|50 |fBodyAccelerationJerkMeanY| Pre-cleaning variable name: fBodyAccJerk-mean()-Y
|51 |fBodyAccelerationJerkMeanZ| Pre-cleaning variable name: fBodyAccJerk-mean()-Z
|52 |fBodyAccelerationJerkStandardDeviationX| Pre-cleaning variable name: fBodyAccJerk-std()-X
|53 |fBodyAccelerationJerkStandardDeviationY| Pre-cleaning variable name: fBodyAccJerk-std()-Y
|54 |fBodyAccelerationJerkStandardDeviationZ| Pre-cleaning variable name: fBodyAccJerk-std()-Z
|55 |fBodyGyroMeanX| Pre-cleaning variable name: fBodyGyro-mean()-X
|56 |fBodyGyroMeanY| Pre-cleaning variable name: fBodyGyro-mean()-Y
|57 |fBodyGyroMeanZ| Pre-cleaning variable name: fBodyGyro-mean()-Z
|58 |fBodyGyroStandardDeviationX| Pre-cleaning variable name: fBodyGyro-std()-X
|59 |fBodyGyroStandardDeviationY| Pre-cleaning variable name: fBodyGyro-std()-Y
|60 |fBodyGyroStandardDeviationZ| Pre-cleaning variable name: fBodyGyro-std()-Z
|61 |fBodyAccelerationMagnitudeMean| Pre-cleaning variable name: fBodyAccMag-mean()
|62 |fBodyAccelerationMagnitudeStandardDeviation| Pre-cleaning variable name: fBodyAccMag-std()
|63 |fBodyBodyAccelerationJerkMagnitudeMean| Pre-cleaning variable name: fBodyBodyAccJerkMag-mean()
|64 |fBodyBodyAccelerationJerkMagnitudeStandardDeviation| Pre-cleaning variable name: fBodyBodyAccJerkMag-std()
|65 |fBodyBodyGyroMagnitudeMean| Pre-cleaning variable name: fBodyBodyGyroMag-mean()
|66 |fBodyBodyGyroMagnitudeStandardDeviation| Pre-cleaning variable name: fBodyBodyGyroMag-std()
|67 |fBodyBodyGyroJerkMagnitudeMean| Pre-cleaning variable name: fBodyBodyGyroJerkMag-mean()
|68 |fBodyBodyGyroJerkMagnitudeStandardDeviation| Pre-cleaning variable name: fBodyBodyGyroJerkMag-std()