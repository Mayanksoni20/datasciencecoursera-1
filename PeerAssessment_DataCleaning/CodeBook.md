## 'Run Analysis.R' was the peer assessment project for the Collecting and Cleaning Data Coursera Course 
*The script 'Run Analysis.R' was written to clean motion data collected from a smartphone. 
*The overarching goal of the project is to predict the type of activity a person is engaged in: e.g., sitting, walking, etc, based on motion sensor signals from a smartphone. Specifically, data were collected from 30 subjects engaged in one of 6 possible activities, and the sensor signals were processed and decomposed into 561 features. 70% of the data were assigned to the training set; the remainder went into the testing set.
*My part was to extract features containing 'mean()' or 'std()' in their descriptor string from the training and testing sets, combine the extracted information across the two datasets, and generate a new dataset with the average of each of the extracted features, for each subject and activity. The final table should have 180 rows (30 subjects, 6 activities, and 69 columns: subject ID [1-30], activity label ['WALKING', etc], activity ID [1-6], and the 66 mean() and std() features [numeric])


## Variables

### directory paths
base_dir: path for base directory
features_dir: path for folder containing the features
train_dir: path for training data
test_dir: path for test data

### feature variables
features: full list of features
mean_ind: column numbers for features with mean()
std_ind: column numbers for features with std()
all_ind: column numbers for all of the desired features (a vector combining mean_ind and std_ind)

### activity variables
activity: a two column list consisting of the activity index and the corresponding label
e.g. 1,WALKING

### variables from training and testing data
train(test)_subject: vector with subject IDs (from the training (testing) set)
train(test)_activity: vector with activity labels (e.g., WALKING)
train(test)_activity_index: vector with activity IDs (e.g.,1)
train(test)_data: a data.frame whose columns are the desired features
train(test)_all: a data.frame with a column for subject IDs, a column for activity labels, a column for activity IDs, and columns for the features in train(test)_data

all_data: the result of combining train_all and test_all

### averaging across desired features
select_data: the portion of all_data corresponding to a certain subject engaged in a certain activity
tidy_data_set: final cleaned and processed dataset, saved to disk

## Functions
activity_labeling=function(activity_list,activity_dictionary):
This is a function to convert activity numbers (1 through 6) into activity labels ('WALKING', 'SITTING', etc)

get_desired_features=function(file_x,columns):
This function pulls out desired columns from a given table (e.g., 'X_train.txt'), 
and builds a new data.frame with those columns

