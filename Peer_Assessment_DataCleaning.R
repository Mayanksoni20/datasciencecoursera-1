#### adding libraries
library(data.table)
### check that the current directory contains the desired data file
if(!is.element("UCI HAR Dataset",list.files()))
   print('Cannot find data file.')

#### getting useful folder paths
base_dir=getwd()
measurements_dir=paste0(base_dir,'/UCI HAR Dataset')
train_dir=paste0(base_dir,'/UCI HAR Dataset/train')
test_dir=paste0(base_dir,'/UCI HAR Dataset/test')

### setting up the data table

### getting list of measurements (i.e., tBodyAcc-X)
setwd(measurements_dir)
measurements=array(read.table('features.txt')[,2])
### getting indices for desired measurements (mean and std)
mean_ind=vector()
std_ind=vector()
for(x in seq(1,length(measurements))){
  if(any(grep('mean()',measurements[x],fixed=T))){
    mean_ind=c(mean_ind,x)
  }else if (any(grep('std()',measurements[x],fixed=T))){
    std_ind=c(std_ind,x)}}

#### getting list of activities (i.e., walking)
setwd(measurements_dir)
activity=fread('activity_labels.txt')
activity_labels=activity$V2
activity_ind=activity$V1

#### getting list of subjects
setwd(train_dir)
train_subject=read.table('subject_train.txt') ## subjects from training set
setwd(test_dir)
test_subject=read.table('subject_test.txt') ## subject from testing set
subjects=sort(unique(c(t(train_subject),t(test_subject)))) ## total number of subjects


##### setting up some preliminary columns
subject_column=sort(rep(subjects,length(activity_labels)))
activity_column=rep(activity_labels,length(subjects))
#### getting data from training set
setwd(train_dir)

train_subject=read.table('subject_train.txt') ## subject data
tp=unique(person)

