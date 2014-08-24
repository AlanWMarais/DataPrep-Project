DataPrep-Project
================

Project for the Coursera module on Getting and Cleaning data


The run_analysis.R code reads and summarizes the UCI HAR dataset.

It expects to find the dataset in a project working directory

1. It reads the training data sets
2. It reads the test data sets
3. The 2 datasets are combined using the rbind function
4. ONly features that are mean() or std() measurements are selected using the grep and 
text matching on the feature names. Matching had to be done to make sure that only means are extracted and not meanfreq.
5. All the datasets are combined into a wide dataset using cbind
6. To make it easier to calculate averages of all measures the dataset is transformed into a narrow dataset using the melt function
7. The summarized averages are calculated using ddply function
8. The summarized data is turned into a tidy dataset by using the dcast function to change the shape back into a wide data set with one row for each combination of subject and activity
9. The resulting data frame with 180 rows is finally outputted as a text file.
