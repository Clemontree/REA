function runningAverageVectorX = running_average(vectorX,runningAverage)
    % running average using convolution from Erni's eddysegmentsrotseg1.m
    %   runningAverage in points (odd number), vectorX is a column vector, 
    %   BEWARE! runningAverageVectorX shorter than vectorX by (runningAverage - 1) points after 
    %   cutting initialisation and ending periods of the running average
    
    a = conv(ones(runningAverage,1)/runningAverage,vectorX);
    % shorten timeseries for incomplete means at boundaries
    runningAverageVectorX = a(runningAverage : end-runningAverage+1); 
end