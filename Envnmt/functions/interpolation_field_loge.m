function [time,oxygeninterp] = interpolation_field_loge(time,oxygen,TimeECOxygen)
% time for interpolation in seconds not in minutes like in the other
% campaigns
oxygeninterp = interp1(TimeECOxygen,oxygen,time,'linear'); 
end