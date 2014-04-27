#Introduction
Greetings! This is a repository for a peer-reviewed assignment for "Getting and Cleaning Data" course on Coursera. It contains the run_analysis.r script generating the required tidy and clean data set

#How It Works
Please see instructions below. In order to function properly it should be placed in the same directory with extracted dataset from the assingment. It is assumed that you haven't renamed it and all the data is stored in "UCI HAR Dataset" folder.

##Initialization
The script uses data.table module. Links to all data files, as well as files with category names are specified in this section.

##Data Import
Datasets are imported in data.tables. Column names are assigned as per the file with variables list. Subject IDs and activity IDs are injected as columns. Training and test data sets are binded together, as they have the same column names after the import.

##Selection of Categories for Analysis
Two vectors are created holding the information about columns with:
A. Grouping variables, such as "subject" and "activity"
B. Selected variables, which are according to assignment are limited to mean() and std() measurements. Those are selected using regular expression.

##Analysis and Output
The mean values for each of the selected variable are calculated for each of the grouped variables. The combination of data.table and lapply() functions is used for this purpose. Summarizing, the averaging is done for multiple columns using two columns for categories. The final dataset is saved to the file and printed to the screen.