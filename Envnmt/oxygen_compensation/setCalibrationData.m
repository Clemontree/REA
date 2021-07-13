function calData = setCalibrationData(temp0, temp100, pressure, humidity, dphi0, dphi100)

% Adjusts the calibration data needed for the function 'calculateOxygen'
% 
% (c) 2013 by Pyro Science GmbH, Germany, <a href="matlab:web('http://www.pyro-science.com')">www.pyro-science.com</a>
%
% Enter 6 arguments (scalars) for adjusting the calibration data:
% setCalibrationData(temp0, temp100, pressure, humidity, dphi0, dphi100)
% 
% Enter no argument for reading the current values:
% [temp0, temp100, pressure, humidity, dphi0, dphi100] = setCalibrationData()
%
% ARGUMENTS:
% temp0         Temperature of the 0% calibration standard      ('C)
% temp100       Temperature of the 100% calibration standard    ('C)
% pressure      Atmospheric pressure during the calibration     (mbar)
% humidity      a) For calibration in water: set humidity=100
%               b) For calibration in air: relative humidity    (%RH)
% dphi0         dphi (phase shift) of the 0% calibration        (degree)
% dphi100       dphi (phase shift) of the 100% calibration      (degree)

