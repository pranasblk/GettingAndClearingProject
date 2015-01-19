# The code book

The tidyData contais combined training and test data from the "UCI HAR Dataset" aggregated by:

	1. activity - as activities performed by subject during data collection:
		1.1 WALKING
		1.2 WALKING_UPSTAIRS
		1.3 WALKING_DOWNSTAIRS
		1.4 SITTING
		1.5 STANDING
		1.6 LAYING
		
	2. subject - the number of test subject in the data set

Only subset of mean and standard deviation values used from original data set and the numeric values are **averaged after aggregation** by `activity` and `subject` values.
The `Md` and `Sd` fragments int the column names represent subset of variables with mean and standard deviation respectively selected to product the output.

The source of numeric variables can be cross referenced with the original code book described in `fetures_info.txt`, 
but naming is adjusted to fit my personal preferences. The source variable names from the original `features.txt` transformed: 

 * Naming for variables conforms to [Camel Case](http://en.wikipedia.org/wiki/CamelCase) maning convention;
 *.* Symbols `-`, `(`, `)` are removed;
 *.* `sd` replaced by `Sd`; `mean` by `Mean`;
 * Acronyms such as `f`, `t`, `Gyro`, `Acc`, `Mag` are replaced with `fft` (meaning fast furier transformation), `time`, `Gyroscope`, `Acceleration`, `Magnitude` respectively.