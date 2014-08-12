## Step 1. Merges the training and the test sets to create one data set

trainData <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt") # 7352*561
trainLabel <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

testData <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt") # 2947*561
testLabel <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

joinData <- rbind(trainData, testData) # 10299*561
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)


## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
meanStdIndex <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinData <- joinData[, meanStdIndex] # 10299*66

# make the feature names better suited for R with some substitutions
names(joinData) <- gsub("mean", "Mean", features[meanStdIndex, 2])
names(joinData) <- gsub("std", "Std", names(joinData))
names(joinData) <- gsub("-", "", names(joinData))
names(joinData) <- gsub("\\(\\)", "", names(joinData))


## Step 3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"


## Step 4. Appropriately labels the data set with descriptive activity names
names(joinSubject) <- "subject"
cleanData <- cbind(joinSubject, joinLabel, joinData)

# Write the 1st dataset
write.table(cleanData, "CleanData.txt")


## Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

subjects <- sort(unique(joinSubject[, 1]))
activities <- sort(unique(activity[, 2]))
DataWithMeans <- matrix(NA, nrow = length(subjects)*length(activities), ncol = dim(cleanData)[2])
DataWithMeans <- as.data.frame(DataWithMeans)
colnames(DataWithMeans) <- colnames(cleanData)

count <- 1
for (subj in subjects) {
        for (act in activities) {
                DataWithMeans[count, 1] <- subj
                DataWithMeans[count, 2] <- act
                logic1 <- subj == cleanData$subject
                logic2 <- act == cleanData$activity
                DataWithMeans[count, 3:dim(cleanData)[2]] <- colMeans(cleanData[logic1&logic2, 3:dim(cleanData)[2]])
                count <- count + 1
               
        }
}

write.table(DataWithMeans, file="DataWithMeans.txt", row.names = FALSE )


# data <- read.table("./DataWithMeans.txt")
# data
