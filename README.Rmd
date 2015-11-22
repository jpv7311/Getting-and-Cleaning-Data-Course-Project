---
title: "Getting and Cleaning Data - Course Project"
date: "November 22, 2015"
output: html_document
---


**General notes**

This repository covers processing of data of human activity recognition based on smartfone collected data. Original (preprocessed) data is avialable under URL:  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
The full descriptiois available under URL:  
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The goal of the processing was to create a tidy dataset containing accordin to following points
- Merge the training and the test sets to create one data set.  
- Extract only the measurements on the mean and standard deviation for each measurement  
- Use descriptive activity names to name the activities in the data set  
- Appropriately label the data set with descriptive variable names.  
- Create a second, independent tidy data set with the average of each variable for each activity and each subject.  

**Files**

- run_analysis.R - the R code responsible for processing data
- tidy.txt - the txt file with processed data - output of above R file
- CodeBook.md - The markdown file with all desrription how data was processed. There are also relevant html and Rmd files.
- README.md - this file with explanation what files are in repository. There are also relevant html and Rmd files.
