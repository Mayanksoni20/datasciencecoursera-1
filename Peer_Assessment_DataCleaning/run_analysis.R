### I am assuming that the folder /UCI HAR Dataset was downloaded, unzipped, and
### stored locally. 

### check that the current directory contains the desired data file
if(!is.element("UCI HAR Dataset",list.files()))
   print('Cannot find data file.')

#### getting the folder paths for testing and training data
base_dir=getwd()
features_dir=paste0(base_dir,'/UCI HAR Dataset')
train_dir=paste0(base_dir,'/UCI HAR Dataset/train')  
test_dir=paste0(base_dir,'/UCI HAR Dataset/test')


### getting list of features (i.e., tBodyAcc-X)
setwd(features_dir)
features=array(read.table('features.txt')[,2])

### getting indices for desired mean and std features (ones with 'mean()' and 'std()' in the descriptor)
mean_ind=vector()
std_ind=vector()
for(x in seq(1,length(features))){
  if(any(grep('mean()',features[x],fixed=T))){
    mean_ind=c(mean_ind,x)
  }else if (any(grep('std()',features[x],fixed=T))){
    std_ind=c(std_ind,x)}}

### interleaving indices so that mean() is next to its corresponding std()
all_ind=numeric(length(c(mean_ind,std_ind)))
all_ind[seq(1,length(all_ind),2)]=mean_ind
all_ind[which(all_ind==0)]=std_ind

#### This function pulls out desired columns from a given table (e.g., 'X_train.txt'), 
#### and builds a new data.frame with those columns
get_desired_features=function(file_x,columns){
    ###file_x should take the form of 'X_train.txt'
    ### columns should be a vector of the column numbers: i.e, c(1,2,3,4) would allow you to take the first 4 columns
    which_cols=rep('NULL',length(features));    which_cols[columns]='numeric'
    new_table=read.table(file_x,colClasses=which_cols)  ### selectively reading out desired columns
    
    colnames(new_table)=features[columns]  #### appending column names 
    new_table
}

#### getting list of activities (i.e., walking)
setwd(features_dir)
activity=read.table('activity_labels.txt')

### function to convert activity numbers (1 through 6) into activity labels ('WALKING', 'SITTING', etc)
activity_labeling=function(activity_list,activity_dictionary){
    for(x in seq(nrow(activity_dictionary))){
        activity_list[activity_list %in% activity_dictionary[x,1]]=as.character(activity_dictionary[x,2])
    }
    activity_list
}

#### getting training data
setwd(train_dir)
train_subject=read.table('subject_train.txt') ## 1. subjects from training set
train_activity=activity_labeling(read.table('y_train.txt')[,1],activity)   ### 2. activity labels from training set
train_activity_index=read.table('y_train.txt')[,1]   ### 3. activity indices from training set
train_data=get_desired_features('X_train.txt',all_ind)  #### 4. mean() and std() values from training set
train_all=cbind(train_subject,train_activity,train_activity_index,train_data)   ### combining 1-4
colnames(train_all)=c(c('SubjectID','Activity','ActivityID'),colnames(train_data))  #### assigning column names

#### getting testing data
setwd(test_dir)
test_subject=read.table('subject_test.txt') ## 1. subjects from testing set
test_activity=activity_labeling(read.table('y_test.txt')[,1],activity)   ### 2. activity labels
test_activity_index=read.table('y_test.txt')[,1]   ### 3. activity indices 
test_data=get_desired_features('X_test.txt',all_ind)  #### 4. mean() and std() values 
test_all=cbind(test_subject,test_activity,test_activity_index,test_data)   ### combining 1-4
colnames(test_all)=c(c('SubjectID','Activity','ActivityID'),colnames(test_data))  #### assigning column names

#### combining training and testing sets 
all_data=rbind(test_all,train_all)

### computing averages across subjects and activity types
tidy_data_set=vector()
for(sb in sort(unique(all_data$SubjectID))){  ### loop through each subject
    for(ac in sort(unique(activity[,1]))){  ### loop through each activity
        select_data=all_data[all_data$SubjectID==sb&all_data$ActivityID==ac,] ## pulling out data for subject+activity selections
        names(select_data)=NULL  ## I couldn't get 'apply' to work properly unless I took off the column names
        tidy_data_set=rbind(tidy_data_set,unlist(c(select_data[1,c(1:3)], apply(select_data[,c(-3:-1)],2,function(x){mean(x,na.rm=T)}))))
        ### calculating the means of the features, and then concatenating the results with the subjectID/activity/activityID to make a new entry
        ## note: the unlist will cause you to lose the activity labels
    }
}
tidy_data_set=data.frame(tidy_data_set)
names(tidy_data_set)=names(all_data)
tidy_data_set$Activity=activity_labeling(tidy_data_set$ActivityID,activity)  ### replacing lost activity labels

#### saving tidy data as a text file
setwd(base_dir)
write.table(tidy_data_set,'Tidy_data_final.txt')
