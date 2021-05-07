library(tidyverse)
library(plyr)
library (data.table)

# Step 1: Read all the relavant files
strain <- read.table(file="UCI HAR Dataset/train/subject_train.txt")
stest <- read.table(file="UCI HAR Dataset/test/subject_test.txt")
xtrain <- read.table(file="UCI HAR Dataset/train/X_train.txt", header = FALSE)
xtest <- read.table(file="UCI HAR Dataset/test/X_test.txt", header = FALSE)
ytrain <- read.table(file="UCI HAR Dataset/train/y_train.txt")
ytest <- read.table(file="UCI HAR Dataset/test/y_test.txt")

alabels <- read.table(file="UCI HAR Dataset/activity_labels.txt")
features <- read.table(file="UCI HAR Dataset/features.txt")
features <- gsub("-","",features$V2) 
 # This shows we have 561 headings to match the 561 columns in the train/test dataframes

# Step 2: Adding headings
colnames(strain) <- c("subject")
colnames(stest) <- c("subject")
colnames(ytrain) <- c("trainlabel")
colnames(ytest) <- c("trainlabel")
colnames(xtrain) <- c(features)
colnames(xtest) <- c(features)
colnames(alabels) <- c("tlabel", "descrptvlables")


# Step 3: Adding the subject & activity lable column to both the train and test dataframes. So now we will have 563 variables
newxtrain <- cbind(xtrain, strain, ytrain)
newxtest <- cbind(xtest, stest, ytest)


# Step 4: Merging the two dataframes. Train has 7352 obs, test has 2947. Each has 563 columns
# So after merging there should be 10299 records and 563 columns
final <- rbind(newxtrain, newxtest)


# Step 5: Extracting all with standard deviation and mean
final1 <- final[,grep("mean|std|subject|trainlabel",names(final))]


# Step 6: Adding the dexscriptive lables for the activities

final2 <- merge(final1,alabels, by.x= "trainlabel", by.y = "tlabel", all = TRUE)


# Step 7: Creating the new dataframe of means by activity and subject
#install.packages("reshape")

# Subsetting into a dataframe that has means and the subject and descriptive lables
final3 <- final2[,grep("mean|subject|descrptvlables",names(final2))]

namelist <- names(final3)

# Seggregating the sub
rest <- select(final3, -(subject:descrptvlables))

#final4 <- melt(final3, id=c("subject", "descrptvlables"), measure.vars=c(rest))

final4 <- melt(final3, id= c("subject", "descrptvlables"))

final5 <- dcast(final4, subject+descrptvlables~variable, mean)


# Step 8: Writing the dataframe to a text file:
write.table(final5, file = "week4_assessment.txt", row.names = FALSE)
