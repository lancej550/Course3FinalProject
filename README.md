# Course3FinalProject
 Final project for Coursera Course


This script first loads the feature names removes the special characters ",-()". These feature names become the column names for the X data sets.

The descriptive activity names are loaded in.

The X, y, and subject data sets are loaded for both train and test. X data sets are reduced down to only the columns which contain "mean" or "std" in their names. The numerical labels in the y data sets are replaced with the descriptive activity names that were loaded in. The subjects and activity labels are added as new columns to the reduced X data sets. 

The test and train data frames are appended to create a combined data frame. This is saved to "combined_data.txt", with headers.

This data is grouped by subject and activity and summarized by taking the mean for each column. This summary data frame is saved as "summary_data.txt", with headers.

