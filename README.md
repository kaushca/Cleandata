How to use the scripts in this data repository
========================================================

This data reporsitory carries answers to course project in Getting and cleaning data course offered  by Coursera.

Running run_analysis.R
--------------------------------------------------------
1. Data set
Data can be downloaded from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Please decompress the file before proceeding.

2. Working directory
The decompressed data file (default name: UCI HAR Dataset) should be set as the working directory by using the following command in R.
```{r}
setwd("file destination")
```

3. Required R packages
  * plyr

Step by step guide to creating tidy data set
----------------------------------------------

1. All the required data files are read from the current working directory.
2. Train and test data sets from X_train.txt and X_test.txt are merged.
3. Features containing mean and standard deviation measurements from features.txt file are extracted.
4. Merged data set from step 2 is filtered to contain only the extracted features from step 3.
5. A new column is added to the data set containing the activity labels from ctivity_labels.txt.
6. Descriptive feature variable names are created for the feature set in step 3.
  * All paranthesis in names are deleted
  * Features having text "BodyBody" are replaced with "Body"
  * Variable names are formatted to have camelCase variable names. (Although it is recommended to have all lower case letters, due to the long nature of the variable  name I used camelCase format)
  * "-" is removed from variable names
7. Data set from step 5 is updated with descriptive variable names created by step 6.
8. Subject ID from y_train.txt and y_test.txt are added to data set.
9. A new tidy data set containing average for each feature for each subject and activity is created.
10. Tidy data set is saved in working directory under the name "tidyData.txt"