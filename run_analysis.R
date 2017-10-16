#Downloading the data 
zip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zip,"UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip")

#Changing working directory
wd <- getwd()
newwd <- paste(wd, "/UCI HAR Dataset/" , sep = "")
setwd(newwd)
print(paste("New Working Directory: ",newwd)) 

#Checking for reshape2 package
inst_pckg <- as.data.frame(installed.packages())
pck_name <- as.character(inst_pckg$Package)
reshape2 <- grep('reshape2',pck_name)
if(pck_name[dplyr] == "dplyr"){
    print("reshape2 is installed")
  } else {
    print("Pleae install reshape2 package. The program will exit now")
    }

#Loading reshape2
library(reshape2)

#Loading activity labels and mean and features
activity <- read.table("activity_labels.txt")
activity[,2] <- as.character(activity[,2])
all_features <- read.table("features.txt",stringsAsFactors = FALSE)

#extracting only mean and standar deviation features
req_features_indx <- grep('*mean*|*std*', all_features[,2])
features_names <- all_features[,2]

#Loading Training data into R
subject_train <- read.table("./train/subject_train.txt", col.names = "Subject", stringsAsFactors = FALSE)
x_train <- read.table("./train/x_train.txt", stringsAsFactors = FALSE,col.names = features_names)[req_features_indx]
y_train <- read.table("./train/y_train.txt", col.names = "Activity_label", stringsAsFactors = FALSE)
training_set <- cbind(subject_train,y_train,x_train)

#Loading Test data into R
subject_test <- read.table("./test/subject_test.txt", col.names = "Subject", stringsAsFactors = FALSE)
x_test <- read.table("./test/x_test.txt", stringsAsFactors = FALSE,col.names = features_names)[req_features_indx]
y_test <- read.table("./test/y_test.txt", col.names = "Activity_label", stringsAsFactors = FALSE)
test_set <- cbind(subject_test,y_test,x_test)

# Row merge both the sets
data <- rbind(training_set,test_set)

#Turning activity_label column to factor and putting acitvity name
data$Activity_label <- factor(data$Activity_label, levels = activity$V1, labels = activity$V2)

#Melt data for subject and activity respectively
data_melt <- melt(data, id = c("Subject","Activity_label"))
data_mean <- dcast(data_melt, Subject + Activity_label ~ variable , mean)

#Create new data file
write.table(data_mean, "tidydata.txt", row.names = FALSE)

#Changing working directoy to original
setwd(wd)

#Remove zip file and variables
file.remove("UCI HAR Dataset.zip")
rm(list=ls())
