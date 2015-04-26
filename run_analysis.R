library(plyr)

##reading files
train<-read.table("train/X_train.txt")
test<-read.table("test/X_test.txt")
feature<-read.table("features.txt")
actLabel<-read.table("activity_labels.txt")
train_y<-read.table("train/y_train.txt")
test_y<-read.table("test/y_test.txt")
sub_train<-read.table("train/subject_train.txt")
sub_test<-read.table("test/subject_test.txt")

#merging data sets
data<-merge(train,test,all=T)

#selecting feature set having mean and std of measurements
ind<-which(grepl("mean",feature$V2) & !grepl("meanFreq",feature$V2) | grepl("std",feature$V2,ignore.case=T))

#extracting only the mean and std of measurements
data<-data[,ind]

#labelling activities in data set
data$activity<-I(actLabel$V2[c(train_y$V1,test_y$V1)])

#creating descriptive feature variables
### first to remove paranthesis
featureNames<-sapply(feature$V2[ind],
                     function(x)(gsub("\\s*\\(\\)","",as.character(x))))
##replacing "BodyBody" with "Body"
featureNames<-sapply(featureNames,
                     function(x)(gsub("BodyBody","Body",as.character(x))))
###removing "-" and making camelCase variable names
###didn't go with all lower case variable names as they are harder to read in this case
camelCase<-function(x){
  cap<-function(x){
    paste(toupper(substring(x,1,1)),substring(x,2,nchar(x)),sep="")
  }
  sapply(strsplit(as.character(x),"-"),function(x)paste(cap(x),collapse=""))
}
x<-sapply(featureNames,function(x) paste(camelCase(x)))
xx<-sapply(x,function(x)paste(tolower(substring(x,1,1)),substring(x,2,nchar(x)),sep=""))

colnames(data)<-c(xx,"activity")

#adding subject ID for each window
data$subject<-c(unlist(sub_train),unlist(sub_test))

##creating average of each variable for each subject and activity
dt<-ddply(data,.(activity,subject),function(df)colMeans(df[,1:length(ind)]))

write.table(dt,"tidyData.txt",sep="\t",row.names=F,quote=F)