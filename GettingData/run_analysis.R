#SCRIPT: run_analysis.R

#This script reads the data for the Project assignment in the Getting and Cleaning course
#and output a tidy data set after processing the data.

#Loading the dplyr package.

  install.packages("dplyr")
  library(dplyr)
  
##Reading the txt files from the working directory of R into R
  
  features<-read.table("features.txt")
  x_test<-read.table("x_test.txt", na.strings="NA")
  y_test<-read.table("y_test.txt")
  y_train<-read.table("y_train.txt")
  x_train<-read.table("x_train.txt", na.strings="NA")
  subject_train<-read.table("subject_train.txt")
  subject_test<-read.table("subject_test.txt")
  
##Combining the test data and train data into one data set
  
  train<-cbind(x_train, y_train, subject_train)
  test<-cbind(x_test, y_test,subject_test)
  data<-rbind(train, test)
  
##Add features as titles for the columns
  
  features<-t(features)
  colnames(data)<-features[2, ]
  
##Selcting columns with "mean" or "std" while keeping subject
##and activity, but removing columns with "meanFreq".
  
  resa<-data[, 1:563]
  datamean<-select(resa, contains("mean"))
  datastd<-select(resa, contains("std"))
  datasum<-cbind(datastd, datamean, data[,562:563])
  datan<-select(datasum, -contains("meanFreq"))

#Renaming two columns and changing indication of activity from number to
#descriptive names.
  
  names(datan)[ncol(datan)-1]<-"Activities"
  names(datan)[ncol(datan)]<-"Person"

  datan$Activities=gsub(1, "WALKING", datan$Activities)
  datan$Activities=gsub(2, "WALKING_UPSTAIRS", datan$Activities)
  datan$Activities=gsub(3, "WALKING_DOWNSTAIRS", datan$Activities)
  datan$Activities=gsub(4, "SITTING", datan$Activities)
  datan$Activities=gsub(5, "STANDING", datan$Activities)
  datan$Activities=gsub(6, "LAYING", datan$Activities)
  
#Grouping the data after activity and person, and then creating the tidy data set.
#This data set has 180 rows and 75 columns. This is written to the working directory.
  
  datan_grupp<-group_by(datan, Activities, Person)
  
  tidy_data<-summarise_each(datan_grupp, funs(mean))

  write.table(tidy_data, file="tidy_data.txt", row.name=FALSE)