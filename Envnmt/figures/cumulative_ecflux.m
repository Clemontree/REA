function  [OxFluxCumuluated_sgt, OxFluxInst_sgt, time]= ...
    cumulative_ecflux(velocityZPrime_TimeShift, oxygenPrime_TimeShift, SAMPLINGFREQUENCY,SgtDuration)

%calculates the cumulated flux on the segment

n = SgtDuration;
m = length(velocityZPrime_TimeShift); % n and m are different because of the running average (60s <-> ~480 timesteps) cutting out the first values of the series

%initialisation 
OxFluxCumuluated_sgt = zeros(n,1);
OxFluxInst_sgt = velocityZPrime_TimeShift.*oxygenPrime_TimeShift ;
time = 0:1/SAMPLINGFREQUENCY:n/SAMPLINGFREQUENCY;
time = time + 0.125;
time(end)=[];

OxFluxCumulatedTemp = 0;
for j= 1:m
    OxFluxCumulatedTemp = OxFluxCumulatedTemp + OxFluxInst_sgt(j);
    meanOxFluxCumulatedTemp = mean(OxFluxCumulatedTemp);
    OxFluxCumuluated_sgt(j) = meanOxFluxCumulatedTemp*time(j);
     
end
