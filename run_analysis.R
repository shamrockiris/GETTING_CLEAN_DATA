# read in set for training data
setTrain <- read.table("train/X_train.txt",colClass="character",header=FALSE)
lableTrain <- read.table("train/y_train.txt",colClass="factor",col.names="lable")
setTrain <- cbind(setTrain,lableTrain)
subjectTrain <- read.table("train/subject_train.txt",colClass="factor",col.names="subject")
setTrain <- cbind(setTrain,subjectTrain)

# read in set for test data
setTest <- read.table("test/X_test.txt",colClass="character",header=FALSE)              
lableTest <- read.table("test/y_test.txt",colClass="factor",col.names="lable")
setTest <- cbind(setTest,lableTest)
subjectTest<- read.table("test/subject_test.txt",colClass="factor",col.names="subject")
setTest <- cbind(setTest,subjectTest)

# merge test and train data
library(plyr)
mergedData <- join(setTrain,setTest,type="full")

# extract only the mean and standard deviation for each measurement
feature <- read.table("features.txt",header=FALSE,colClass="character")
colnames(mergedData) <- c(feature[,2],"lable","subject")
good <- grep("mean|std|lable|subject",colnames(mergedData))
myCleanDataSet <- mergedData[,good]

first <- grep()
myCleanDataSet$lable <- gsub("1","WALKING",myCleanDataSet$lable)
myCleanDataSet$lable <- gsub("2","WALKING UPSTAIRS",myCleanDataSet$lable)
myCleanDataSet$lable <- gsub("3","WALKING DOWNSTAIRS",myCleanDataSet$lable)
myCleanDataSet$lable <- gsub("4","SITTING",myCleanDataSet$lable)
myCleanDataSet$lable <- gsub("5","STANDING",myCleanDataSet$lable)
myCleanDataSet$lable <- gsub("6","LAYING",myCleanDataSet$lable)

library(reshape2)
newData <- melt(myCleanDataSet,id=c("subject","lable"))
newData$value <- as.numeric(newData$value)
finalData <- ddply(newData,c("subject","lable","variable"),summarise,mean=mean(value))

write.table(finalData,"finalData.txt",row.name=FALSE)
