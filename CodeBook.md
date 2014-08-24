CodeBook for human-activity-recog
====================

This project uses a dataset called Human Activity Recognition Using Smartphones as described below.  The dataset can be obtained on the following site:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

A description of the analysis performed on this dataset is also found below.

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


Description of Analysis
========================
The original dataset contains two groups of data that were arbitrarily split into categories called "test" and "train."  In each group, there were three files:

Test:

- X_test.txt:  a file containing 2,947 observations and 561 variables representing measurements obtained via smartphone accelerometer and gyroscope.

- y_test.txt:  a file containing 2,947 observations and one variable, an integer between 1 and 6 representing an activity that was performed.

- subject_test.txt:  a file containing 2.947 observations and one variable, an integer between 1 and 30 representing a volunteer subject who had performed an activity.


Train:

- X_train.txt:  a file containing 7,352 observations and 561 variables representing measurements obtained via smartphone accelerometer and gyroscope.

- y_train.txt:  a file containing 7,352 observations and one variable, an integer between 1 and 6 representing an activity that was performed.

- subject_train.txt:  a file containing 7,352 observations and one variable, an integer between 1 and 30 representing a volunteer subject who had performed an activity.


The first step in the analysis was to combine the three files in the test folder together via cbind such that they became variables in the same data frame.  The second step was to perform the same action on the files in the train folder.  The third step was to then append the two data frames together into one dataset via rbind.  The resulting dataset contained 10,299 observations and 563 variables.

The next step was to subset the data to just the activity, subject, and columns that contained calculations for mean (containing mean() in the name) or standard deviation (containing std() in the name).  The features.txt file was used in conjunction with the grepl function to determine which variables contained values that were the result of mean or std calculations.  A value of 2 was added to the column index value to offset for the activity and subject columns that had been added to the dataset.

The next step was to update the activity numeric value with the corresponding activity name contained in the activity_lables.txt file.  The original variable containing the numeric value was overwritten with the activity name.

The next step was to label the dataset with descriptive variable names.  The data frame used previously to determine the variables to include in the dataset was used to label the columns.  Invalid characters such as hyphens and parentheses were removed from the names via the gsub function prior to assigning the name values.

To create the tidy dataset with an average for each variable for each activity and each subject, the aggregate function was used on the subset of the dataset not including the activity and subject variables.  The data was aggregated by activity and subject and the mean function applied, resulting in one average value for each variable for each subject and each activity.  This grouping activity caused the result set to include Group.1 and Group.2 as variable names for activity and subject.  The variable names vector that was obtained earlier in the process was used to rename the variables in the resulting tidy dataset.

The final step of the process was to use write.table() to write the table to a file called "tidydata.txt" with row.names = FALSE.
This file is also contained in the repository for inspection purposes.

Author:  Bryan Sirtosky
Date:  August 22, 2014


