---
title: "README"
author: "John Mastapeter"
date: "6/9/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The files for this project can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The goal of the project is to develop a code, run_analysis.R, that accomplishes the following
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

README.MD contains general information about the project

CODE_BOOK.MD explains the files and data used in the project and the final output variables

run_analysis.R is the r script that processes the files

new_tidy_set.txt is the final output