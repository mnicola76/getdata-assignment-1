library(reshape2)

## 1. Merge the training and the test sets to create one data set
## 1.1 Read and Append Text X, Test Y & Test Subject into a single dataframe
test_X <- read.table('UCI HAR Dataset/test/X_test.txt')
test_Y <- read.table('UCI HAR Dataset/test/y_test.txt')
test_subject <- read.table('UCI HAR Dataset/test/subject_test.txt')

test_complete <- cbind(test_subject, test_Y, test_X)

## 1.2 Read and Append Train X, Train Y & Train Subject into a single dataframe
train_X <- read.table('UCI HAR Dataset/train/X_train.txt')
train_Y <- read.table('UCI HAR Dataset/train/y_train.txt')
train_subject <- read.table('UCI HAR Dataset/train/subject_train.txt')

train_complete <- cbind(train_subject, train_Y, train_X)

## 1.3 Append dataframes above into 1 large dataframe containing all our data
data_complete <- rbind(test_complete, train_complete)

## 1.4 Read in the features list to use as the column headers
features <- read.table('UCI HAR Dataset/features.txt')
features <- as.vector(features[,2]) #cast to vector of character strings
features <- c('subjectid', 'activitycode', features) 
## Set features to be the column names of our complete dataframe
names(data_complete) <- features

## 2. Extract only the measurements on the mean and standard deviation for each measurement.
##    Subset just the columns containing "mean" or "std"
data_complete_subset <- 
    data_complete[, c(1:2, grep('mean|std', names(data_complete)))]

## 3. Uses descriptive activity names to name the activities in the data set
##    Read in activities list and merge to include descriptors 
activities <- read.table('UCI HAR Dataset/activity_labels.txt')
names(activities) <- c('activitycode', 'activitylabel')
tidy_data <- merge(activities, 
                   data_complete_subset, 
                   by.X='activitycode', 
                   by.Y='activitycode')
## No need for the activity code now.  Remove it.
tidy_data <- tidy_data[, !(names(tidy_data) %in% 'activitycode')]

## 4. Appropriately label the data set with descriptive variable names
##    make.names() function seems to dislike characters like '(', ')', '-'
##    Remove these non-alpha characters to ensure the variables are syntactically valid
names(tidy_data) <- make.names(gsub('[\\(|\\)|-]', '', names(tidy_data)))

## 5. Create a second, independent tidy data set with the average of each variable 
##    for each activity and each subject. 
##    Use melt and dcast to summarise and "tidy up" by 
##    averaging the values by subject, by activity
tidy_summary <- melt(tidy_data, id.vars=c("subjectid", "activitylabel"))
tidy_final <- dcast(tidy_summary, 
               subjectid + activitylabel ~ variable, 
               fun.aggregate=mean)

## Write out final tidy data set
write.table(tidy_final, 'tidy_dataset.txt', sep="\t", row.names = F)

write.table(names(tidy_final), 'data_cookbook.txt')

## Cleanup
rm(list=c('test_X', 
          'test_Y', 
          'test_subject',
          'train_X', 
          'train_Y', 
          'train_subject',
          'test_complete', 
          'train_complete',
          'features',
          'data_complete',
          'data_complete_subset',
          'activities',
          'tidy_data',
          'tidy_summary'))
