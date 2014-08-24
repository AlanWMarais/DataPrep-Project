library(reshape2)
library(plyr)
setwd("C:/Coursera R/DataPrep project/getdata-projectfiles-UCI HAR Dataset")

# Read in labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"")
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")

# Read in Train data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")

# Read in Test data
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")

# Combine Train and test into Data 
y_data <- rbind(y_train,y_test)
subject_data <- rbind(subject_train,subject_test)
X_data <- rbind(X_train,X_test)

# find the features with only mean() and std() variables
selected_features<- features[grep("mean[(]|std[(]", features$V2),]

# extract only mean and std dev measurements
X_extract <- X_data[,selected_features$V1]

#Allocate descriptive names to datasets
colnames(y_data) <- c("activity_no")
colnames(activity_labels) <- c("activity_no","activity")
colnames(subject_data) <- c("subject")
colnames(X_extract) <- selected_features$V2

#combine into wide dataset
widedata <- cbind(subject_data,y_data,X_extract)

#melt into narrow dataset
narrowdata <- melt(widedata, id.vars=c("subject","activity_no"))

#average the measures
avedata<- ddply(narrowdata,.(subject,activity_no,variable),summarize,mean_value=mean(value))

#turn into tidy dataset
tidydata <- merge(activity_labels,dcast(avedata,subject + activity_no ~ variable))

#output tidy dataset
write.table(tidydata,"C:/Coursera R/DataPrep project/tidydata.txt",row.names=FALSE)
