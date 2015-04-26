library(plyr)
setwd("B:/Coursera/Getting&CleaningData/CourseProject/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/")
#1. Merges the training and the test sets to create one data set
xTrainData <- read.table("train/X_train.txt")
yTrainData <- read.table("train/y_train.txt")
subjectTrainData <- read.table("train/subject_train.txt")
xTestData <- read.table("test/X_test.txt")
yTestData <- read.table("test/y_test.txt")
subjectTestData <- read.table("test/subject_test.txt")
xData <- rbind(xTrainData, xTestData)
yData <- rbind(yTrainData, yTestData)
subjectData <- rbind(subjectTrainData, subjectTestData)
#2. Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table("features.txt")
meanAndStdFeatures <- grep("-(mean|std)\\(\\)", features[, 2])
xData <- xData[, meanAndStdFeatures]
names(xData) <- features[meanAndStdFeatures, 2]
#3. Use descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
yData[, 1] <- activities[yData[, 1], 2]
names(yData) <- "activity"
#4. Appropriately label the data set with descriptive variable names
names(subjectData) <- "subject"
allData <- cbind(xData, yData, subjectData)
#5. Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
averagesData <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averagesData, "tidy.txt", row.name=FALSE)
