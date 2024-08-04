library(dplyr)

# Load the data sets
#   Load features names
features <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = FALSE)
feature_names <- features$V2
#   Clean features names to remove special characters
feature_names <- lapply(feature_names, function(x) gsub("-","_", x))
feature_names <- lapply(feature_names, function(x) gsub(",","_", x))
feature_names <- lapply(feature_names, function(x) gsub("\\(","", x))
feature_names <- lapply(feature_names, function(x) gsub("\\)","", x))
#   Load descriptive activity names
activity_names <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)

#   Load the test sets
x_test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
colnames(x_test) <- feature_names
x_test_reduced <- x_test %>% select(contains("mean") | contains("std"))
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
y_test <- transform(y_test,V1 = activity_names[V1,2])
subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)

#   Load the train sets
x_train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
colnames(x_train) <- feature_names
x_train_reduced <- x_train %>% select(contains("mean") | contains("std"))
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
y_train <- transform(y_train,V1 = activity_names[V1,2])
subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)

# Merge the data sets
#   Add subject to each set
x_train_reduced$subject <- subject_train$V1
x_test_reduced$subject <- subject_test$V1
#   Add labels to each set
x_train_reduced$activity <- y_train$V1
x_test_reduced$activity <- y_test$V1
#   Append data sets
final_data <- rbind(x_test_reduced,x_train_reduced)

# Save the data set
write.table(final_data, "combined_data.txt", row.names = FALSE)

# Create average for each subject and each activity
summary_data <- final_data %>% group_by(subject, activity) %>%
    summarize(across(ends_with("std") | ends_with("mean"), mean))
write.table(summary_data, "summary_data.txt",row.names = F)