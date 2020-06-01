Getting and Cleaning data

The delivered code follows the instructions of the assigment 4 of the course in Getting and Cleaning Data from the JHU.

The process was:

1. Importation of the files from the UCI Machine Learning Repository, project HUman Activity Recognition Using Smartphones Data Set
2. All the datasets were read in R.
3. Since some datasets shared some variable names (e.g. V1 in subject and train sets), I renamed some variables in order to favor later coding.
4. All the datasets (test, train and subject) were merged in a single tidy table. 
5. Using dplyr package only the mean and std measurements were select. All the angle() variables were removed.
6. The code for activities was changed with the "activity_labels" information
7. Variables were renamed to favor readability
8. The final tidy data set was saved as "Tidydata.txt" containing the mean for each subject and each activity
