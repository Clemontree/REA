function [ time_TimeShift, velocityZPrime_TimeShift, oxygenPrime_TimeShift, ecFluxOxygen_TimeShift, ecFluxOxygen_NoTimeShift, velocityZPrime, oxygenPrime, iFigure, bestPValue, pValues, timeshift, iShiftOxygen] ...
    = segment_time_shift_EC( Param, time, velocityZ, oxygen, plots)
% Time shift on maximum amplitude of correlation between variable and vertical velocity
%   Donis, D., M. Holtappels, C. Noss, C. Cathalot, K. Hancke, P. Polsenaere, 
%   F. WenzhÃ¶fer, A. Lorke, F. Meysman, R. Glud, and D. McGinnis (2014) 
%   AN ASSESSMENT OF THE PRECISION AND CONFIDENCE OF AQUATIC EDDY CORRELATION 
%   MEASUREMENTS. J. Atmos. Oceanic Technol. doi:10.1175/JTECH-D-14-00089.1
%   from Julika's EDDY_fluxes
 
%   correlations correlationVariableVelocityZ as a function of lag lags 
%   (argument search range in number of samples), 
%   did not work for Havel before substracting running average (min instead of max, due to non-zero variable averages)
% 21/04/2016 new variable names, figure nb and X and Y velocities added
% 26/04/2016 subtraction of running mean to look for min / max on fluctuations before shifting raw variables
% 20/12/2016 force flux sign: look for minimum in unbiased correlation (i.e. flux) for oxygen and heat,
% maximum for particles (corrected on 09/01/2017), and keep time shift closest to 0 if several peaks
% (see Julika'EDDY_flux.m)
% 09/01/2017 - time shifting of several variables validated with functions/test_time_shifts.m 
%            - time shifting plots: - print p-value of correlation between variables after shifting on plot of time shifting (function corrcoef as in Julika's EDDY_flux.m), 
%                                   - convert units to have same units as on ogives
%            - suppress shortening of raw variables to have same values as
% 13/01/2017 extract EC fluxes from correlation computations, before and
% after time shifting
 
% 23/09/2019 - Guilherme
% - Adapted function segment_time_shift fro main5.m to have a p value as an evaluation parameter

% TO DO:- compute time shift and EC flux in an embedded function (but sometimes max, sometimes min)
%       - check that lags in plot are the correct ones
%       - extract time-shifted fluctuations for ogives

%    HEATFLUXFACTOR = 999.2*4185.5;    % copied from Param in load_parameters 13/01/2017
    SEARCHRANGEPT = Param.TIMESHIFTSEARCHRANGESEC*Param.ADVSAMPLINGFREQUENCY;

    %% 26/04/2016 Subtraction of running mean to look for min / max on
    % fluctuations before shifting raw variables
    velocityZPrime = subtract_running_average(velocityZ,Param.RUNNINGAVERAGE);
    oxygenPrime = subtract_running_average(oxygen,Param.RUNNINGAVERAGE);
% velocityZPrime = velocityZ;
%     oxygenPrime = oxygen;
    %[ velocityZPrime ] = past_running_average( velocityZ, Param );
    %[ oxygenPrime ] = past_running_average( oxygen, Param );
    
    %% Initialization of output variables
    velocityZPrime_TimeShift     = velocityZPrime;
    oxygenPrime_TimeShift        = oxygenPrime;
    time_TimeShift          = time;
%     09/01/2017: probably useless    
%     % Running average shorter than original vector by Param.RUNNINGAVERAGE-1 points: shorten raw segment variables
%     conservedIndices = (Param.RUNNINGAVERAGE-1)/2 + 1 : length(velocityZ) - (Param.RUNNINGAVERAGE-1)/2;
%     velocityX   = velocityX(conservedIndices);
%     velocityY   = velocityY(conservedIndices);
%     velocityZ   = velocityZ(conservedIndices);
%     temperature = temperature(conservedIndices);
%     oxygen      = oxygen(conservedIndices);
%     particle    = particle(conservedIndices);

    %% time shift between oxygen and vertical velocity fluctuations: highest correlation with highest p-value
    [correlationOxygenVelocityZ, lags] = xcorr(oxygenPrime, velocityZPrime, SEARCHRANGEPT,'unbiased');
    correlationOxygenVelocityZ = 24*3600*correlationOxygenVelocityZ;    % mmol/mÂ²/d
    ecFluxOxygen_NoTimeShift = correlationOxygenVelocityZ(SEARCHRANGEPT + 1);  % 13/01/2017: flux before time shifting (0 time lag), for reference
    % 20/12/2016
    % arguments of xcorr: variables to correlate, max time lag, 'unbiased'
    % to get mean(w'(t+time_shift)O2'(t)) ie EC flux vs time shift
%   16/01/2017 : look for maximum for positive fluxes, minimum for
%   negative ones
%[~,iPeaks] = findpeaks(sign(ecFluxOxygen_NoTimeShift)*correlationOxygenVelocityZ);   
[~,iPeaks] = findpeaks(-correlationOxygenVelocityZ);  % look for indices of minima in correlation, supposing negative fluxes 
    nPeaks = length(iPeaks);
    potentialShiftOxygen = (lags(iPeaks))';            % It is vector and not index!
    if nPeaks==1  % one peak
        iShiftOxygen = potentialShiftOxygen;
        timeshift = potentialShiftOxygen/8;
        iPeakBestPValue = iPeaks;
        if iShiftOxygen == 0
                velocityZPrime_TimeShift     = velocityZPrime; 
                oxygenPrime_TimeShift        = oxygenPrime;
        end
        if iShiftOxygen >0                        % oxygen arrives later than the velocity as expected (oxymeter response time)                        
                velocityZPrime_TimeShift(end-iShiftOxygen+1:end) = [];
                time_TimeShift(end-iShiftOxygen+1:end) = [];
                oxygenPrime_TimeShift(1:iShiftOxygen) = [];  
        elseif iShiftOxygen<0                     % oxygen arrives earlier than the velocity (if bad synchronization of recording computers or softwares)
                velocityZPrime_TimeShift(1:abs(iShiftOxygen)) = [];
                time_TimeShift(1:abs(iShiftOxygen)) = [];
                oxygenPrime_TimeShift(end-abs(iShiftOxygen)+1:end)= [];
        end
        
        [~,bestPValue] = corrcoef([velocityZPrime_TimeShift, oxygenPrime_TimeShift]);
        ecFluxOxygen_TimeShift = mean(velocityZPrime_TimeShift.*oxygenPrime_TimeShift)*3600*24;
        bestPValue = bestPValue(1,2);
        pValues = bestPValue ;
        
        if abs(potentialShiftOxygen)==abs(SEARCHRANGEPT) % no peak im searchrange
                timeShiftOxygen = nan;
                ecFluxOxygen_TimeShift = nan;
                iPeakBestPValue = iPeaks;
        end
    % remark: correlationOxygenVelocityZ(iPeaks) is the EC flux and could be
    % output of this function
    
    elseif nPeaks>1                               % several peaks: select the closest to 0     
        %[~, iPeakCloseToOrigin] = min(abs(lags(iPeaks))); % index in iPeaks of peak closest to 0
        %timeShiftOxygen = lags(iPeaks(iPeakCloseToOrigin));
        %ecFluxOxygen_TimeShift = correlationOxygenVelocityZ(iPeaks(iPeakCloseToOrigin)); % 13/01/2017
        pValues = zeros(nPeaks,1);  % initialization
        timeshift = zeros(nPeaks,1);
        for i = [1:nPeaks]
        timeShift = potentialShiftOxygen(i);
        timeshift(i) = timeShift/8;
        velocityZPrime_TimeShift     = velocityZPrime; %reinitialize the vector positioning for loop treatment 
         oxygenPrime_TimeShift        = oxygenPrime; 
            if timeShift == 0
                velocityZPrime_TimeShift     = velocityZPrime; 
                oxygenPrime_TimeShift        = oxygenPrime;
            end
            if timeShift >0                        % oxygen arrives later than the velocity as expected (oxymeter response time)                        
                velocityZPrime_TimeShift(end-timeShift+1:end) = [];
                time_TimeShift(end-timeShift+1:end) = [];
                oxygenPrime_TimeShift(1:timeShift) = [];  
            elseif timeShift<0                     % oxygen arrives earlier than the velocity (if bad synchronization of recording computers or softwares)
                velocityZPrime_TimeShift(1:abs(timeShift)) = [];
                time_TimeShift(1:abs(timeShift)) = [];
                oxygenPrime_TimeShift(end-abs(timeShift)+1:end)= [];
            end
         [~,pOxygen] = corrcoef([velocityZPrime_TimeShift, oxygenPrime_TimeShift]); %pOxygen is a 2x2 matrix
         pValues(i) = pOxygen(1,2);                 %pvalues of absence of correlation
           
        end        
        [bestPValue,iPeakBestPValue] = min(pValues);        % find find with least p-value of non-correlation amongst the peaks
        iShiftOxygen = potentialShiftOxygen(iPeakBestPValue);   % index shift in data variable     
%         [val,idx]=min(abs(potentialShiftOxygen+1.1*8));
%         minVal=potentialShiftOxygen(idx)
%         iShiftOxygen = minVal;
%         bestPValue = pValues(idx);   
%         iPeakBestPValue = idx;
%       
    elseif isempty(iPeaks)                                % no peak -> no timeshift 
        potentialShiftOxygen = nan; 
        iShiftOxygen = nan;
        ecFluxOxygen_TimeShift = nan;
        pValue = nan;
        iPeakBestPValue = nan;

    end

    if iShiftOxygen >0
          velocityZPrime_TimeShift     = velocityZPrime; %reinitialize the vector positioning for loop treatment 
          oxygenPrime_TimeShift        = oxygenPrime;
          velocityZPrime_TimeShift(end-iShiftOxygen+1:end) = [];   % shortening of velocity z vector by the end
          time_TimeShift(end-iShiftOxygen+1:end) = [];
          oxygenPrime_TimeShift(1:iShiftOxygen) = [];
          ecFluxOxygen_TimeShift = mean(oxygenPrime_TimeShift.*velocityZPrime_TimeShift)*3600*24;
    end
    
    if iShiftOxygen<0
          velocityZPrime_TimeShift     = velocityZPrime; %reinitialize the vector positioning for loop treatment 
          oxygenPrime_TimeShift        = oxygenPrime;
          velocityZPrime_TimeShift(    1:abs(iShiftOxygen)) = [];
          time_TimeShift(1:abs(iShiftOxygen)) = [];
          oxygenPrime_TimeShift(end-abs(iShiftOxygen)+1:end)= [];   
          ecFluxOxygen_TimeShift = mean(oxygenPrime_TimeShift.*velocityZPrime_TimeShift)*3600*24;
    end
    
    if iShiftOxygen==0
          velocityZPrime_TimeShift     = velocityZPrime; %reinitialize the vector positioning for loop treatment 
          oxygenPrime_TimeShift        = oxygenPrime; 
          ecFluxOxygen_TimeShift = mean(oxygenPrime_TimeShift.*velocityZPrime_TimeShift)*3600*24;
    end
              %velocityZPrime_TimeShift(    1:abs(iPeaks(iPeakBestPValue))
              %= []; idea of solution
              %oxygenPrime_TimeShift(end-abs(iPeaks(iPeakBestPValue))+1:end)= [];
%clear iPeakCloseToOrigin iPeaks
    
    
% %% before 20/12/2016    
% %    [~, indexshift]         = max(abs(correlationOxygenVelocityZ));  
% %    timeShiftOxygen         = lags(indexshift);
%     
%     % initialise shifted raw and detrended variables
%     time_TimeShift          = time;
%     velocityX_TimeShift     = velocityX;
%     velocityY_TimeShift     = velocityY;
%     velocityZPrime_TimeShift     = velocityZ;
%     temperature_TimeShift   = temperature;
%     oxygenPrime_TimeShift        = oxygen;
%     particle_TimeShift          = particle; % 26/04/2016
%     
%     velocityZPrime_TimeShift    = velocityZPrime;
%     temperaturePrime_TimeShift  = temperaturePrime;
%     particlePrime_TimeShift     = particlePrime;
%     
%     % shorten time series according to time shift: O2 relative to w and C
%     if potentialIndexShiftOxygen>0 
%         oxygenPrime_TimeShift(1:potentialIndexShiftOxygen)                = [];    
%         
%         time_TimeShift(         end-potentialIndexShiftOxygen+1:end) = [];
%         velocityX_TimeShift(    end-potentialIndexShiftOxygen+1:end) = [];
%         velocityY_TimeShift(    end-potentialIndexShiftOxygen+1:end) = [];
%         velocityZPrime_TimeShift(    end-potentialIndexShiftOxygen+1:end) = [];
%         temperature_TimeShift(  end-potentialIndexShiftOxygen+1:end) = [];
%         particle_TimeShift(     end-potentialIndexShiftOxygen+1:end) = []; 
%         
%         velocityZPrime_TimeShift(   end-potentialIndexShiftOxygen+1:end) = [];    % 26/04/2016
%         temperaturePrime_TimeShift( end-potentialIndexShiftOxygen+1:end) = [];
%         particlePrime_TimeShift(    end-potentialIndexShiftOxygen+1:end) = [];
%     elseif potentialIndexShiftOxygen<0
%         oxygenPrime_TimeShift(end-abs(potentialIndexShiftOxygen)+1:end)= [];
%         
%         time_TimeShift(         1:abs(potentialIndexShiftOxygen)) = [];
%         velocityX_TimeShift(    1:abs(potentialIndexShiftOxygen)) = [];
%         velocityY_TimeShift(    1:abs(potentialIndexShiftOxygen)) = [];
%         velocityZPrime_TimeShift(    1:abs(potentialIndexShiftOxygen)) = [];
%         temperature_TimeShift(  1:abs(potentialIndexShiftOxygen)) = [];
%         particle_TimeShift(     1:abs(potentialIndexShiftOxygen)) = [];
%         
%         velocityZPrime_TimeShift(   1:abs(potentialIndexShiftOxygen)) = [];   % 26/04/2016
%         temperaturePrime_TimeShift( 1:abs(potentialIndexShiftOxygen)) = [];
%         particlePrime_TimeShift(    1:abs(potentialIndexShiftOxygen)) = [];  
%     end
% %     [~,pOxygen_NoTimeShift] = corrcoef([velocityZPrime, oxygenPrime]); 
% %     [~,pOxygen] = corrcoef([velocityZ_TimeShift, oxygen_TimeShift]);
% %     [~, iPeakCloseToOrigin] = min(abs(lags(iPeaks))); % index in iPeaks of peak closest to 0
% %         timeShiftOxygen = lags(iPeaks(iPeakCloseToOrigin));
% %         ecFluxOxygen_TimeShift = correlationOxygenVelocityZ(iPeaks(iPeakCloseToOrigin)); % 13/01/2017
% %     
% %     if pOxygen > pOxygen_NoTimeShift
        
    

    %% Plots of search for time shifts between variables (switch plots to plot
    % or not)
    if plots==1
%         iFigure = figure;
        iFigure = 3;
        % 09/01/2017: p-value of correlation (threshold for correlated variables
        % p<0.05) added on figure; could be written with only one line
        % corrcoef([velocityZ_TimeShift, oxygen_TimeShift,
        % temperature_TimeShift, particle_TimeShift]) and p(1,2:4)
%        [~,pOxygen] = corrcoef([velocityZPrime_TimeShift, oxygenPrime_TimeShift]); 
%       
            plot(lags/Param.ADVSAMPLINGFREQUENCY,correlationOxygenVelocityZ)
            hold on
            plot(potentialShiftOxygen/Param.ADVSAMPLINGFREQUENCY,correlationOxygenVelocityZ(iPeaks),'go'); 
            hold on
            if nPeaks>1
            plot(lags(iPeaks(iPeakBestPValue))/Param.ADVSAMPLINGFREQUENCY,ecFluxOxygen_TimeShift,'ro'); %correlationOxygenVelocityZ_TimeShift
            title({['oxygen:',num2str(lags(iPeaks(iPeakBestPValue))/Param.ADVSAMPLINGFREQUENCY),' s; p=',num2str(bestPValue,2)]})    
            end
            if nPeaks==1
            title({'time shifts and p-value for min/max correlation with velocity';['oxygen:',num2str(potentialShiftOxygen/Param.ADVSAMPLINGFREQUENCY),' s; p=',num2str(bestPValue,2)]})    
            end
            ylabel('C_{O_2,w} (mmol m^{-2} d^{-1})')

%plot(lags/Param.ADVSAMPLINGFREQUENCY,correlationOxygenVelocityZ)
%             hold on
%             plot(lags(iPeaks(iPeakBestPValue))/Param.ADVSAMPLINGFREQUENCY,ecFluxOxygen_TimeShift,'ro'); %correlationOxygenVelocityZ_TimeShift
%         %    xlabel('time shift (s)')
%             ylabel('C_{O_2,w} (mmol m^{-2} d^{-1})')
%             title({'time shifts and p-value for min/max correlation with velocity';['oxygen:',num2str(lags(iPeaks(iPeakBestPValue))/Param.ADVSAMPLINGFREQUENCY),' s; p=',num2str(bestPValue,2)]})
%         subplot(3,1,2)
%             plot(lags/Param.ADVSAMPLINGFREQUENCY,correlationTemperatureVelocityZ,'g')   % same heat capacity and mass density as in Param
%         %    xlabel('time shift (s)')
%             ylabel('C_{T,w} (W.m^{-2})')
%             title(['temperature: ',num2str(timeShiftTemperature/Param.ADVSAMPLINGFREQUENCY),' s; p=',num2str(pTemperature(1,2),2)])
%         subplot(3,1,3)
%             plot(lags/Param.ADVSAMPLINGFREQUENCY,correlationParticleVelocityZ,'r')
%             xlabel('time shift (s)')
%             ylabel('C_{SS,w} (g m^{-2} d^{-1})')
%             title(['particles: ',num2str(timeShiftParticle/Param.ADVSAMPLINGFREQUENCY),' s; p=',num2str(pParticle(1,2),2)])        
    else iFigure = [];
    end
end 
 