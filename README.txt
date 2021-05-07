The R script reads a set of training and test data from a group of text files . It merges and creates a new tidy data set of means by subject and activity. The data set is output as a text file and saved.

I read the data from the folowing place:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Step 1: Read in all relevant files and create the individual dataframes:
1. strain is a dataframe containing the list of all subjects on which the test was performed
2. stest is a similar dataframe, but contains the subjects in the test dataset
3. xtrain is the main dataframe containing the list of all measured variables. This dataframe refers to the training part of the data
4. xtest is the main dataframe that contains the list of all measured variables, but it refers to the test part of the data
5. ytrain/ytest contains the activities performed. There are 6 activities. train/test refers to the training and testing data.
6. alabels is the data frame that contains the description of the activities.
7. features contains the names of all variables measured in the xtrain/xtest data frame.

Step 2: In this step, headers are added to the data frames. For example, the features dataframe is used to add the names to the variables in the xtrain/xtest data sets. Similarly, a topic header is added to the strain and stest dataset. The column names are needed for the following operations

Step 3: Here we create a complete training and testing dataset by combining the variables in the xtrain/xtest dataset with the subjects and activities

Step 4: Here we merge the training and test datasets created in the above step to get the complete list of all datasets in one data frame. The newly created data frame is called final .

Step 5A new data frame - final - is created with only the relevant variables that measure the standard deviations or means. In addition, the columns subject and activity are deleted.

Step 6: A new column is added to denote descriptions of the activities. This is done using the alables data frame, which contains the activity code and description. This final1 data frame has the activity codes. So the activity code is the common column used to add the activity description to the corresponding rows. The resulting data frame is final2

Step 7: Several activities are performed here.  The final5 dataset is created by listing the average of all variants by subject and activity;

Step 8 : Create the text version of the final5 data frame. 


