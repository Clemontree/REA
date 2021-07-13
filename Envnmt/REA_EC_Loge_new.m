%% 21/06/2021
% Script for EC and REA calculations at Ru de la loge for summer camapign
% v1 Clément
% The overall goal of this code is to provide a comparison of the O2 fluxes
% between REA and EC on the same segments.
% Time selection of segments are done automatically in the mentioned
% sections.

clear all;
close all;

mydirectory = '../Campagnes/Loge2904/';%
addpath('./functions','./despiking','./oxygen_compensation','./figures','./functions','./spectrums');

set(0, 'defaultFigureUnits', 'normalized', 'defaultFigurePosition', [0 0 1 1]);
set(0,'DefaultFigureVisible','off')

% SEE THESE FUNCTIONS TO KNOW THE PARAMETERS INTRODUCED
Param = load_parameters;   % to define constant parameters
iDeployment = 1; % initialization to retrieve the first parameters from deployment_parameter
Depl = deployment_parameter_loge( iDeployment, Param ); %selecting deployment parameters for the campaign


%% Importing Oxygen dataset and parameters for calibration

[Firesting.CompleteDataset]=uploading_firesting_2020(mydirectory+"202010429_loge_2.txt"); %uploading file created by oxymeter for the segment at 4Hz
Firesting.rawOxygen = Firesting.CompleteDataset{:,Depl.ecRow};
Firesting.rawOxygenUP = Firesting.CompleteDataset{:,Depl.upRow};
Firesting.rawOxygenDOWN = Firesting.CompleteDataset{:,Depl.dwRow};

[Firesting.TestDataset]=uploading_firesting_2020(mydirectory+"202010429_loge_1.txt"); %uploading file created by oxymeter for the segment

% probe calibration data found in .txt file
probeCalibration.temp0 = 18.602;
  probeCalibration.temp100 = 17.947;
  probeCalibration.pressure = 1020;
  probeCalibration.humidity = 100;
  probeCalibration.dphi0 = 52.352;
  probeCalibration.dphi100 = 21.65;

  probeCalibration.UP.temp0 = 18.61;
  probeCalibration.UP.temp100 = 17.955;
  probeCalibration.UP.pressure = 1020;
  probeCalibration.UP.humidity = 100;
  probeCalibration.UP.dphi0 = 51.385;
  probeCalibration.UP.dphi100 = 22.221;

  probeCalibration.DOWN.temp0 = 18.604;
  probeCalibration.DOWN.temp100 = 17.947;
  probeCalibration.DOWN.pressure = 1020;
  probeCalibration.DOWN.humidity = 100;
  probeCalibration.DOWN.dphi0 = 51.19;
  probeCalibration.DOWN.dphi100 = 22.828;


%% upload velocity for EC

filename = "loge104.dat";
filepath = mydirectory+filename;
formatSpec = '%5f%6f%9f%9f%9f%6f%6f%6f%7f%7f%7f%6f%6f%6f%8f%6f%6f%f%[^\n\r]';

fileID = fopen(filepath,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
velocityFile_raw_initiation = [dataArray{1:end-1}];
clearvars filename formatSpec fileID dataArray ans;

filename = "loge203.dat";
filepath = mydirectory+filename;
formatSpec = '%5f%6f%9f%9f%9f%6f%6f%6f%7f%7f%7f%6f%6f%6f%8f%6f%6f%f%[^\n\r]';
fileID = fopen(filepath,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
velocityFile_raw = [dataArray{1:end-1}];

clearvars filename formatSpec fileID dataArray ans;

%% date upload for EC

filename = "loge104.sen";
filepath = mydirectory+filename;
formatSpec = '%2f%3f%5f%3f%3f%3f%9f%9f%6f%7f%6f%6f%6f%7f%6f%f%[^\n\r]';
fileID = fopen(filepath,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);

velocitiy_time_raw_initiation = [dataArray{1:end-1}];
clearvars filename formatSpec fileID dataArray ans;

filename = "loge203.sen";
filepath = mydirectory+filename;
formatSpec = '%2f%3f%5f%3f%3f%3f%9f%9f%6f%7f%6f%6f%6f%7f%6f%f%[^\n\r]';
fileID = fopen(filepath,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);

velocity_time_raw = [dataArray{1:end-1}]; % velocity raw timeseries
clearvars filename formatSpec fileID dataArray ans;

% day of the campaign in string
campaign_day_string = string(datetime(velocitiy_time_raw_initiation(1,3),velocitiy_time_raw_initiation(1,1), velocitiy_time_raw_initiation(1,2)));%string with the date of the campaign

% start and end date of the campaign to create a timeseries in 8Hz
velocity_initiation_start = datetime(velocitiy_time_raw_initiation(1,3),velocitiy_time_raw_initiation(1,1), velocitiy_time_raw_initiation(1,2),velocitiy_time_raw_initiation(1,4),velocitiy_time_raw_initiation(1,5),velocitiy_time_raw_initiation(1,6)); %date of the start of the campaign, day included
velocity_initiation_end = datetime(velocitiy_time_raw_initiation(end,3),velocitiy_time_raw_initiation(end,1), velocitiy_time_raw_initiation(end,2),velocitiy_time_raw_initiation(end,4),velocitiy_time_raw_initiation(end,5),velocitiy_time_raw_initiation(end,6));

velocity_initiation_timseries_raw = (velocity_initiation_start:seconds(1/Param.ADVSAMPLINGFREQUENCY):velocity_initiation_end)';

velocity_start = datetime(velocity_time_raw(1,3),velocity_time_raw(1,1), velocity_time_raw(1,2),velocity_time_raw(1,4),velocity_time_raw(1,5),velocity_time_raw(1,6));
velocity_end = datetime(velocity_time_raw(end,3),velocity_time_raw(end,1), velocity_time_raw(end,2),velocity_time_raw(end,4),velocity_time_raw(end,5),velocity_time_raw(end,6));

velocity_timeseries_raw = (velocity_start:seconds(1/Param.ADVSAMPLINGFREQUENCY):velocity_end)';

velocity_initiation_timseries_raw(end)=[]; %must cut the last element because there is one too many at the creation
velocity_timeseries_raw(end)=[];

clearvars tStartLoge1 tEndLoge1 tStartLoge2 tEndLoge2

% timing timseries i.e. timesteps from 0, then 0.125 etc...

velocity_initiation_timing = 0:1/Param.ADVSAMPLINGFREQUENCY:length(velocity_initiation_timseries_raw)/Param.ADVSAMPLINGFREQUENCY;
velocity_timing = 0:1/Param.ADVSAMPLINGFREQUENCY:length(velocity_timeseries_raw)/Param.ADVSAMPLINGFREQUENCY;

velocity_initiation_timing(end)=[]; %same as tLoge
velocity_timing(end)=[];

% while this vector contains only the HH:mm:ss format, the day of the campaign remains in memory for plots
velocity_initiation_timseries_raw = datetime(velocity_initiation_timseries_raw(:,1),'Format','HH:mm:ss'); 
velocity_timeseries_raw = datetime(velocity_timeseries_raw(:,1),'Format','HH:mm:ss');


%% selecting oxygen duration for EC

% oxygen timeseries from the .txt file the day of the campaign is kept in
% memory even though it doesn't appear in the vector
oxygen_initiation_timeseries_raw = datetime(datetime(campaign_day_string+ ' '+string(Firesting.TestDataset{1:end,2})), 'Format','HH:mm:ss');
oxygen_timeseries_raw = datetime(datetime(campaign_day_string+ ' '+string(Firesting.CompleteDataset{1:end,2})), 'Format','HH:mm:ss');

%finds the latest starting date between velocity and oxygen
campaign_initiation_start_date = max(velocity_initiation_timseries_raw(1), oxygen_initiation_timeseries_raw(4)); 
campaign_start_date = max(velocity_timeseries_raw(1), oxygen_timeseries_raw(4));

%finds the index corresponding the start of the campaign in the oxFile
i_oxygen_initiation_timeseries_start = knnsearch(datenum(oxygen_initiation_timeseries_raw),datenum(campaign_initiation_start_date)); %finds the index for beginning of the measure in the time vector
i_oxygen_timeseries_start = knnsearch(datenum(oxygen_timeseries_raw),datenum(campaign_start_date));

% finds the earliest end between velocity and oxygen
campaign_initiation_end_date = min(velocity_initiation_timseries_raw(end), oxygen_initiation_timeseries_raw(end-3)); 
campaign_end_date = min(velocity_timeseries_raw(end), oxygen_timeseries_raw(end-3));

% finds the index corresponding the end of the campaign in the oxFile
i_oxygen_initiation_timeseries_end = knnsearch(datenum(oxygen_initiation_timeseries_raw),datenum(campaign_initiation_end_date))-1; %finds the index for end of the measure in the time vector
i_oxygen_timeseries_end = knnsearch(datenum(oxygen_timeseries_raw),datenum(campaign_end_date))-1;

% number of points in the oxFile, should be a multiple of 4 (if 4Hz)
oxygen_initiation_duration_points = i_oxygen_initiation_timeseries_end-i_oxygen_initiation_timeseries_start+1;
oxygen_duration_points = i_oxygen_timeseries_end-i_oxygen_timeseries_start+1;

%timeseries in 8Hz for oxygen and velocity 
% last element must be cut out for the vecor to be a multiple of 8 long
oxygen_initiation_timeseries = (campaign_initiation_start_date:seconds(1/Param.ADVSAMPLINGFREQUENCY):campaign_initiation_end_date)';
oxygen_initiation_timeseries(end)=[];
velocity_initiation_timeseries = oxygen_initiation_timeseries;

oxygenTimeseries = (campaign_start_date:seconds(1/Param.ADVSAMPLINGFREQUENCY):campaign_end_date)';
oxygenTimeseries(end)=[];
velocitiesTimeseries = oxygenTimeseries;


% index for beginning and end of the velocity vector
% 1 if velocity measurements are late, but >1 if velocities measurements start before oxygen recordings
i_velocity_initiation_start = 1; 
isOxygenLate = velocity_initiation_timseries_raw(1) < campaign_initiation_start_date;
if isOxygenLate 
    i_velocity_initiation_start = seconds(oxygen_initiation_timeseries_raw(4) - velocity_initiation_timseries_raw(1))*Param.ADVSAMPLINGFREQUENCY;
end

samplingRatio = Param.ADVSAMPLINGFREQUENCY/Param.FIRESTINGSAMPLINGFREQUENCY ;
i_velocity_initiation_end = i_velocity_initiation_start + oxygen_initiation_duration_points*samplingRatio - 1 ; 
velocity_initiation_duration_points = oxygen_initiation_duration_points*samplingRatio; 

i_velocity_start = 1;
isOxygenLate = velocity_timeseries_raw(1) < campaign_start_date;
if isOxygenLate
    i_velocity_start = seconds(oxygen_timeseries_raw(4) - velocity_timeseries_raw(1))*samplingRatio;
end

i_velocity_end = i_velocity_start + oxygen_duration_points*samplingRatio - 1; %
velocity_duration_points = oxygen_duration_points*samplingRatio;

% end of selecting oxygen duration for EC


%% Velocity despiking for EC

% Despiking for raw velocities with low correlations and SNR
velocity_raw = velocityFile_raw(:,3:5);
velocity_correlation = velocityFile_raw(:,12:14);
velocity_snr = velocityFile_raw(:,9:11);
[row,~] = find(velocity_correlation<Param.VELOCITYCORRELATION);
[row2,~] = find(velocity_snr<Param.SNR);

velocity_raw(row,:) = NaN;
velocity_raw(row2,:) = NaN;

velocity_raw_despiked = fillmissing(velocity_raw,'linear','EndValues','nearest');

% Despiking method by Goring, Derek & Nikora, Vladimir. (2002)
[velocity_raw_despiked(:,1), ~] = func_despike_phasespace3d(velocity_raw_despiked(:,1), 0, 2);
[velocity_raw_despiked(:,2), ~] = func_despike_phasespace3d(velocity_raw_despiked(:,2), 0, 2);
[velocity_raw_despiked(:,3), ~] = func_despike_phasespace3d(velocity_raw_despiked(:,3), 0, 2);


velocity_initiation_raw = velocityFile_raw_initiation(:,3:5);
velocity_initiation_correlation = velocityFile_raw_initiation(:,12:14);
velocity_initiation_snr = velocityFile_raw_initiation(:,9:11);
[row,~] = find(velocity_initiation_correlation<Param.VELOCITYCORRELATION);
[row2,~] = find(velocity_initiation_snr<Param.SNR);

velocity_initiation_raw(row,:) = NaN;
velocity_initiation_raw(row2,:) = NaN;

velocity_initiation_raw_despiked = fillmissing(velocity_initiation_raw,'linear','EndValues','nearest');


[velocity_initiation_raw_despiked(:,1), ~] = func_despike_phasespace3d(velocity_initiation_raw_despiked(:,1), 0, 2);
[velocity_initiation_raw_despiked(:,2), ~] = func_despike_phasespace3d(velocity_initiation_raw_despiked(:,2), 0, 2);
[velocity_initiation_raw_despiked(:,3), ~] = func_despike_phasespace3d(velocity_initiation_raw_despiked(:,3), 0, 2);


%% Selecting velocity data period for EC

velocity_initiation_raw_despiked = velocity_initiation_raw_despiked(i_velocity_initiation_start:i_velocity_initiation_end,:);
velocity_raw_despiked = velocity_raw_despiked(i_velocity_start:i_velocity_end,:);
velocities_initiation = velocity_initiation_raw_despiked;
velocities = velocity_raw_despiked;

%% Oxygen despiking 

[oxygen_initiation_4Hz, ~] = func_despike_phasespace3d(Firesting.TestDataset{:,20}, 0, 2);

[oxygen4Hz, ~] = func_despike_phasespace3d(Firesting.CompleteDataset{:,20}, 0, 2);
[oxygen4HzUp, ~] = func_despike_phasespace3d(Firesting.CompleteDataset{:,21}, 0, 2);
[oxygen4HzDw, ~] = func_despike_phasespace3d(Firesting.CompleteDataset{:,19}, 0, 2);


%% oxygen interpolation for whole campaign
ox_initiation_timestep = Firesting.TestDataset{i_oxygen_initiation_timeseries_start:i_oxygen_initiation_timeseries_end,3}-Firesting.TestDataset{i_oxygen_initiation_timeseries_start,3}; %Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
velocity_initiation_timestep = velocity_initiation_timseries_raw(i_velocity_initiation_start:i_velocity_initiation_end)-velocity_initiation_timseries_raw(i_velocity_initiation_start);
oxygen_initiation_4Hz = oxygen_initiation_4Hz(i_oxygen_initiation_timeseries_start:i_oxygen_initiation_timeseries_end);

 [time1,oxygen_initiation_8Hz] = interpolation_field_loge(velocity_initiation_timestep,oxygen_initiation_4Hz,ox_initiation_timestep);
 oxygen_initiation_8Hz = oxygen_initiation_8Hz';
 
 ox_timestep = Firesting.CompleteDataset{i_oxygen_timeseries_start:i_oxygen_timeseries_end,3}-Firesting.CompleteDataset{i_oxygen_timeseries_start,3}; %Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
velocitiy_timestep = velocity_timing(i_velocity_start:i_velocity_end)-velocity_timing(i_velocity_start);
oxygen4Hz = oxygen4Hz(i_oxygen_timeseries_start:i_oxygen_timeseries_end);
oxygen4HzUp = oxygen4HzUp(i_oxygen_timeseries_start:i_oxygen_timeseries_end);
oxygen4HzDw = oxygen4HzDw(i_oxygen_timeseries_start:i_oxygen_timeseries_end);

 [time2,oxygen8Hz] = interpolation_field_loge(velocitiy_timestep,oxygen4Hz,ox_timestep);
  oxygen8Hz = oxygen8Hz';
  
  [~,oxygen8HzUp] = interpolation_field_loge(velocitiy_timestep,oxygen4HzUp,ox_timestep);
  oxygen8HzUp = oxygen8HzUp';
  
  [~,oxygen8HzDw] = interpolation_field_loge(velocitiy_timestep,oxygen4HzDw,ox_timestep);
  oxygen8HzDw = oxygen8HzDw';
  
%% removing outliers from oxygen 

oxygenMeanCamapign = nanmean(oxygen8Hz);
oxygenStdCamapaign = nanstd(oxygen8Hz);

oxygen8Hz(75399:75418)= NaN;
oxygen8Hz = fillmissing(oxygen8Hz,'linear','EndValues','nearest');
  
  
%% temperature interpolation for EC

temperature_extremes = Depl.temperature; %initial and final temperature during the day
%linear interpolation between temperature at the beginning and end of campaign
temperature_campaign = interp1([1,velocity_duration_points],temperature_extremes,1:velocity_duration_points,'linear')';

%% oxygen conversion from Dphi to mmol for whole campaign

oxygenPlot = zeros(length(oxygen8Hz),1); %mmol/m3
%calibration of calculateOxygen function
setCalibrationData(probeCalibration.temp0, probeCalibration.temp100, probeCalibration.pressure,...
    probeCalibration.humidity, probeCalibration.dphi0, probeCalibration.dphi100);

for i = 1:velocity_duration_points;
    F4 = calculateOxygen(oxygen8Hz(i), temperature_campaign(i), 1020, 0, 'Z');
    oxygenPlot(i) = F4(5);
end

%% Oxygen plot
 

 figure('Name','O2 Concentration'+Depl.figName,'NumberTitle','off');
 plot(oxygenTimeseries,oxygenPlot);
 ylabel('[O_2] (mmol.m^-^3)')
 title({'O_2 Concentration ',Depl.figTitle})  
 a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{C}='+string(oxygenMeanCamapign)+'mmol.m^-3$'];[' $\sigma_{C}='+string(oxygenStdCamapaign)+'mmol.m^-3$']},'FitBoxToText','on', 'Fontsize', 16);

 oxygenPrimeCamapaign = subtract_running_average(oxygenPlot, Param.RUNNINGAVERAGE);
 oxygenPrimeMeanCamapaign = nanmean(oxygenPrimeCamapaign);
 oxygenPrimeStdCamapaign = nanstd(oxygenPrimeCamapaign);
 
 figure('Name','O2 Prime Concentration'+Depl.figName,'NumberTitle','off');
 plot(oxygenTimeseries(1:length(oxygenPrimeCamapaign)),oxygenPrimeCamapaign)
 ylabel('C_{O_2}'' (mmol.m^-^3)')
 title({'O_2 Prime Concentration',Depl.figTitle})  
 a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{C_{O_2}''}='+string(oxygenPrimeMeanCamapaign)+'mmol.m^-3$'];[' $\sigma_{C_{O_2}''}='+string(oxygenPrimeStdCamapaign)+'mmol.m^-3$']},'FitBoxToText','on', 'Fontsize', 16);

 %% Planar Fit 

u=nan(floor(length(velocities)/Depl.ave),3);
for i=1:floor(length(velocities)/Depl.ave)
    u(i,1)=nanmean(velocities((i-1)*Depl.ave+1:i*Depl.ave,1));
    u(i,2)=nanmean(velocities((i-1)*Depl.ave+1:i*Depl.ave,2));
    u(i,3)=nanmean(velocities((i-1)*Depl.ave+1:i*Depl.ave,3));
end

H=[length(u) sum(u(:,1)) sum(u(:,2)); sum(u(:,1)) sum(u(:,1).*u(:,1)) sum(u(:,1).*u(:,2)); sum(u(:,2)) sum(u(:,1).*u(:,2)) sum(u(:,2).*u(:,2))];
g=[sum(u(:,3)) sum(u(:,1).*u(:,3)) sum(u(:,2).*u(:,3))];
b=H\g';
p31=-b(2)/sqrt(b(2)^2+b(3)^2+1);
p32=-b(3)/sqrt(b(2)^2+b(3)^2+1);
p33=1/sqrt(b(2)^2+b(3)^2+1);
D=[sqrt(p32^2+p33^2) 0 p31; 0 1 0; -p31 0 sqrt(p32^2+p33^2)];
C=[1 0 0; 0 p33/sqrt(p32^2+p33^2) p32/sqrt(p32^2+p33^2); 0 -p32/sqrt(p32^2+p33^2) p33/sqrt(p32^2+p33^2)];
P=D'*C';
velocitiesAlignedPF=(D'*C'*[velocities(:,1) velocities(:,2) velocities(:,3)-b(1)]')';
a=atan2(nanmean(velocitiesAlignedPF(:,2)), nanmean(velocitiesAlignedPF(:,1)));    %rotation around z-axis
velocitiesAlignedPF(:,1)=velocitiesAlignedPF(:,1)*cos(a)+velocitiesAlignedPF(:,2)*sin(a);
velocitiesAlignedPF(:,2)=-velocitiesAlignedPF(:,1)*sin(a)+velocitiesAlignedPF(:,2)*cos(a);

%% Plot of Velocities and spectres
% u, v ,w are the velocity components, w is the vertical velocity

wRawMean = mean(velocities(:,3));
wRawStd = std(velocities(:,3));
figure('Name','ADV Raw Vertical Velocity'+Depl.figName,'NumberTitle','off')
% timew = tLoge(VeliStartLoge01:iSegmentDuration*QuantityofSegts+VeliStartLoge01-1);
% plot(velocitiesTimeseries, velocities(:,3));
hold on 
plot(velocitiesTimeseries, velocities(:,1));
hold on 
% plot(velocitiesTimeseries, velocities(:,2));
xlabel('Time');
ylabel('Raw Vertical Velocity');
title('ADV Raw Vertical Velocity',Depl.figTitle);
a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{w}='+string(wRawMean)+'m.s^{-1}$'];[' $\sigma_{w}='+string(wRawStd)+'m.s^{-1}$']},'FitBoxToText','on', 'Fontsize', 16);

wAligned_Mean = mean(velocitiesAlignedPF(:,3));
wAligned_Std = std(velocitiesAlignedPF(:,3));
figure('Name','ADV Vertical Velocity Aligned'+Depl.figName,'NumberTitle','off')
% timew = tLoge(VeliStartLoge01:iSegmentDuration*QuantityofSegts+VeliStartLoge01-1);
plot(velocitiesTimeseries, velocitiesAlignedPF(:,3));
xlabel('Time');
ylabel('Vertical Velocity w after PF)');
title('ADV Vertical Velocity Aligned by PF',Depl.figTitle);
a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{w}='+string(wAligned_Mean)+'m.s^{-1}$'];[' $\sigma_{w}='+string(wAligned_Std)+'m.s^{-1}$']},'FitBoxToText','on', 'Fontsize', 16);

wPrime = subtract_running_average(velocitiesAlignedPF(:,3), Param.RUNNINGAVERAGE);
wPrime_Mean = mean(wPrime);
wPrime_Std = std(wPrime);
figure('Name','ADV Vertical Velocity Fluctuation'+Depl.figName,'NumberTitle','off')
% timew = tLoge(VeliStartLoge01:iSegmentDuration*QuantityofSegts+VeliStartLoge01-1);
plot(velocitiesTimeseries(1:length(wPrime)), wPrime);
xlabel('Time');
ylabel('Vertical Velocity Fluctuation)');
title('ADV Vertical Velocity Fluctuation',Depl.figTitle);
a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{['$\bar{w''}='+string(wPrime_Mean)+'m.s^{-1}$'];[' $\sigma_{w''}='+string(wPrime_Std)+'m.s^{-1}$']},'FitBoxToText','on', 'Fontsize', 16);



% effects of alignement on the spectrums
spectrum_gui([1 1 1 1 1 1 1 1 1 1 1 1 1 1]);
spectrum_gui(velocities(:,3), 8, 4096, 50, 'Hamming', 'Linear', 1,'Spectrum Raw Vertical Velocity log-log', 'Spectrum (log-log)');%spectrum_gui(data,Fs,NFFT,overlap,Window,detrend,#composites,name, display)
spectrum_gui(velocitiesAlignedPF(:,3), 8, 4096, 50, 'Hamming', 'Linear', 1,'Spectrum Aligned Vertical Velocity PF log-log', 'Spectrum (log-log)');
spectrum_gui(oxygen4Hz, 4, 4096, 50, 'Hamming', 'Linear', 1,'Spectrum Oxygen log-log', 'Spectrum (log-log)');

spectrum_gui(velocities(:,3), 8, 4096, 50, 'Hamming', 'Linear', 1,'Spectrum Raw Vertical Velocity varpres', 'Spectrum (var. pres.)'); %spectrum_gui(data,Fs,NFFT,overlap,Window,detrend,#composites,name, display)
spectrum_gui(velocitiesAlignedPF(:,3), 8, 4096, 50, 'Hamming', 'Linear', 1,'Spectrum Aligned Vertical Velocity PF varpres', 'Spectrum (var. pres.)');
spectrum_gui(oxygen4Hz, 4, 4096, 50, 'Hamming', 'Linear', 1,'Spectrum Oxygen varpres', 'Spectrum (var. pres.)');


%% %% REA 
clear REA Automate

Automate.velocity.fig1 = figure('Name','Automate Vertical Velocities 1'+Depl.figName,'NumberTitle','off');
sgtitle({'Automate Vertical Velocities',Depl.figTitle},'fontweight','bold') 
Automate.velocityfluc.fig1 = figure('Name','Automate Vertical Velocities fluctuation 1'+Depl.figName,'NumberTitle','off');
sgtitle({'Automate Vertical Velocities',Depl.figTitle},'fontweight','bold') 



Time = 0:1/8:length(velocitiesAlignedPF(:,1))/8;
oxFluxCumuluated= [];
OxFluxInst= [];
pValues = {} ;
timeShift_List= {};

CorrelationFig1 = figure('Name','Correlation 1'+Depl.figName,'NumberTitle','off');
sgtitle({'time shifts and p-value for min-max correlation with velocity',Depl.figTitle},'fontweight','bold') 
OgiveFig1 = figure('Name','Ogives 1'+Depl.figName,'NumberTitle','off');
sgtitle({'ogives: REA (..) and EC(-) O2',Depl.figTitle},'fontweight','bold') 
FluxCumFig1 = figure('Name','EC O2 Mean cumulated flux 1'+Depl.figName,'NumberTitle','off');
sgtitle({'EC O2 Mean cumulated flux',Depl.figTitle},'fontweight','bold') 

% CorrelationFig2 = figure('Name','Correlation 2','NumberTitle','off');
% sgtitle('time shifts and p-value for min-max correlation with velocity','fontweight','bold') 
% OgiveFig2 = figure('Name','Ogives 2','NumberTitle','off');
% sgtitle('ogives: REA (..) and EC(-) O2','fontweight','bold') 
% FluxCumFig2 = figure('Name','EC O2 Mean cumulated flux 2','NumberTitle','off');
% sgtitle('EC O2 Mean cumulated flux','fontweight','bold') 

VelFig1 = figure('Name','ADV Vertical Velocities 1'+Depl.figName,'NumberTitle','off');
sgtitle({'ADV Vertical Velocities PF 800 points',Depl.figTitle},'fontweight','bold') 
VelFluFig1 = figure('Name','ADV Vertical Velocities fluctuation 1'+Depl.figName,'NumberTitle','off');
sgtitle({'ADV Vertical Velocities fluctuation 60s running average',Depl.figTitle},'fontweight','bold') 

% VelFig2 = figure('Name','ADV Vertical Velocities PF 800 points 2','NumberTitle','off');
% sgtitle('ADV Vertical Velocities PF 800 points','fontweight','bold') 
% VelFluFig2 = figure('Name','ADV Vertical Velocities fluctuation 2','NumberTitle','off');
% sgtitle('ADV Vertical Velocities fluctuation 60s running average','fontweight','bold') 

oxygenPrimeFig1 = figure('Name','Oxygen concentration fluctuation 1'+Depl.figName,'NumberTitle','off');
sgtitle({'Oxygen concentration fluctuation',Depl.figTitle},'fontweight','bold') 

% oxygenPrimeFig2 = figure('Name','Oxygen concentration fluctuation 2','NumberTitle','off');
% sgtitle('Oxygen concentration fluctuation','fontweight','bold') 

OxFluxCumulated= zeros(length(oxygenTimeseries),1);
OxFluxInst= [];
FluxesShifted = zeros(Depl.nbSegments,2);
FluxesNoShifted = zeros(Depl.nbSegments,2);
bestPValue = zeros(Depl.nbSegments);
% pValues = zeros(1, Depl.nbSegments);
% timeShift_List = zeros(1, Depl.nbSegments);
timeShift = zeros(Depl.nbSegments, 1);
w_Mean = zeros(Depl.nbSegments, 1);
w_Std = zeros(Depl.nbSegments, 1);
wPrime = zeros(Depl.nbSegments, 1);
wPrime_Mean = zeros(Depl.nbSegments, 1);
wPrime_Std = zeros(Depl.nbSegments, 1);
oxygenPrime = zeros(Depl.nbSegments, 1);


for iDeployment = 1:Depl.nbSegments; %Choose the segment to be analyzed

iSegment = iDeployment;
Depl = deployment_parameter_loge( iDeployment, Param );%selecting deployment parameters for the campaign

%% Uploading velocity dataset and selecting parameters and durations 
   
% Import the velocity data
Automate.velocityFile = readtable(Depl.velocityfile);
  
    % New version for matlab 2020
    
    
    %time selection of segment
% Several steps are required
% Start of the segment
% 1/ The beginning of a segment is conditioned by the date when the running average is starting (column 7 here)
% 2/ However this date may not be in the middle of a second (e.g. 14:28:15:0.375 insted of 14:28:15:0.000)
% so we must find the next round second 
% 3/ Retrieve the HH:mm:ss date for the beginning to select the segment in the oxygen data

%1/
iStartrunningAvg = find(Automate.velocityFile{:,7}~=0, 1, 'first'); % starting index of the running average in csv file
%2/
iStarthourlast = find(Automate.velocityFile{:,1}==Automate.velocityFile{iStartrunningAvg,1}, 1, 'last'); % last index of the hour shared with iStartrunningAvg
iStartSgt = iStarthourlast - (floor((iStarthourlast-iStartrunningAvg+1)/8))*8+1; % finds the index to start at the beginning of a second (i.e. there are 8 measures)
%3/
StartSgtSecond = 59-floor((iStarthourlast-iStartrunningAvg+1)/8)+1;

% End of the segment
% 1/ The end of the segment is conditioned only by the end of the csv file
% 2/ Again we must find the last whole second in 8Hz 
% 3/ To prevent failures, the end of the segment is set so that the number of elements is a multiple of 8
% 3/ Retrieve the HH:mm:ss date for the end to select the segment in the oxygen data

% 1/
iEndhour = find(Automate.velocityFile{:,1}==Automate.velocityFile{end,1}, 1, 'first');
% 2/
iEndSgt = iEndhour + floor((length(Automate.velocityFile{:,1})-iEndhour+1)/8)*8-1;
%3/
SgtDuration = iEndSgt - iStartSgt+1;
iEndSgt = iStartSgt + floor(SgtDuration/8)*8 -1 ;
SgtDuration = iEndSgt - iStartSgt+1;
%4/
EndSgtSecond = floor((length(Automate.velocityFile{:,1})-iEndhour+1)/8)-1;

DateStart = datetime(datetime(campaign_day_string+ ' '+string(datetime(Automate.velocityFile{iStarthourlast,1},'Format', 'HH:mm'))+':'+StartSgtSecond), 'Format', 'HH:mm:ss');
DateEnd = datetime(datetime(campaign_day_string+ ' '+string(datetime(Automate.velocityFile{iEndhour,1},'Format', 'HH:mm'))+':'+EndSgtSecond), 'Format', 'HH:mm:ss');

%select oxygen duration, same process as in EC

OxiStart = find(oxygenTimeseries==DateStart, 1, 'first');%finds the index for beginning of the segment,
OxiEnd = find(oxygenTimeseries==DateEnd, 1, 'first')+7;%finds index for end of the segment
% same index for the beginning and end of the segment in the "velocities" from ADV
OxDurationi = OxiEnd - OxiStart +1;%duration of the oxFile, mustt be a multiple of 8
VelDurationi  = samplingRatio*OxDurationi;

OxEC = oxygen8Hz(OxiStart:OxiEnd);
OxUP = oxygen8HzUp(OxiStart:OxiEnd);
OxDW = oxygen8HzDw(OxiStart:OxiEnd);
    
    Automate.iStart = iStartSgt ;
    Automate.iEnd = iEndSgt ; 
    Compensation.Firesting.Start = datetime(datetime(campaign_day_string+ ' '+Depl.dateStringCompStart,'Format', 'HH:mm:ss'));
    Compensation.Firesting.End = datetime(datetime(campaign_day_string+ ' '+Depl.dateStringCompEnd,'Format',  'HH:mm:ss'));
    Compensation.Ox.iStart = knnsearch(datenum(oxygenTimeseries),datenum(Compensation.Firesting.Start));
    Compensation.Ox.iEnd = knnsearch(datenum(oxygenTimeseries),datenum(Compensation.Firesting.End))-1;
     
    Automate.velocityFileSegt = Automate.velocityFile{Automate.iStart:Automate.iEnd,2:end};
    
    Automate.velocityZ = Automate.velocityFileSegt(:,9);
    Automate.velocityY = Automate.velocityFileSegt(:,8); 
    Automate.velocityX = Automate.velocityFileSegt(:,7);
      
    Automate.correlationX = Automate.velocityFileSegt(:,18);
    Automate.correlationY = Automate.velocityFileSegt(:,19);
    Automate.correlationZ = Automate.velocityFileSegt(:,20);
    Automate.goodCorrelation = Automate.velocityFileSegt(:,21);
    
    Automate.velocityZPrimeAutomate = Automate.velocityFileSegt(:,5);
    Automate.velocityZThreshold = Automate.velocityFileSegt(1,10);
    
    Automate.velocityZPrimeAutomate = Automate.velocityZPrimeAutomate/1000;
    Automate.velocityZ = Automate.velocityZ/1000; % velocity data was collected in mm/s directly from Depl.and here it is selected and converted in m/s
    Automate.velocityZThreshold = Automate.velocityZThreshold/1000; %w0 selection in the velocity file and converted from cm/s to m/s
    Automate.velocityX = Automate.velocityX/1000;
    Automate.velocityY = Automate.velocityY/1000;
    
    Automate.meanvelocityZ = mean(Automate.velocityZ);
    Automate.stdvelocityZ = std(Automate.velocityZ);
    Automate.meanvelocityX = mean(Automate.velocityX);
    Automate.stdvelocityX = std(Automate.velocityX);
    Automate.meanvelocityY = mean(Automate.velocityY);
    Automate.stdvelocityY = std(Automate.velocityY);
    
    Automate.meanvelocityZPrimeAutomate = mean(Automate.velocityZPrimeAutomate);
    Automate.stdvelocityZPrimeAutomate = std(Automate.velocityZPrimeAutomate);
    
    Automate.meanCourrent = mean(Automate.velocityX);
    Automate.meanCourrentModule = mean(sqrt((Automate.velocityX).^2.+(Automate.velocityY).^2));
    
    Automate.valveUPaction = Automate.velocityFileSegt(:,1);
    Automate.valveDOWNaction = Automate.velocityFileSegt(:,3);
    
%% Interpolation if bad correlation

for i = 1:SgtDuration
    if Automate.goodCorrelation == 1
        Automate.velocityZPrimeAutomate(i) = (Automate.velocityZPrimeAutomate(i-1) + Automate.velocityZPrimeAutomate(i+1))/2;
        Automate.velocityY(i) = (Automate.velocityY(i-1) + Automate.velocityY(i+1))/2;
        Automate.velocityZ(i) = (Automate.velocityZ(i-1) + Automate.velocityZ(i+1))/2;
        Automate.velocityX(i) = (Automate.velocityX(i-1) + Automate.velocityX(i+1))/2;
    end
end
  
%     Firesting.timeOxygenFiresting = Firesting.SelectedDataset{Firesting.iStart:Firesting.iEnd,3}-Firesting.SelectedDataset{Firesting.iStart,3}; %Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
    
%% Plot of Vertical (fluctuations) and Hozizontal Velocities   

REA.stdVelocityZ(iDeployment) = Automate.stdvelocityZ;
REA.stdVelocityZPrimeAutomate(iDeployment) = Automate.stdvelocityZPrimeAutomate;
REA.VelocityThreshold(iDeployment) = Automate.velocityZThreshold;
REA.ConditionValue(iDeployment) = Automate.velocityZThreshold./REA.stdVelocityZ(iDeployment);
% condition de validité

if REA.ConditionValue(iDeployment) < 2
REA.bCoefFit(iDeployment) = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./REA.stdVelocityZ(iDeployment));
REA.Condition(iDeployment) = {'Yes'};


%     Automate.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(Automate.velocityZPrimeAutomate)-1)/Param.ADVSAMPLINGFREQUENCY];
%     figure('Name','REA Vertical velocity fluctuation segment '+string(iDeployment),'NumberTitle','off');
%     plot(Automate.time,Automate.velocityZPrimeAutomate)
%     ylabel('Velocity fluctuation (m.s-^1)')
%     xlabel('Time (s)')
%     set(title({['Vertical velocity Fluctuation segment '+string(iDeployment)]}))
%     a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{['$\bar{w}='+string(Automate.meanvelocityZPrimeAutomate)+'m.s^{-1}$'];...
%         [' $\sigma_{w''}='+string(Automate.stdvelocityZPrimeAutomate)+'m.s^{-1}$'];['$\frac{w_{0}}{\sigma_{w''}}<2 ,b='+string(REA.bCoefFit(iDeployment))+'$']},'FitBoxToText','on', 'Fontsize', 16);
%     %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_vertical_velocity'])


else 
    
%         Automate.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(Automate.velocityZPrimeAutomate)-1)/Param.ADVSAMPLINGFREQUENCY];
%     figure('Name','REA Vertical velocity fluctuation segment '+string(iDeployment),'NumberTitle','off');
%     plot(Automate.time,Automate.velocityZPrimeAutomate)
%     ylabel('Velocity fluctuation (m.s-^1)')
%     xlabel('Time (s)')
%     set(title({['Vertical velocity Fluctuation segment '+string(iDeployment)]}))
%     a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{w}='+string(Automate.meanvelocityZPrimeAutomate)+'m.s^{-1}$'];...
%         [' $\sigma_{w''}='+string(Automate.stdvelocityZPrimeAutomate)+'m.s^{-1}$'];['$\frac{w_{0}}{\sigma_{w''}}<2$']},'FitBoxToText','on', 'Fontsize', 16);
%     %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_vertical_velocity'])

REA.bCoefFit(iDeployment)= 0.6;
REA.Condition(iDeployment)='NO';

end

Automate.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(Automate.velocityZPrimeAutomate)-1)/Param.ADVSAMPLINGFREQUENCY];

    set(0,'CurrentFigure',Automate.velocity.fig1);
    subplot(3,3,iSegment);
    plot(Automate.time,Automate.velocityZ)
    ylabel('(m.s-^1)')
    xlabel('Time (s)')
    set(title('Segment '+string(iDeployment)))


    set(0,'CurrentFigure',Automate.velocityfluc.fig1);
    subplot(3,3,iSegment);
    plot(Automate.time,Automate.velocityZPrimeAutomate)
    ylabel('(m.s-^1)')
    xlabel('Time (s)')
    set(title('Segment '+string(iDeployment)))


% 
%   Automate.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(Automate.velocityZ)-1)/Param.ADVSAMPLINGFREQUENCY];
%     figure('Name','REA Vertical velocity segment '+string(iDeployment),'NumberTitle','off');
%     plot(Automate.time,Automate.velocityZ)
%     ylabel('Velocity (m.s-^1)')
%     xlabel('Time (s)')
%     set(title({['Vertical velocity segment '+string(iDeployment)]}))
%     a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{w}='+string(Automate.meanvelocityZ)+'m.s^{-1}$'];[' $\sigma_{w}='+string(Automate.stdvelocityZ)+'m.s^{-1}$']},'FitBoxToText','on', 'Fontsize', 16);
% 

%     figure('Name','REA Horizontal velocity segment '+string(iDeployment),'NumberTitle','off');
%     plot(Automate.time,Automate.velocityX)
%     ylabel('Velocity (m.s-^1)')
%     xlabel('Time (s)')
%     set(    title({['Horizontal velocity measured during segment '+string(iDeployment)];['$\bar{u}$='+string(Automate.meanvelocityX)];['$\sigma_{u}$='+string(Automate.stdvelocityX)]}),'Interpreter','Latex');
%     title({['Horizontal velocity measured during segment '+string(iDeployment)]});
%     a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{u}='+string(Automate.meanvelocityX)+'m.s^{-1}$'];[' $\sigma_{u}='+string(Automate.stdvelocityX)+'m.s^{-1}$']},'FitBoxToText','on', 'Fontsize', 16);
% 
%     %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_horizontal_velocity'])

%% Selecting velocity from the ADV for comparison

% iStart = find(Automate.velocityFileSegt(1,14:16)/1000==loge02(:,3:5), 1, 'first');
iStart = knnsearch(velocityFile_raw(:,3:5), Automate.velocityFileSegt(1,14:16)/1000);
iEnd = knnsearch(velocityFile_raw(:,3:5), Automate.velocityFileSegt(end,14:16)/1000);
VelADVSgt = velocity_raw_despiked(iStart:iEnd, 1:3);

% Traitement Planar fit 

u=nan(floor(length(VelADVSgt)/Depl.ave),3);
for i=1:floor(length(VelADVSgt)/Depl.ave)
    u(i,1)=nanmean(VelADVSgt((i-1)*Depl.ave+1:i*Depl.ave,1));
    u(i,2)=nanmean(VelADVSgt((i-1)*Depl.ave+1:i*Depl.ave,2));
    u(i,3)=nanmean(VelADVSgt((i-1)*Depl.ave+1:i*Depl.ave,3));
end
H=[length(u) sum(u(:,1)) sum(u(:,2)); sum(u(:,1)) sum(u(:,1).*u(:,1)) sum(u(:,1).*u(:,2)); sum(u(:,2)) sum(u(:,1).*u(:,2)) sum(u(:,2).*u(:,2))];
g=[sum(u(:,3)) sum(u(:,1).*u(:,3)) sum(u(:,2).*u(:,3))];
b=H\g';
p31=-b(2)/sqrt(b(2)^2+b(3)^2+1);
p32=-b(3)/sqrt(b(2)^2+b(3)^2+1);
p33=1/sqrt(b(2)^2+b(3)^2+1);
D=[sqrt(p32^2+p33^2) 0 p31; 0 1 0; -p31 0 sqrt(p32^2+p33^2)];
C=[1 0 0; 0 p33/sqrt(p32^2+p33^2) p32/sqrt(p32^2+p33^2); 0 -p32/sqrt(p32^2+p33^2) p33/sqrt(p32^2+p33^2)];
P=D'*C';
VelADVSgt_PF =(D'*C'*[VelADVSgt(:,1) VelADVSgt(:,2) VelADVSgt(:,3)-b(1)]')';

x = VelADVSgt_PF(:,3);
y = Automate.velocityZ;
b1= Automate.velocityZ'/VelADVSgt_PF(:,3)';
X = [ones(length(x),1) x];
b = X\y;
yCalc1 = b1*x;
yCalc2 = X*b;
 
 Rsq1 = 1 - sum((y - yCalc1).^2)/sum((y - mean(y)).^2);
 Rsq2 = 1 - sum((y - yCalc2).^2)/sum((y - mean(y)).^2);
 
% figure('Name','Reg vertical velocity EC and rEA Segment '+string(iDeployment),'NumberTitle','off');
% scatter(x,y);
% hold on
% plot(x, yCalc1);
% hold on
% plot(x,yCalc2,'--')
% hold on 
% plot(x,x, '-')
% legend('Data','Slope','Slope & Intercept','Location','best');
% xlabel('Vertical velocity EC');
% ylabel('Vertical velocity REA')
% title({'Vertical Velocity comparison between EC and REA Segment '+string(iDeployment)})  
% grid on
% annotation('textbox',[.9 .5 .1 .2],'String',{['r^2 linear = '+string(Rsq1)];['a='+string(b1)];['r^2 affine = '+string(Rsq2)];['a='+string(b(2))];[ ',b=' + string(b(1))]},'EdgeColor','none');
% 
%  
%  VelADV = loge02(iStart-240:iEnd+240,3:5);
%  VelADVPrime = subtract_running_average(VelADV(:,3),Param.RUNNINGAVERAGE);
%  
%   figure('Name','Reg vertical velocity fluctuation EC and REA Segment '+string(iDeployment),'NumberTitle','off');
%  scatter(Automate.velocityZPrimeAutomate,VelADVPrime);
%  xlabel('Vertical velocity fluctuation EC');
%  ylabel('Vertical velocity fluctuation REA')
%  title({'Vertical Velocity fluctuation comparison between EC and REA Segment '+string(iDeployment)})  

 %% oxygen conversion 

for i = 1:SgtDuration;


temperatureSgt = Automate.velocityFile{i,26};
setCalibrationData(probeCalibration.temp0,probeCalibration.temp100, probeCalibration.pressure, ...
    probeCalibration.humidity, probeCalibration.dphi0, probeCalibration.dphi100);
F1 = calculateOxygen(OxEC(i), temperatureSgt, 1020, 0, 'Z');
OxEC(i) = F1(5);

setCalibrationData(probeCalibration.DOWN.temp0,probeCalibration.DOWN.temp100, probeCalibration.DOWN.pressure...
    , probeCalibration.DOWN.humidity, probeCalibration.DOWN.dphi0, probeCalibration.DOWN.dphi100);
F2 = calculateOxygen(OxUP(i), temperatureSgt, 1020, 0, 'Y');
OxUP(i) = F2(5);

setCalibrationData(probeCalibration.UP.temp0,probeCalibration.UP.temp100, probeCalibration.UP.pressure...
    , probeCalibration.UP.humidity, probeCalibration.UP.dphi0, probeCalibration.UP.dphi100);
F3 = calculateOxygen(OxDW(i), temperatureSgt, 1020, 0, 'Y');
OxDW(i) = F3(5);

end


%% Oxygen measurements in the tubes

Firesting.DOWN.timeInterp = time2(OxiStart:OxiEnd);
Firesting.DOWN.oxygenInterp = OxDW ;

Firesting.UP.timeInterp = time2(OxiStart:OxiEnd);
Firesting.UP.oxygenInterp = OxUP ;

Firesting.EC.timeInterp = time2(OxiStart:OxiEnd);
Firesting.EC.oxygenInterp = OxEC ;

REA.valveDOWNactionOxygenTemp = Automate.valveDOWNaction.*OxDW;
REA.valveUPactionOxygenTemp = Automate.valveUPaction.*OxUP;

%UP

REA.valveUPactionOxygenMean(iDeployment) = ((Firesting.UP.oxygenInterp') * Automate.valveUPaction )/ nnz(Automate.valveUPaction);

%DOWN
REA.valveDOWNactionOxygenMean(iDeployment) = ((Firesting.DOWN.oxygenInterp') * Automate.valveDOWNaction )/ nnz(Automate.valveDOWNaction);

%% Compensation

Compensation.Firesting.DOWN.oxygenCompensated = oxygen8HzDw(Compensation.Ox.iStart:Compensation.Ox.iEnd);
Compensation.Firesting.UP.oxygenCompensated = oxygen8HzUp(Compensation.Ox.iStart:Compensation.Ox.iEnd);

Compensation.Firesting.DOWN.oxygenCompensatedMean = nanmean(Compensation.Firesting.DOWN.oxygenCompensated);
Compensation.Firesting.UP.oxygenCompensatedMean = nanmean(Compensation.Firesting.UP.oxygenCompensated);
Compensation.concDiff = Compensation.Firesting.UP.oxygenCompensatedMean-Compensation.Firesting.DOWN.oxygenCompensatedMean;
REA.Compensation(iDeployment) = Compensation.concDiff;

%% Calculating oxygen fluxes by REA no delay is applied

REA.oxyDifConcCompensated = REA.valveUPactionOxygenMean-REA.valveDOWNactionOxygenMean-Compensation.concDiff;%previously Allopen.ConcDiff was subtracted 
REA.OxyFlux(iDeployment) = (REA.bCoefFit(iDeployment)*REA.stdVelocityZPrimeAutomate(iDeployment)*REA.oxyDifConcCompensated(iDeployment))*24*3600/1000; %mmol/m2/day

%% %% EC for comparison 

w_Mean(iDeployment) = mean(velocities(OxiStart:OxiEnd,3));
w_Std(iDeployment) = std(velocities(OxiStart:OxiEnd,3));


%% flux calculation, synchro and ogive, velocities

%% plot of correlation and ogive
if iDeployment < 10
    set(0,'CurrentFigure',CorrelationFig1);
    subplot(3,3,iDeployment);
else 
    set(0,'CurrentFigure',CorrelationFig2);
    subplot(3,3,iDeployment-9);
end
[~, velocityZPrime_TimeShift, oxygenPrime_TimeShift, FluxesShifted(iDeployment,2), FluxesNoShifted(1,iDeployment), ~, ~, ~, bestPValue(iDeployment), pValues{1, iDeployment}, timeShift_List{1, iDeployment}, timeShift(iDeployment)] ...
     = segment_time_shift_EC( Param,Time, Automate.velocityZ, OxEC, 1);% PFsynchronization of oxygen over velocity for EC flux calculation
%   print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iDeployment),'_','_synchro'])
% set(gcf,'name','time shifts and p-value for min/max correlation with velocity','numbertitle','off')
h1=get(gca, 'title');
origtitle=get(h1,'string');
a = 'Segment ' +string(iDeployment);
origtitle = [ a, origtitle' ];
set(h1,'String',[origtitle])

   [~, ~, ~,~,...
        ecOgiveOxygen, ~, ~]= ...
    segment_fluxes_ogives4(velocityZPrime_TimeShift, oxygenPrime_TimeShift, oxygenPrime_TimeShift,oxygenPrime_TimeShift,0,  ...
    0.75*std(Automate.stdvelocityZ), 1, 1,Param.NFREQUENCYFFT, Param.ADVSAMPLINGFREQUENCY, Param.RUNNINGAVERAGE);%calculating the ogive

if iDeployment < 10
    set(0,'CurrentFigure',OgiveFig1);
    subplot(3,3,iDeployment);
else 
    set(0,'CurrentFigure',OgiveFig2);
    subplot(3,3,iDeployment-9);
end
[EC.segFrequency, fig] = segment_subplots_loge(Param,ecOgiveOxygen,ecOgiveOxygen);%ploting the ogive

h1=get(gca, 'title');
origtitle=get(h1,'string');
a = 'Segment ' +string(iDeployment);
origtitle = [ a, origtitle ];
set(h1,'String',[origtitle])

%% Plot of segment mean cumulated flux N

[OxFluxCumulated_sgt, OxFluxInst_sgt, time]= ...
    cumulative_ecflux(velocityZPrime_TimeShift, oxygenPrime_TimeShift, Param.ADVSAMPLINGFREQUENCY, SgtDuration);

% OxFluxCumulated = cat(1,OxFluxCumulated,OxFluxCumulated_sgt);
OxFluxCumulated(OxiStart:OxiEnd)= OxFluxCumulated_sgt;

OxFluxMeanCumulated_sgt=zeros(length(OxFluxInst_sgt),1);
OxFluxInstSum_sgt = 0;
for j =1:length(OxFluxInst_sgt)
    OxFluxInstSum_sgt = OxFluxInstSum_sgt + OxFluxInst_sgt(j);
    OxFluxMeanCumulated_sgt(j) = OxFluxInstSum_sgt/j;
end

if iSegment < 10
    set(0,'CurrentFigure',FluxCumFig1);
    subplot(3,3,iSegment);
else 
    set(0,'CurrentFigure',FluxCumFig2);
    subplot(3,3,iSegment-9);
end
    x = time(1:length(OxFluxMeanCumulated_sgt));
    y = OxFluxMeanCumulated_sgt;
    plot(x,y);
    ylabel('(mmol/m^2)');
    xlabel('Time');
    title('Segment ' +string(iSegment),Depl.figTitle);


end

%% Plot of Fluxes and Cumulated fluxes N

figure('Name','EC O2 Fluxes'+Depl.figName,'NumberTitle','off');
segmentsTimestamps = oxygenTimeseries(1+VelDurationi/2:VelDurationi:VelDurationi*Depl.nbSegments+VelDurationi/2);
x = segmentsTimestamps;
y = FluxesShifted(:,2);
bar(x,y);
barvalues;
ylabel('O_2 Fluxes (mmol/m^2/d)');
xlabel('Time');
title('O_2 Fluxes for Eddy Covariance',Depl.figTitle)
a1 = annotation('textbox',[.9 .5 .1 .2],'String','Planar Fit','EdgeColor','none');

figure('Name','EC O_2 Cumulated Fluxes','NumberTitle','off');
x = oxygenTimeseries;
y = OxFluxCumulated;
plot(x,y);
ylabel('O_2 Cumulated Fluxes (mmol/m^2)');
xlabel('Time');
title('EC O_2 Cumulated Fluxes')




%% REA flux and tables

w_Mean(14)= wAligned_Mean;
w_Std(14)= wAligned_Std;
FluxesShifted(14,2)= mean(FluxesShifted(:,2));
timeShift = timeShift/Param.ADVSAMPLINGFREQUENCY; %conversion to seconds

Para = {'Segment 1';'Segment 2';'Segment 3';'Segment 4';'Segment 5';'Segment 6';'Segment 7';'Segment 8';'Segment 9';'Segment 10';'Segment 11';'Segment 12';'Segment 13';'campaign'}
% Para = {'Segment 1';'Segment 2';'Segment 3';'Segment 4';'Segment 5';'Segment 6';'Segment 7';'Segment 8';'Segment 9';'Segment 10';'Segment 11';'Segment 12';'campaign'}
% Para = {'Segment 1';'Segment 2';'Segment 3';'Segment 4';'Segment 5';'Segment 6';'campaign'}
TEC = table(w_Mean, w_Std, FluxesShifted(:,2),'RowNames',Para);
TEC.Properties.VariableNames = {'Mean W'  'W Std' 'Flux'}


% Get the table in string form.
TECString = evalc('disp(TEC)');
% Use TeX Markup for bold formatting and underscores.
TECString = strrep(TECString,'<strong>','\bf');
TECString = strrep(TECString,'</strong>','\rm');
TECString = strrep(TECString,'_','\_');
% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');
% Output the table using the annotation command.
figure('Name','Details for EC'+ Depl.figName,'NumberTitle','off');
annotation(gcf,'Textbox','String',TECString,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);

Parameters = {'Segment 1';'Segment 2';'Segment 3';'Segment 4';'Segment 5';'Segment 6';'Segment 7';'Segment 8'}
TREA = table(REA.VelocityThreshold', REA.stdVelocityZ',REA.ConditionValue', REA.Condition', REA.bCoefFit',REA.OxyFlux','RowNames',Parameters);
TREA.Properties.VariableNames = {'W_0' 'Wstd' 'W_0/Wstd' 'Condition Validity' 'b Coeff' 'Flux'}


% Get the table in string form.
TREAString = evalc('disp(TREA)');
% Use TeX Markup for bold formatting and underscores.
TREAString = strrep(TREAString,'<strong>','\bf');
TREAString = strrep(TREAString,'</strong>','\rm');
TREAString = strrep(TREAString,'_','\_');
% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');
% Output the table using the annotation command.
figure('Name','Details for REA'+Depl.figName,'NumberTitle','off');
annotation(gcf,'Textbox','String',TREAString,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);

figure('Name','REA O2 Fluxes'+Depl.figName,'NumberTitle','off');
x =[1 : length(REA.OxyFlux)];
y = REA.OxyFlux;
bar(x,y);
barvalues;
title('O_2 Fluxes REA',Depl.figTitle)
ylabel('O_2 Fluxes (mmol/m^2/d)');
xlabel('Time');
a1 = annotation('textbox',[.9 .5 .1 .2],'String','Planar Fit','EdgeColor','none');

% SaveAllFigures('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/new');

% figHandles = findall(groot, 'Type', 'figure');
% for f=figHandles 
%     fullfig(f);
% end


    
