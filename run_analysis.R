## function to split element in each row into list, read in x 
## is a vector
mysplit <- function(x) {
  l <- length(x)
  y <- c()
  for(i in 1:l) {
    temp <- strsplit(x[i],"\\ ")
    temp <- unlist(temp)
    temp <- temp[temp != ""]
    y <- rbind(y,temp)
  }
  return(y)
}

# read in set for training data
set <- read.table("train/X_train.txt",sep="\t",colClass="character",
                  col.names="setTrain")
set <- set[,1]

# use mysplit function to split set data
setTrain <- mysplit(set)
colnames(setTrain) <- as.character(1:561)
setTrain <- as.data.frame(setTrain)
lableTrain <- read.table("train/y_train.txt",sep="\t",colClass="factor",
                         col.names="lable")
setTrain <- cbind(setTrain,lableTrain)

subjectTrain <- read.table("train/subject_train.txt",sep="\t",colClass="factor",col.names="subject")
setTrain <- cbind(setTrain,subjectTrain)
# read in set for test data
set <- read.table("test/X_test.txt",sep="\t",colClass="character",
                  col.names="setTest")
set <- set[,1]

# use mysplit funciton to split set data
setTest <- mysplit(set)
colnames(setTest) <- as.character(1:561)
setTest <- as.data.frame(setTest)
lableTest <- read.table("test/y_test.txt",sep="\t",colClass="factor",
                                                col.names="lable")
setTest <- cbind(setTest,lableTest)
subjectTest<- read.table("test/subject_test.txt",sep="\t",colClass="factor",col.names="subject")
setTest <- cbind(setTest,subjectTest)
# merge test and train data
library(plyr)
mergedData <- join(setTrain,setTest,type="full")

# extract only the mean and standard deviation for each measurement
myCleanDataSet <- mergedData[,c(1:6,41:46,81:86,121:126,161:166,201,
                                202,214,215,227,228,240,241,253,254,
                                266:271,345:350,424:429,503:504,
                                516:517,529:530,542:543,562,563)]

first <- myCleanDataSet[myCleanDataSet[,67] == 1,]
second <- myCleanDataSet[myCleanDataSet[,67] == 2,]
third <- myCleanDataSet[myCleanDataSet[,67] == 3,]
fourth <- myCleanDataSet[myCleanDataSet[,67] == 4,]
fifth <- myCleanDataSet[myCleanDataSet[,67] == 5,]
sixth<- myCleanDataSet[myCleanDataSet[,67] == 6,]
myCleanDataSet[myCleanDataSet[,67] == 1,69] <- rep("WALKING",nrow(first))
myCleanDataSet[myCleanDataSet[,67] == 2 ,69] <- rep("WALKING UPSTAIRS",nrow(second))
myCleanDataSet[myCleanDataSet[,67] == 3,69] <- rep("WALKING DOWNSTAIRS",nrow(third))
myCleanDataSet[myCleanDataSet[,67] == 4,69] <- rep("SITTING",nrow(fourth))
myCleanDataSet[myCleanDataSet[,67] == 5,69] <- rep("STANDING",nrow(fifth))
myCleanDataSet[myCleanDataSet[,67] == 6,69] <- rep("LAYING",nrow(sixth))

colnames(myCleanDataSet) <- c("Body Acceleration x mean time",
                               "Body Acceleration y mean time",
                               "Body Acceleration z mean time",
                               "Body Acceleration x std time",
                               "Body Acceleration y std time",
                               "Body Acceleration z std time",
                               "Gravity Acceleration x mean time",
                               "Gravity Acceleration y mean time",
                               "Gravity Acceleration z mean time",
                               "Gravity Acceleration x std time",
                               "Gravity Acceleration y std time",
                               "Gravity Acceleration z std time",
                               "Body Acceleration Jerk Signal x mean time",
                               "Body Acceleration Jerk Signal y mean time",
                               "Body Acceleration Jerk Signal z mean time",
                               "Body Acceleration Jerk Signal x std time",
                               "Body Acceleration Jerk Signal y std time",
                               "Body Acceleration Jerk Signal z std time",
                               "Body Gyroscope x mean time",
                               "Body Gyroscope y mean time",
                               "Body Gyroscope z mean time",
                               "Body Gyroscope x std time",
                               "Body Gyroscope y std time",
                               "Body Gyroscope z std time",
                               "Body Gyroscope Jerk Signal x mean time",
                               "Body Gyroscope Jerk Signal y mean time",
                               "Body Gyroscope Jerk Signal z mean time",
                               "Body Gyroscope Jerk Signal x std time",
                               "Body Gyroscope Jerk Signal y std time",
                               "Body Gyroscope Jerk Signal z std time",
                               "Body Acceleration Magnitude mean time",
                               "Body Acceleration Magnitude std time",
                               "Gravity Acceleration Magnitude mean time",
                               "Gravity Acceleration Magnitude std time",
                               "Body Acceleration Jerk Signal Magnitude mean time",
                               "Body Acceleration Jerk Signal Maginitude std time",
                               "Body Gyroscope Magnitude mean time",
                               "Body Gyroscope Magnitude std time",
                               "Body Gyroscope Jerk Signal Magnitude mean time",
                               "Body Gyroscope Jerk Signal Magnitude std time",
                               "Body Acceleration x mean frequency",
                               "Body Acceleration y mean frequency",
                               "Body Acceleration z mean frequency",
                               "Body Acceleration x std frequency",
                               "Body Acceleration y std frequency",
                               "Body Acceleration z std frequency",
                               "Body Acceleration Jerk Signal x mean frequency",
                               "Body Acceleration Jerk Signal y mean frequency",
                               "Body Acceleration Jerk Signal z mean frequency",
                               "Body Acceleration Jerk Signal x std frequency",
                               "Body Acceleration Jerk Signal y std frequency",
                               "Body Acceleration Jerk Signal z std frequency",
                               "Body Gyroscope x mean frequency",
                               "Body Gyroscope y mean frequency",
                               "Body Gyroscope z mean frequency",
                               "Body Gyroscope x std frequency",
                               "Body Gyroscope y std frequency",
                               "Body Gyroscope z std frequency",
                               "Body Acceleration Magnitude mean frequency",
                               "Body Acceleration Magnitude std frequency",
                               "Body Acceleration Jerk Signal Magnitude mean frequency",
                               "Body Acceleration Jerk Signal Magnitude std frequency",
                               "Body Gyroscope Magnitude mean frequency",
                               "Body Gyroscope Magnitude std frequency",
                               "Body Gyroscope Jerk Signal Magnitude mean frequency",
                               "Body Gyroscope Jerk Siganl Magnitude std frequency",
                               "lable","subject","activity"
                               )
library(reshape2)
newData <- melt(myCleanDataSet,id=c("subject","activity"))
newData$value <- as.numeric(newData$value)
finalData <- ddply(newData,c("subject","activity","variable"),summarise,mean=mean(value))

write.table(finalData,"finalData.txt",row.name=FALSE)
