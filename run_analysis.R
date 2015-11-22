# 1.Merges the training and the test sets to create one data set.

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/data.zip")
unzip(zipfile="./data/data.zip",exdir="./data")

FeaturesNames <- read.table("./data/UCI HAR Dataset/features.txt",head=FALSE)

ActivityTest  <- read.table("./data/UCI HAR Dataset/test/Y_test.txt",header = FALSE)
ActivityTrain  <- read.table("./data/UCI HAR Dataset/train/Y_train.txt",header = FALSE)

SubjectTest  <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = FALSE)
SubjectTrain  <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = FALSE)

FeaturesTest  <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE)
FeaturesTrain  <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE)

Activity <- rbind(ActivityTest,ActivityTrain)
Subject <- rbind(SubjectTest,SubjectTrain)
Features <- rbind(FeaturesTest,FeaturesTrain)

ActivityTest <- NULL
ActivityTrain <- NULL
SubjectTest  <- NULL
SubjectTrain <- NULL
FeaturesTest  <- NULL
FeaturesTrain <- NULL

names(Activity) <- c("Activity")
names(Subject) <- c("Subject")
names(Features) <- FeaturesNames[,2]

CombinedData <- cbind(Subject,Activity,Features)

Activity <- NULL
Subject <- NULL
Features  <- NULL
FeaturesNames  <- NULL

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

MeanSTDcolnames <- colnames(CombinedData[grepl("mean|std",colnames(CombinedData))])
CombinedData <- CombinedData[,c("Subject","Activity",MeanSTDcolnames)]


# 3.Uses descriptive activity names to name the activities in the data set

ActivityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",header = FALSE)


CombinedData <- merge(CombinedData,ActivityLabels,by.x = "Activity",by.y = "V1")
CombinedData$Activity <- CombinedData$V2
CombinedData$V2 <- NULL
ActivityLabels  <- NULL

# 4.Appropriately labels the data set with descriptive variable names. 

NewColNames <- names(CombinedData)
NewColNames <- gsub('\\(|\\)',"",NewColNames)
NewColNames <- gsub("Acc", "Acceleration ", NewColNames)
NewColNames <- gsub("Mag", "Magnitude ", NewColNames)
NewColNames <- gsub("Gyro", "Gyroscope ", NewColNames)
NewColNames <- gsub("Gravity", "Gravity ", NewColNames)
NewColNames <- gsub("^t", "Time ", NewColNames)
NewColNames <- gsub("^f", "Frequency ", NewColNames)
NewColNames <- gsub("BodyBody", "Body", NewColNames)
NewColNames <- gsub("Body", "Body ", NewColNames)
NewColNames <- gsub("Jerk", "Jerk ", NewColNames)
NewColNames <- gsub("-mean", "- Mean ", NewColNames)
NewColNames <- gsub("-std", "- STD.VAR ", NewColNames)
names(CombinedData) <- NewColNames

# 5.From the data set in step 4, creates a second, independent tidy data set with 
#   the average of each variable for each activity and each subject.

TidyAvgData <- aggregate(.~Subject+Activity,CombinedData,mean)
write.table(TidyAvgData, file = "tidy.txt", row.names = FALSE)

