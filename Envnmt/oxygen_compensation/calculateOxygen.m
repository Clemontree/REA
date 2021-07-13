function oxygen = calculateOxygen(dphi, T, P, S, SensorType)

% Calculates oxygen values from raw data for PyroScience oxygen meters
% 
% (c) 2013 by Pyro Science GmbH, Germany, <a href="matlab:web('http://www.pyro-science.com')">www.pyro-science.com</a>
% 
% IMPORTANT: The calibration data must be adjusted with the function
% setCalibrationData, before calling calculateOxygen.
% 
% SYNTAX: oxygen = calculateOxygen(dphi, T, P, S, SensorType)
% 
% INPUT PARAMETERS (scalars or vectors):
% dphi           raw value "dphi" of the oxygen measurement (degree)
% T              temperature of the sample ('C)
% P              atmospheric pressure (mbar)
% S              salinity in the sample (g/l)   (set to 0 for gaseous samples)
% Sensor Type    SensorType (first letter of sensor code, e.g. 'X')
% 
% OUTPUT PARAMETER: array with 6 elements
%                  or matrix if any input parameter is a vector
% oxygen = [P_hPa, P_Torr, percentAirSat, percentO2, C_microMolar, C_mg_L]
% 
% P_hPa         oxygen partial pressure (hPa)                       [G,L]
% P_Torr        oxygen partial pressure (Torr)                      [G,L]
% percentAirSat dissolved oxygen in % air saturation (% air sat.)   [L]
% percentO2     volume percent oxygen (%O2)                         [G]
% C_microMolar  concentration of dissolved oxygen (µM)              [L]
% C_mg_L        concentration of dissolved oxygen (mg/L)            [L]
% 
% Remark:   [G,L]   unit valid in gaseous and liquid samples
%           [G]     unit valid only in gaseous samples
%           [L]     unit valid only in liquid samples

