function  [ecFluxHeat, ecFluxOxygen, ecFluxParticle, ... %reaFluxHeat, reaFluxOxygen, reaFluxParticle, ... 
    ecOgiveHeat, ecOgiveOxygen, ecOgiveParticle,... %reaOgiveHeat, reaOgiveOxygen, reaOgiveParticle, ...
        nFrequencyFFT]= ...
    segment_fluxes_ogives3(velocityZ, temperature, oxygen, particle, reaBCoef, ...
    velocityZThreshold, MASSDENSITY, HEATCAPACITY, nFrequencyFFT, SAMPLINGFREQUENCY, RUNNINGAVERAGE)
    % subtraction of running mean instead of linear detrending until 25/04
    % computes all fluxes and ogives on segments shortened by RUNNINGAVERAGE-1 points
    % updates nFrequencyFFT if needed
    % [ecFluxHeat, ecFluxOxygen, ecFluxParticle, reaFluxHeat, reaFluxOxygen, reaFluxParticle, ...
    %   ecOgiveHeat, ecOgiveOxygen, ecOgiveParticle, reaOgiveHeat, reaOgiveOxygen, reaOgiveParticle, nFft]= ...
    %   segment_fluxes_ogives(velocityZ, temperature, oxygen, particle, reaBCoef, velocityZThreshold, density, heatCapacity, nFft, SAMPLINGFREQUENCY, RUNNINGAVERAGE)    

    % 26/04 running-mean subtraction instead of linear detrending (still
    % done later for ogives), argument RUNNINGAVERAGE added   
    velocityZPrime      = subtract_running_average(velocityZ,RUNNINGAVERAGE);
    temperaturePrime    = subtract_running_average(temperature,RUNNINGAVERAGE);
    oxygenPrime         = subtract_running_average(oxygen,RUNNINGAVERAGE);
    particlePrime       = subtract_running_average(particle,RUNNINGAVERAGE);
    % Running average shorter than original vector by RUNNINGAVERAGE-1 points: shorten raw segment variables
    conservedIndices = (RUNNINGAVERAGE-1)/2 + 1 : length(velocityZ) - (RUNNINGAVERAGE-1)/2;
   %velocityZ = velocityZ(conservedIndices);    
%     temperature = temperature(conservedIndices);
    oxygen      = oxygen(conservedIndices);
%     particle    = particle(conservedIndices);
    
%     % linear detrending (temporary variables, Prime is added)
%     velocityZPrime   = detrend(velocityZ);
%     temperaturePrime = detrend(temperature);
%     oxygenPrime      = detrend(oxygen);
%     particlePrime    = detrend(particle);
    
    % direct EC flux calculation 
%     ecFluxHeat = MASSDENSITY*HEATCAPACITY*  mean(velocityZPrime.*temperaturePrime);    % W/mÂ²
ecFluxHeat = 0;
    ecFluxOxygen    = 24*3600*              mean(velocityZPrime.*oxygenPrime);         % mmol/mÂ²/day
%     ecFluxParticle  = 24*3600*              mean(velocityZPrime.*particlePrime);       % g/mÂ²/day
ecFluxParticle = 0;


    % Simulated relaxed eddy accumulation (REA) fluxes
    % subtraction of mean_sign(w').mean(C) (velocityZPrime instead of velocityZ on 26/04/2016)
%     % computed from difference between upward and downward concentration on 16/06/2016
%     reaFluxHeat =  MASSDENSITY*HEATCAPACITY*rea_flux(temperature, velocityZPrime,velocityZThreshold,reaBCoef);    % W/mÂ² 
%     reaFluxOxygen   =  24*3600*             rea_flux(oxygen,        velocityZPrime,velocityZThreshold,reaBCoef);   % mmol/mÂ²/day
%     reaFluxParticle =  24*3600*             rea_flux(particle,      velocityZPrime,velocityZThreshold,reaBCoef);    % g/mÂ²/day

    % OGIVES from covariance-preserving co-spectra, with linear detrending
    % for eddy-covariance fluxes 
%     [CPSD_Tw, frequency]= cpsd(MASSDENSITY*HEATCAPACITY*temperaturePrime, velocityZPrime,[],[],nFrequencyFFT,SAMPLINGFREQUENCY);          % W mâ?»Â² Hzâ?»Â¹
    CPSD_O2w            = cpsd(24*3600*                 oxygenPrime,      velocityZPrime,[],[],nFrequencyFFT,SAMPLINGFREQUENCY);          % mmol mâ?»Â² Hzâ?»Â¹
%     CPSD_Cw             = cpsd(24*3600*                 particlePrime,    velocityZPrime,[],[],nFrequencyFFT,SAMPLINGFREQUENCY);          % mg mâ?»Â² dâ?»Â¹ Hzâ?»Â¹
%     ecOgiveHeat         = cumsum(flipud(real(CPSD_Tw))) /nFrequencyFFT*SAMPLINGFREQUENCY; % W.mâ?»Â²
ecOgiveHeat=0;   
ecOgiveOxygen       = cumsum(flipud(real(CPSD_O2w)))/nFrequencyFFT*SAMPLINGFREQUENCY; % mmol.mâ?»Â².sâ?»Â¹
%     ecOgiveParticle     = cumsum(flipud(real(CPSD_Cw))) /nFrequencyFFT*SAMPLINGFREQUENCY; % mg.mâ?»Â².sâ?»Â¹
ecOgiveParticle=0;

    % for REA fluxes (heat (K/mÂ²/s/dB), O2 (mmol/mÂ²/s/dB), particles (g/mÂ²/s/dB)
%     % (velocityZPrime instead of velocityZ on 26/04/2016)
%     reaOgiveHeat     = rea_cpsd_ogive(MASSDENSITY*HEATCAPACITY*temperature, velocityZPrime,velocityZThreshold,nFrequencyFFT,SAMPLINGFREQUENCY,reaBCoef);
%     reaOgiveOxygen   = rea_cpsd_ogive(24*3600*oxygen,                       velocityZPrime,velocityZThreshold,nFrequencyFFT,SAMPLINGFREQUENCY,reaBCoef);
%     reaOgiveParticle = rea_cpsd_ogive(24*3600*particle,                     velocityZPrime,velocityZThreshold,nFrequencyFFT,SAMPLINGFREQUENCY,reaBCoef);
    
%     nFrequencyFFT = 2*(length(frequency)-1);     % if input nFft inadequate for sample length
end
