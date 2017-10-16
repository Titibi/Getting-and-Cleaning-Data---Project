The source code is in file "run_analysis.R" of this repo.
Please refer codebook to get detail of all the variables used.

Program flow:

1. First the zip file is downloaded and unzipped, which in turn creates a directory "UCI HAR Data" in the working directory

2. For the purpose of clean data analysis working directory is changed to "UCI HAR Data" and during the entire analysis this will      remain as the working directory, the clean data file is created in this new working direcotry only.
   One the analysis is over the working directory is switched back to original(old) working directory

3. "reshape2" package is loaded

4. Load activity and features into R

5. Extracting only mean and standard deviation features from all_feature variable. This is required because analysis will be done only on these variables.

6. Loading traning set and doing a column merge

7. Loading test set and doing a column merge

8. Creating a new variable "data" by merging by row traning and test set

9.Performaing a melt on "data" variable to separate rows by combination of Subject and Activity.

10. Finally calculating the mean on data_melt vector

11. Write file to directory with the name "tidydata.txt"

12. Original working directory is resored and downloaded zip file is deleted
