# Getting and Clearing Project
The project of Getting and Clearing Data from the series of Data Science specialization in Coursera.

## Performing analysis

 * run the `run_analysis.R` script to perform end to end analysis with the output in `tidyData.txt` file.
 * One can speedup execution of the script by creating directory `data` containing extracted content of `Dataset.zip`. 
 
## Steps performe by the script:

 1. Download source data if required;
 2. Select variables from `features.txt` only containing `std()` and `mean()`;
 3. Transform resulting variable names to the [Camel Case](http://en.wikipedia.org/wiki/CamelCase) maning convention with more readable naming;
 4. Read train `X_train.txt`, `y_train.txt`, `subject_train.txt` and corresponding test data files;
 5. Combine resulting values to single `df`;
 6. Create new independant tidy data set with the average of each variable for each activity and each subject as `tidyData`;
 7. Export the `tidyData` to `tidyData.txt` file.
