HOW IT WORKS
===================
+ Before using this script, you need to set working directory to the "UCI HAR Dataset". 
+ After run this script you will get an output txt file named "finalData.txt" in the same workdirectory. 
+ Two packaged need to be downloaded and installed before running this script. Packege "plyr" and "reshape2".

There is a function defined in this script: mysplit. Because the data read in for every obervation, data are saved in one row. Before any furthur action, data in each row need to be splitted. 

CODE BOOK
==========
### set: set data container when first read in
### lableTest: lable of activity for test data
### subjectTest: subject for test data
### setTest: combined data for test set with each observation's lable and subject
### lableTrain: lable of activity for training data
### subjectTrain: subject for training data
### setTrain: combined data for train set with each observation's lable and subject
### mergedData: dataset after merged test set and train set
### mycleanData: dataset with only mean and standard value for each measurement
### first: subset of data for activity "WALKING"
### second: subset of data for activity "WALKING UPSTAIRS"
### third: subset of data for activity "WALKING DOWNSTAIRS"
### fourth: subset of data for activity "SITTING"
### fifth: subset of data for activity "STANDING"
### sixth: subset of data for activity "LAYING"
### newData: melt myCleanData into new dataset with all measurement under variable.
### finalData: dataset give average value for each measurement for each subject and activity
