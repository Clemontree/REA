function fluctuationVariableX = subtract_running_average(vectorX, runningAverage)
    % 18/04/2016 subtracts running mean from a vector, newer vector shortened by runningAverage-1 points
    % fluctuationVariableX = subtract_running_average(vectorX, runningAverage)
    remainingIndices = (runningAverage-1)/2+1 : length(vectorX)-(runningAverage-1)/2;
    fluctuationVariableX = vectorX(remainingIndices) - running_average(vectorX,runningAverage);
end
