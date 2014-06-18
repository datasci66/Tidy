## run_analysis.R

This script will merge together the test and training scripts. It will then create a tidy data set of the mean of the mean and standard deviation measures, for each subject and activity. The set will be written to a CSV file (tidy.csv).

### Steps:

1. load the features file for use as column names (features.txt)
2. load activity labels file (activity.txt)
3. load the training set files
  1. subject_train.txt
  2. x_train.txt
  3. y_train.txt
4. Add the subject file as a column to the x_train data
5. Add the activity file (y_train) as a column to the x_train data
6. Do the same for the test files
  1. subject_test.txt
  2. x_test.txt
  3. y_test.txt
7. reduce the set to only the columns (variables) we want
  * We will only include variables (features) that include mean and std
8. Melt the data set so that each measure is a now variable
9. Join in the activity labels to the melted set, and remove the activity ID column
10. Use dcast to get the mean for each variable for each subject and activity
  * This will also repivot the data so that each variable is again a column.
11. Order the data by subject, then by activity
12. Write the tidy data set to a CSV file **(tidy.CSV)**
