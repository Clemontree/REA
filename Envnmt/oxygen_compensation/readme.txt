+++++++++++++++++++++++++++++++++++++++
MATLAB code for calculating oxygen data
from raw data obtained by oxygen meters
from Pyro Science GmbH

Version 4 from 2018 Sept
+++++++++++++++++++++++++++++++++++++++

The m-files contains only help information.
The p-files are the actual code.

For instructions type the following within Matlab:

help setCalibrationData
help calculateOxygen    


++++++++++++++++
Revision History
++++++++++++++++

Changes in Version 3:
- the help files were improved
- the calculations were adapted for vector matlab calculations. Now a complete vector of measured raw data can be treated in a single step.

Changes in Version 4:
- Fixed wrong concatenating of output matrix
- instead of different functions for different sensor codes, one function with sensor code as input argument is now used