
library(tidyverse)

# Importing files -------------------------------------------------------

filename <- "Coursera_DS3_Final.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method="curl")
}  

# Checking folder 
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}



# Loading datasets  -------------------------------------------------------

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")


# Renaming variables

colnames(X_test) <- features$V2
Y_test <- rename(Y_test, code = V1)
subject_test <- rename(subject_test, subject = V1)

colnames(X_train) <- features$V2
Y_train <- rename(Y_train, code = V1)
subject_train <- rename(subject_train, subject = V1)

activity_labels <- rename(activity_labels, activity = V2)

# 1. Merges the training and the test sets to create one data set

X_total <- rbind(X_test, X_train)
Y_total <- rbind(Y_test, Y_train)
subject <- rbind(subject_test, subject_train)

mergedData <- cbind(Y_total, X_total, subject)

  #Removing unnecessary datasets

rm(X_test, Y_test, subject_test, X_train, Y_train, subject_train,
   Y_total, X_total, subject)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Tdata <- mergedData %>% 
        select(subject, code, contains("mean"), contains("std")) %>% 
        select(-c(starts_with("angle")))


# 3. Uses descriptive activity names to name the activities in the data set

Tdata$code <- activity_labels[Tdata$code, 2]

# 4. Appropriately labels the data set with descriptive variable names.

names(Tdata)[1] <- "Subject"
names(Tdata)[2] <- "Activity"
names(Tdata)<-gsub("Acc", "Accelerometer", names(Tdata))
names(Tdata)<-gsub("Gyro", "Gyroscope", names(Tdata))
names(Tdata)<-gsub("BodyBody", "Body", names(Tdata))
names(Tdata)<-gsub("Mag", "Magnitude", names(Tdata))
names(Tdata)<-gsub("^t", "Time", names(Tdata))
names(Tdata)<-gsub("^f", "Frequency", names(Tdata))
names(Tdata)<-gsub("tBody", "TimeBody", names(Tdata))
names(Tdata)<-gsub("-freq()", "Frequency", names(Tdata), ignore.case = TRUE)

# 5.  From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

FinalDataSet <- Tdata %>% 
                        group_by(Activity, Subject) %>% 
                        summarise_all(funs(mean))

write.table(FinalDataSet, "Tidydata.txt", row.name=FALSE)






