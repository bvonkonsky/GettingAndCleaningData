### README.md for run_analysis.R
|                |                                                        |
|:---------------|:-------------------------------------------------------|
|**Author:**     | Brian von Konsky
|**Created:**    | April 2014
|**Course:**     | Getting and Cleaning Data
|**Repository:** | [https://github.com/bvonkonsky/GettingAndCleaningData](https://github.com/bvonkonsky/GettingAndCleaningData)

####Overview
The [R Script](http://www.r-project.org/) called [run_analysis.R](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/run_analysis.R) produces a [tidy dataset](vita.had.co.nz/papers/tidy-data.pdf) from [data](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/) originally collected by Anguita and colleagues (Anguita _et al_., 2012) and available on the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  

#### Original Data 
The original data captured motion attributes using accelerometers and gyroscopes embedded in [Samsung Galaxy SII](http://www.samsung.com/au/smartphone/galaxy-s-2/index.html) smartphones. Data were randomly partitioned to train and test and a system for classifying human activity. A goal was to develop an approach to non-invasively monitor the activity of the elderly.

Measurements were taken from experimental subjects wearing the smartphones while engaged in the following activities: walking, walking upstairs, walking downstairs, sitting, standing, and laying. The training data consisted of 7352 observations of 561 variables from 21 subjects. The test data consisted of 2947 observations of the same 561 variables from 9 subjects. 

The original data format stored test and training data in different sub-directories.  Each sub-directory contained three files. The three files stored raw data, subject identification numbers, and integer values coding one of the 6 activities.  Information for each observation was held in the corresponding line of each file.

####Tidy Data Produced by run_analysis.R
The script [run_analysis.R](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/run_analysis.R):
* merges the training and test data by Subject ID for a given Activity;
* retains mean and standard deviation attributes, assumed to be those attributes that originally ended in **mean()** and **std()**, and drops other attributes;
* makes attribute names arguably more readable by removing parentheses and changing abbreviations like **Mag** to **Magnitude** and **Acc** to **Acceleration**;
* adds columns identifying the subject by **SubjectID** and **Activity**, where activity is shown as a human readable string rather than as an integer.
* generates a tidy dataset of the merged data in [Comma Separated Values (CSV)](http://en.wikipedia.org/wiki/Comma-separated_values) format in a file called **tidyMerged.csv**; and
* generates a second tidy dataset in CSV format that contains the average of reported attributes by subject in a file called **tidyAveraged.csv**.

**See Also:** [CodeBook.md](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/CodeBook.md)

####Running run_analysis.R
To use [run_analysis.R](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/run_analysis.R), do the following:

1. Download and install [R](http://www.r-project.org/) and [R Studio](https://www.rstudio.com/).
2. Obtain a copy of [run_analysis.R](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/run_analysis.R) from [Github](https://github.com/) and store it in your project directory.
3. Run [R Studio](https://www.rstudio.com/).
4. Use **setwd("\<project directory\>")** to set the working directory to your project directory.
5. Use **source("run_analysis.R")** to run the script. If necessary, the script will download and unzip the original data into the current working directory. The original dataset is large, so please be patient. Not including the initial download and unzip, the script takes around 25 seconds to run on a 2.8 GHz Intel Core 2 Duo iMac running Mac OS X 10.8.5.


####Functions

Functions in [run_analysis.R](https://github.com/bvonkonsky/GettingAndCleaningData/blob/master/run_analysis.R) are listed below.

* **main <- function()** </br> Creates two tidy [data frames](http://stat.ethz.ch/R-manual/R-devel/library/base/html/data.frame.html) for the training and test data and then merges these into a single [data frame](http://stat.ethz.ch/R-manual/R-devel/library/base/html/data.frame.html). The merged data frame is written to a CSV file called **tidyMerged.csv**. The merged data frame is then averaged by activity for each subject, and written to a second CSV file called **tidyAveraged.csv**.  Paths to  files and directories in the original data are coded to work on all operating systems supported by R using the file.path() function.  
* **getAndClean <- function(subjectsFilename, labelsFilename, dataFilename)** </br> Recovers raw data, subject ID numbers, and activities from the three files used to store information from one of the two original data sets (either test or training) and combines data for that set into a single tidy [data frame](http://stat.ethz.ch/R-manual/R-devel/library/base/html/data.frame.html).
* **getData() <- function(fileName)** </br> Gets the feature set and the raw data. Keep rows that end in **mean()** or **std()**, and edit the remaining headers to make them more readable.
* **getActivities() <- function(fileName)** </br> Read the Activity ID for each observation and convert this  to a meaningful English verb (e.g. WALKING, STANDING).
* **getSubjectIDs() <- function(fileName)** </br> Returns a list of SubjectIDs for each observation in the set.
* **getActivityLabels() <- function(filename)** </br> Returns an ordered list of sequential activity labels for use as a lookup table in other functions.
* **averageTidy <- function(mergedDF)** </br> Averages the data for each measurement in mergedDF for each combination of subject and activity.  Uses aggregate() to quickly compute means.
* **downloadData() <- function()** </br> Checks to see if a subdirectory with the original data exists in the current working directory. If not, the function downloads and unzips the original data.

####Potential Modifications
Feature names contain a leading **t** to designate that the variable is in the **time domain** and **f** to denote that it is in the **frequency domain**. These could be expanded if desired, although this was not done in this case to avoid variable names becoming too long and unwieldly.

### References
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. _International Workshop of Ambient Assisted Living (IWAAL 2012)_. Vitoria-Gasteiz, Spain. Dec 2012.

