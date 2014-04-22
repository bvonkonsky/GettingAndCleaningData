The [original data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for this data cleaning assignment wer produced by Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, and Davide Anguita.  More information about the data and the study that produced it is available on the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Papers arising from the original or cleaned data should reference:

>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. _International Workshop of Ambient Assisted Living (IWAAL 2012)_. Vitoria-Gasteiz, Spain. Dec 2012.

The original data were downloaded and subsequently cleaned using an [R script](http://www.r-project.org/) called [run_analysis.R](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/run_analysis.R).

The cleaned version merges the training and test data from the original study, and uses arguably more meaningful variable names, which are described in the table below. For example, occurrences of **Mag** were changed to **Magnitude**, **Acc** to **Accelerate**, and **std** to **stddev**.  The *t* variable prefixes for *time* and *f* prefixes for *frequency domain* at the beginning of variable were retained to avoid making variable names too unwieldy. A small modification to the script could easily expand this if desired.  

The cleaned version of the data only retains original variables that ended in *mean()* or *std()*.  Variables that included *mean* or *std* elsewhere in the variable name or that did not contain it at all were intentionally dropped from the cleaned data set.

The cleaned version of the data follows the four principles of a Tidy Dataset as described by [Jeff Leek](http://biostat.jhsph.edu/~jleek/) and the Leek Group in their document on [datasharing](https://github.com/jtleek/datasharing). Specifically:
* each variable is in its own column;
* each observation is contained in a single row, in this case labeled by subject ID and the activity the subject was engaging in at the time of the measurement;
* there is one table for each kind of measurement; and
* multiple tables are readily linked, in this case, by subject ID and activity.

The cleaned data exists in two Comma Separated Value (CSV) files.  The first CSV file contains data for each observation, whereas the second contains the average of all observations for a given subject and activity.


|Column| Variable                                  | definition                                                     |
|------|:------------------------------------------|:---------------------------------------------------------------|
|1     |SubjectID                                  | Unique integer referring to individual study participants.  Ranges between 1 and 30.
|2     |Activity                                   | Factor variable describing the activity being measured. One of: WALKING, WALKING\_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
|3     |tBodyAccelerationMagnitude-mean            | Pre-cleaning variable name: tBodyAccMag-mean()
|4     |tBodyAccelerationMagnitude-stddev          | Pre-cleaning variable name: tBodyAccMag-std()
|5     |tGravityAccelerationMagnitude-mean         | Pre-cleaning variable name: tGravityAccMag-mean()
|6     |tGravityAccelerationMagnitude-stddev       | Pre-cleaning variable name: tGravityAccMag-std()
|7     |tBodyAccelerationJerkMagnitude-mean        | Pre-cleaning variable name: tBodyAccJerkMag-mean()
|8     |tBodyAccelerationJerkMagnitude-stddev      | Pre-cleaning variable name: tBodyAccJerkMag-std() 
|9     |tBodyGyroMagnitude-mean                    | Pre-cleaning variable name: tBodyGyroMag-mean()
|10    |tBodyGyroMagnitude-stddev                  | Pre-cleaning variable name: tBodyGyroMag-std()
|11    |tBodyGyroJerkMagnitude-mean                | Pre-cleaning variable name: tBodyGyroJerkMag-mean()
|12    |tBodyGyroJerkMagnitude-stddev              | Pre-cleaning variable name: tBodyGyroJerkMag-std()
|13    |fBodyAccelerationMagnitude-mean            | Pre-cleaning variable name: fBodyAccMag-mean() 
|14    |fBodyAccelerationMagnitude-stddev          | Pre-cleaning variable name: fBodyAccMag-std()
|15    |fBodyBodyAccelerationJerkMagnitude-mean    | Pre-cleaning variable name: fBodyBodyAccJerkMag-mean()
|16    |fBodyBodyAccelerationJerkMagnitude-stddev  | Pre-cleaning variable name: fBodyBodyAccJerkMag-std()
|17    |fBodyBodyGyroMagnitude-mean                | Pre-cleaning variable name: fBodyBodyGyroMag-mean()
|18    |fBodyBodyGyroMagnitude-stddev              | Pre-cleaning variable name: fBodyBodyGyroMag-std()
|19    |fBodyBodyGyroJerkMagnitude-mean            | Pre-cleaning variable name: fBodyBodyGyroJerkMag-mean()
|20    |fBodyBodyGyroJerkMagnitude-stddev          | Pre-cleaning variable name: fBodyBodyGyroJerkMag-std()
