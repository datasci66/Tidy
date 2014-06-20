## load features file for use as column names
f<-read.csv(file="features.txt",sep=" ", col.names=c("featureID","feature"),header=FALSE)

## load activity labels file
a<- read.csv(file="activity_labels.txt",sep=" ", col.names=c("activityID","activity"),header=FALSE)

## ---------------------------------
## load training set files and merge
## ---------------------------------

## load the subject file 
trn_subj<-read.csv(file="./train/subject_train.txt",sep=" ", col.names=c("subject"),header=FALSE)

## load the activities file
trn_act<-read.csv(file="./train/y_train.txt",sep=" ", col.names=c("activityID"),header=FALSE)
     
## load the features data file
trn<-read.table(file="./train/x_train.txt",col.names=f$feature)

## add the activities to the training data
trn<-cbind(trn_act,trn)

## add the subjects to the training data
trn<-cbind(trn_subj,trn)

## -----------------------------
## load test set files and merge
## -----------------------------

## load the subject file 
test_subj<-read.csv(file="./test/subject_test.txt",sep=" ", col.names=c("subject"),header=FALSE)
     
## load the activities file
test_act<-read.csv(file="./test/y_test.txt",sep=" ", col.names=c("activityID"),header=FALSE)
     
## load the features data file
test<-read.table(file="./test/x_test.txt",col.names=f$feature)

## add the activities to the training data
test<-cbind(test_act,test)

## add the subjects to the training data
test<-cbind(test_subj,test)

## merge test and training data
data<-rbind(test,trn)

## reduce the set to only the columns (variables) we want (mean and std)
vars<-names(data)
v_index<-c(grep("mean",vars),grep("std",vars))
v_index<-c(1,2,v_index) ## add back columns for activity and subject
data<-data[,v_index]

## remove "meanFreq"
vars<-names(data)
nok<-grepl("Freq",vars)
v_index<-vars[!nok]
data<-data[,v_index]
v_names<-names(data)

## -----------------------------
## create tidy data set
## -----------------------------

## melt the data set so that each measure is a variable
dataMelt <-melt(data,id=c("activityID","subject"),measure.vars=v_names)

## add activity labels to data set
dataMelt<-merge(a,dataMelt,b.x="activityID",by.y="activityID",all=TRUE)

## remove activityID column
dataMelt<-dataMelt[,c(2:ncol(dataMelt))]
     
## get the mean for each variable by subject and activity, and re-pivot
tidy<-dcast(dataMelt,subject + activity ~ variable,mean)
tidy<-tidy[c(1,2,5:70)]

## order the data by subject, then by activity
tidy<-tidy[order(tidy$subject,tidy$activity),]

## write data to a file
write.csv(tidy,file="tidy.csv",row.names=FALSE)

