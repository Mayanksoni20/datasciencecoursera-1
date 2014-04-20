There is only one script in this package: run_analysis.R
The script assumes that the file '/UCI HAR Dataset' was downloaded, unzipped, and stored locally.
The script goes onto:
* extract the 66 features with mean() or std() in their descriptor string
* combine the features across the training and testing datasets
* average each feature for each subject and activity
* create a new dataset with the averaged values
