README

This is the README file for the Project assignment in the Getting and Cleaning Data course.

The output from the project is 1) tidy_data.txt data set. 2) run_analysis.R script. 3) codebook.txt 4) README.md file (this file)

The script takes the input data and outputs the tidy data set. The content in the tidy data set is explained in the code book, and this file is a generel explanation. The original data is found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data summarizes readings from mobile phones regarding position, speed etc. The data is collected from 30 persons in six different activity modes like sitting, walking etc. (See codebook for details.) The original data has 10299 observations and there are 563 data points taken from each observation.

The script processes this data. First all parameters that do not have "mean" or "std" in the column name are discarded. This leaves 73 data points for each observation plus two columns for identification of person and activity. Then the data is grouped by person and activity and the mean value for each data point is calculated. This leaves a data set with 180 rows (30 persons x 6 activity modes) and a total of 75 columns.