%% 11/05/2021
% Script for EC and REA calculations at Ru de la Loge for summer camapign
% v0 Clément 



clear all;
close all;

 
Param = load_parameters;   % to define constant parameters

%% Importing Oxygen dataset and parameters for calibration
[Firesting.CompleteDataset]=uploading_firesting_2020('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/202010429_loge_2.txt'); %uploading file created by oxymeter for the segment at 4Hz
Firesting.rawOxygen = Firesting.CompleteDataset{:,7};
Firesting.rawOxygenUP = Firesting.CompleteDataset{:,8};
Firesting.rawOxygenDOWN = Firesting.CompleteDataset{:,6};

[rudelaloge1]=uploading_firesting_2020('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/202010429_loge_1.txt'); %uploading file created by oxymeter for the segment
[rudelaloge2]=uploading_firesting_2020('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/202010429_loge_2.txt'); %uploading file created by oxymeter for the segment


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
filename = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/loge104.dat';
formatSpec = '%5f%6f%9f%9f%9f%6f%6f%6f%7f%7f%7f%6f%6f%6f%8f%6f%6f%f%[^\n\r]';

fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
loge01 = [dataArray{1:end-1}];
clearvars filename formatSpec fileID dataArray ans;

filename = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/loge203.dat';

formatSpec = '%5f%6f%9f%9f%9f%6f%6f%6f%7f%7f%7f%6f%6f%6f%8f%6f%6f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
loge02 = [dataArray{1:end-1}];

clearvars filename formatSpec fileID dataArray ans;

%% date upload for EC

filename = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/loge104.sen';
formatSpec = '%2f%3f%5f%3f%3f%3f%9f%9f%6f%7f%6f%6f%6f%7f%6f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);

dateLoge1 = [dataArray{1:end-1}];
clearvars filename formatSpec fileID dataArray ans;

filename = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/loge203.sen';
formatSpec = '%2f%3f%5f%3f%3f%3f%9f%9f%6f%7f%6f%6f%6f%7f%6f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);

dateLoge2 = [dataArray{1:end-1}];
clearvars filename formatSpec fileID dataArray ans;

dayString = string(datetime(dateLoge1(1,3),dateLoge1(1,1), dateLoge1(1,2)));

tStartLoge1 = datetime(dateLoge1(1,3),dateLoge1(1,1), dateLoge1(1,2),dateLoge1(1,4),dateLoge1(1,5),dateLoge1(1,6));
tEndLoge1 = datetime(dateLoge1(end,3),dateLoge1(end,1), dateLoge1(end,2),dateLoge1(end,4),dateLoge1(end,5),dateLoge1(end,6));

tLoge1 = (tStartLoge1:seconds(1/Param.ADVSAMPLINGFREQUENCY):tEndLoge1)';

tStartLoge2 = datetime(dateLoge2(1,3),dateLoge2(1,1), dateLoge2(1,2),dateLoge2(1,4),dateLoge2(1,5),dateLoge2(1,6));
tEndLoge2 = datetime(dateLoge2(end,3),dateLoge2(end,1), dateLoge2(end,2),dateLoge2(end,4),dateLoge2(end,5),dateLoge2(end,6));

tLoge2 = (tStartLoge2:seconds(1/Param.ADVSAMPLINGFREQUENCY):tEndLoge2)';

tLoge1(end)=[];
tLoge2(end)=[];

clearvars tStartLoge1 tEndLoge1 tStartLoge2 tEndLoge2

timingLoge1 = 0:1/Param.ADVSAMPLINGFREQUENCY:length(tLoge1)/Param.ADVSAMPLINGFREQUENCY;
timingLoge2 = 0:1/Param.ADVSAMPLINGFREQUENCY:length(tLoge2)/Param.ADVSAMPLINGFREQUENCY;

timingLoge1(end)=[];
timingLoge2(end)=[];

%% selecting oxygen duration for EC

tLoge1Hour = datetime(tLoge1(:,1),'Format','HH:mm:ss');
tLoge2Hour = datetime(tLoge2(:,1),'Format','HH:mm:ss');

Oxygenhour1 = datetime(datetime(dayString+ ' '+string(rudelaloge1{1:end,2})), 'Format','HH:mm:ss');% time vector in 4Hz for oxygen measurements
Oxygenhour2 = datetime(datetime(dayString+ ' '+string(rudelaloge2{1:end,2})), 'Format','HH:mm:ss');
startLoge01 = max(tLoge1Hour(1), Oxygenhour1(4)); %finds the latest starts between velocity and oxygen
startLoge02 = max(tLoge2Hour(1), Oxygenhour2(4));
OxiStartLoge01 = knnsearch(datenum(Oxygenhour1),datenum(startLoge01)); %finds the index for beginning of the measure in the time vector
OxiStartLoge02 = knnsearch(datenum(Oxygenhour2),datenum(startLoge02));


endLoge01 = min(tLoge1Hour(end), Oxygenhour1(end-3)); %finds the earliest end between velocity and oxygen
endLoge02 = min(tLoge2Hour(end), Oxygenhour2(end-3));
OxiEndLoge01 = knnsearch(datenum(Oxygenhour1),datenum(endLoge01))-1; %finds the index for end of the measure in the time vector
OxiEndLoge02 = knnsearch(datenum(Oxygenhour2),datenum(endLoge02))-1;
OxDuration1 = OxiEndLoge01-OxiStartLoge01+1;
OxDuration2 = OxiEndLoge02-OxiStartLoge02+1;

VeliStartLoge01 = 1;
if tLoge1Hour(1) < startLoge01
    VeliStartLoge01 = seconds(Oxygenhour1(4) - tLoge1Hour(1))*8;
end

VeliEndLoge01 = VeliStartLoge01 + OxDuration1*2 - 1 ; %
VeliDuration1 = OxDuration1*2;

VeliStartLoge02 = 1;

if tLoge2Hour(1) < startLoge02
    VeliStartLoge02 = seconds(Oxygenhour2(4) - tLoge2Hour(1))*8;
end

VeliEndLoge02 = VeliStartLoge02 + OxDuration2*2 - 1; %
VeliDuration2 = OxDuration2*2;

% end of selecting oxygen duration for EC

%% Selecting velocity data period for EC

Velocitiesloge1 = loge01(VeliStartLoge01:VeliEndLoge01,3:5);
Velocitiesloge2 = loge02(VeliStartLoge02:VeliEndLoge02,3:5);
u1 = Velocitiesloge2;
u1_initiation = Velocitiesloge1;

%% Velocity despiking for EC

[u1(:,1), ~] = func_despike_phasespace3d(u1(:,1), 0, 2);
[u1(:,2), ~] = func_despike_phasespace3d(u1(:,2), 0, 2);
[u1(:,3), ~] = func_despike_phasespace3d(u1(:,3), 0, 2);

[u1_initiation(:,1), ~] = func_despike_phasespace3d(u1_initiation(:,1), 0, 2);
[u1_initiation(:,2), ~] = func_despike_phasespace3d(u1_initiation(:,2), 0, 2);
[u1_initiation(:,3), ~] = func_despike_phasespace3d(u1_initiation(:,3), 0, 2);

%% Oxygen despiking 

[oxygen4Hz1, ~] = func_despike_phasespace3d(rudelaloge1{:,7}, 0, 2);

[oxygen4Hz2, ~] = func_despike_phasespace3d(rudelaloge2{:,7}, 0, 2);
[oxygen4HzUp, ~] = func_despike_phasespace3d(rudelaloge2{:,8}, 0, 2);
[oxygen4HzDw, ~] = func_despike_phasespace3d(rudelaloge2{:,6}, 0, 2);


%% oxygen interpolation for whole campaign
timestepOxygen1 = rudelaloge1{OxiStartLoge01:OxiEndLoge01,3}-rudelaloge1{OxiStartLoge01,3}; %Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
timestepVelocity1 = timingLoge1(VeliStartLoge01:VeliEndLoge01)-timingLoge1(VeliStartLoge01);
oxygen4Hz1 = oxygen4Hz1(OxiStartLoge01:OxiEndLoge01);

 [time1,oxygeninterp1] = interpolation_field_loge(timestepVelocity1,oxygen4Hz1,timestepOxygen1);
 oxygeninterp1 = oxygeninterp1';
 
 timestepOxygen2 = rudelaloge2{OxiStartLoge02:OxiEndLoge02,3}-rudelaloge2{OxiStartLoge02,3}; %Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
timestepVelocity2 = timingLoge2(VeliStartLoge02:VeliEndLoge02)-timingLoge2(VeliStartLoge02);
oxygen4Hz2 = oxygen4Hz2(OxiStartLoge02:OxiEndLoge02);
oxygen4HzUp = oxygen4HzUp(OxiStartLoge02:OxiEndLoge02);
oxygen4HzDw = oxygen4HzDw(OxiStartLoge02:OxiEndLoge02);

 [time2,oxygeninterp2] = interpolation_field_loge(timestepVelocity2,oxygen4Hz2,timestepOxygen2);
  oxygeninterp2 = oxygeninterp2';
  
  [~,oxygeninterp2Up] = interpolation_field_loge(timestepVelocity2,oxygen4HzUp,timestepOxygen2);
  oxygeninterp2Up = oxygeninterp2Up';
  
  [~,oxygeninterp2Dw] = interpolation_field_loge(timestepVelocity2,oxygen4HzDw,timestepOxygen2);
  oxygeninterp2Dw = oxygeninterp2Dw';
  
  
%% temperature interpolation for EC
temp_0 = [9.8,12 ]; %initial and final temperature during the day
Temprt = interp1([1,VeliDuration2],temp_0,1:VeliDuration2,'linear')';

%% oxygen conversion from Dphi to mmol for whole campaign

setCalibrationData(probeCalibration.temp0, probeCalibration.temp100, probeCalibration.pressure, probeCalibration.humidity, probeCalibration.dphi0, probeCalibration.dphi100);

for i = 1:VeliDuration2;
    F4 = calculateOxygen(oxygeninterp2(i), Temprt(i), 1020, 0, 'Z');
    oxygeninterp2(i) = F4(5);
end

%% Oxygen plot

Oxygen = zeros((length(oxygeninterp2(:,1))),1);
 
 Oxygen(1:length(oxygeninterp2)) = oxygeninterp2;
 
 tLoge = (startLoge02:seconds(1/Param.ADVSAMPLINGFREQUENCY):endLoge02)';
 tLoge(end)=[];
 
 figure('Name','O2 Concentration','NumberTitle','off');plot(tLoge,Oxygen)
 ylabel('[O_2] (mmol.m^-^3)')
 title({'O_2 Concentration'})    

 
Velocities = loge02(VeliStartLoge02:VeliEndLoge02,3:5);
u1 = Velocities;

%% O2 segmentation in 20 minutes files

segmentDuration = 15;%minutes
iSegmentDuration = segmentDuration*60*8;%measurements at 8 Hz

QuantityofSegts = floor((length(Oxygen)/iSegmentDuration)); 



for i = 1:QuantityofSegts
    
    Oxygen4EC(:,i) = Oxygen(1+(i-1)*iSegmentDuration:i*iSegmentDuration);
   
end


%% Velocity segmentation

QuantityofSegts = floor((length(u1(:,3))/iSegmentDuration));
u1segm = zeros(iSegmentDuration,3*QuantityofSegts);

for i = 1:QuantityofSegts
    
    u1segm(:,(i-1)*3+1:3*i) = u1(1+(i-1)*iSegmentDuration:i*iSegmentDuration,:);
   
end


%% Double axis rotation

% u2 = zeros(length(u1(:,3)),3);
u2 = zeros(iSegmentDuration,3*QuantityofSegts)

%%Planar fit

% planar fit (PF)
ave=800;
% u=nan(floor(length(u1segm(:,1))/ave),3*QuantityofSegts);

% for j=1:QuantityofSegts
    
% for i=1:floor(length(u1segm(:,1))/ave)
%     u(i,1+(j-1)*3)=nanmean(u1segm((i-1)*ave+1:i*ave,1+(j-1)*3));
%     u(i,2+(j-1)*3)=nanmean(u1segm((i-1)*ave+1:i*ave,2+(j-1)*3));
%     u(i,3+(j-1)*3)=nanmean(u1segm((i-1)*ave+1:i*ave,3+(j-1)*3));
% end

% H=[length(u) sum(u(:,1+(j-1)*3)) sum(u(:,2+(j-1)*3)); sum(u(:,1+(j-1)*3)) sum(u(:,1+(j-1)*3).*u(:,1+(j-1)*3)) sum(u(:,1+(j-1)*3).*u(:,2+(j-1)*3)); sum(u(:,2+(j-1)*3)) sum(u(:,1+(j-1)*3).*u(:,2+(j-1)*3)) sum(u(:,2+(j-1)*3).*u(:,2+(j-1)*3))];
% g=[sum(u(:,3+(j-1)*3)) sum(u(:,1+(j-1)*3).*u(:,3+(j-1)*3)) sum(u(:,2+(j-1)*3).*u(:,3+(j-1)*3))];
% b=H\g';
% p31=-b(2)/sqrt(b(2)^2+b(3)^2+1);
% p32=-b(3)/sqrt(b(2)^2+b(3)^2+1);
% p33=1/sqrt(b(2)^2+b(3)^2+1);
% D=[sqrt(p32^2+p33^2) 0 p31; 0 1 0; -p31 0 sqrt(p32^2+p33^2)];
% C=[1 0 0; 0 p33/sqrt(p32^2+p33^2) p32/sqrt(p32^2+p33^2); 0 -p32/sqrt(p32^2+p33^2) p33/sqrt(p32^2+p33^2)];
% P=D'*C';
% u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,1:3)=(D'*C'*[u1segm(:,1+(j-1)*3) u1segm(:,2+(j-1)*3) u1segm(:,3+(j-1)*3)-b(1)]')';
% a=atan2(nanmean(u4(:,2)), nanmean(u4(:,1)));    %rotation around z-axis
% u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,1)=u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)*cos(a)+u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)*sin(a);
% u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)=-u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)*sin(a)+u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)*cos(a);
% 
% end


%% Planar Fit 

u=nan(floor(length(u1)/ave),3);
for i=1:floor(length(u1)/ave)
    u(i,1)=nanmean(u1((i-1)*ave+1:i*ave,1));
    u(i,2)=nanmean(u1((i-1)*ave+1:i*ave,2));
    u(i,3)=nanmean(u1((i-1)*ave+1:i*ave,3));
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
u5=(D'*C'*[u1(:,1) u1(:,2) u1(:,3)-b(1)]')';
a=atan2(nanmean(u5(:,2)), nanmean(u5(:,1)));    %rotation around z-axis
u5(:,1)=u5(:,1)*cos(a)+u5(:,2)*sin(a);
u5(:,2)=-u5(:,1)*sin(a)+u5(:,2)*cos(a);

%% Plot of Velocities and spectres

figure('Name','Raw Vertical Velocity ','NumberTitle','off')
% timew = tLoge(VeliStartLoge01:iSegmentDuration*QuantityofSegts+VeliStartLoge01-1);
plot(tLoge, u1(:,3));
xlabel('Time');
ylabel('Raw Vertical Velocity )');
title('Raw Vertical Velocity ');


meanW = mean(u5(:,3));
stdW = std(u5(:,3));
figure('Name','Vertical Velocity Aligned','NumberTitle','off')
% timew = tLoge(VeliStartLoge01:iSegmentDuration*QuantityofSegts+VeliStartLoge01-1);
plot(tLoge, u5(:,3));
xlabel('Time');
ylabel('Vertical Velocity w after PF)');
title('Vertical Velocity Aligned by PF');
a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{w}='+string(meanW)+'m.s^{-1}$'];[' $\sigma_{w}='+string(stdW)+'m.s^{-1}$']},'FitBoxToText','on', 'Fontsize', 16);

WFluctuation = subtract_running_average(u5(:,3), Param.RUNNINGAVERAGE);
meanWFluctuation = mean(WFluctuation);
stdWFluctuation = std(WFluctuation);
figure('Name','Vertical Velocity Fluctuation','NumberTitle','off')
% timew = tLoge(VeliStartLoge01:iSegmentDuration*QuantityofSegts+VeliStartLoge01-1);
plot(tLoge(1:length(WFluctuation)), WFluctuation);
xlabel('Time');
ylabel('Vertical Velocity Fluctuation)');
title('Vertical Velocity Fluctuation');
a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{w''}='+string(meanW)+'m.s^{-1}$'];[' $\sigma_{w''}='+string(stdW)+'m.s^{-1}$']},'FitBoxToText','on', 'Fontsize', 16);


%effects of alignement on the spectrums
spectrum_gui(u1(:,3));
spectrum_gui(u5(:,3));
spectrum_gui(Oxygen4Hz2);


%% flux calculation, synchro and ogive

Time = 0:1/8:length(u2(:,1))/8;
OxFluxCumuluated= [];
OxFluxInst= [];

for iSegment = 1:QuantityofSegts
    
velocityZPrime = subtract_running_average(u5(1+iSegmentDuration*(iSegment-1):iSegmentDuration*iSegment,3), Param.RUNNINGAVERAGE)
oxygenPrime = subtract_running_average( Oxygen4EC(:,iSegment), Param.RUNNINGAVERAGE)
ecFluxOxygen = mean(velocityZPrime.*oxygenPrime)*3600*24;
FluxesShifted(iSegment,1) = ecFluxOxygen;

% [~, velocityZPrime_TimeShift, oxygenPrime_TimeShift, FluxesShifted(iSegment,2), FluxesNoShifted(1,iSegment), ~, ~, ~, ~, ~] ...
%      = segment_time_shift_EC( Param,Time, u5(1+iSegmentDuration*(iSegment-1):iSegmentDuration*iSegment,3), Oxygen4EC(:,iSegment), 1);% PFsynchronization of oxygen over velocity for EC flux calculation
% %   print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro'])
% set(gcf,'name','Correlation Segment '+string(iSegment),'numbertitle','off')
% h1=get(gca, 'title');
% origtitle=get(h1,'string');
% a = 'Segment ' +string(iSegment);
% origtitle{3} = a;
% set(h1,'String',[origtitle])

   [~, ~, ~,~,...
        ecOgiveOxygen, ~, ~]= ...
    segment_fluxes_ogives3(velocityZPrime, oxygenPrime, oxygenPrime,oxygenPrime,0,  ...
    0.75*std(velocityZPrime), 1, 1,Param.NFREQUENCYFFT, Param.ADVSAMPLINGFREQUENCY, Param.RUNNINGAVERAGE);%calculating the ogive


[EC.segFrequency, fig] = segment_plots_loge(Param,ecOgiveOxygen,ecOgiveOxygen);%ploting the ogive
set(gcf,'name','Ogive Segment '+string(iSegment),'numbertitle','off')

h1=get(gca, 'title');
origtitle=get(h1,'string');
a = 'Segment ' +string(iSegment);
origtitle{3} = a;
set(h1,'String',[origtitle])
Time = 0:1/8:length(u2(:,1))/8;
OxFluxCumuluated= [];
OxFluxInst= [];


%% Plot of segment mean cumulated flux 

[OxFluxCumuluated_sgt, OxFluxInst_sgt, time]= ...
    cumulative_ecflux(velocityZPrime_TimeShift, oxygenPrime_TimeShift, Param.ADVSAMPLINGFREQUENCY, length(Time));

OxFluxCumuluated = cat(1,OxFluxCumuluated,OxFluxCumuluated_sgt);

OxFluxMeanCumulated_sgt=zeros(length(OxFluxInst_sgt),1);
OxFluxInstSum_sgt = 0;
for j =1:length(OxFluxInst_sgt)
    OxFluxInstSum_sgt = OxFluxInstSum_sgt + OxFluxInst_sgt(j);
    OxFluxMeanCumulated_sgt(j) = OxFluxInstSum_sgt/j;
end

    figure('Name','O_2 Mean cumulated flux segment ' + string(iSegment),'NumberTitle','off');
    x = time(1:length(OxFluxMeanCumulated_sgt));
    y = OxFluxMeanCumulated_sgt;
    plot(x,y);
    ylabel('O_2 Mean cumulated Fluxes (mmol/m^2)');
    xlabel('Time');
    title({['O_2 Mean cumulated Fluxes'];['Segment ' + string(iSegment)]});





end


%% Plot of Fluxes and Cumulated fluxes

figure('Name','O_2 Fluxes without synchro','NumberTitle','off');
x = tLoge(1+iSegmentDuration/2:iSegmentDuration:iSegmentDuration*QuantityofSegts+iSegmentDuration/2);
y = FluxesShifted(:,1);
bar(x,y);
barvalues;
ylabel('O_2 Fluxes (mmol/m^2/d)');
xlabel('Time');
title('O_2 Fluxes for Eddy Covariance without synchro')
a1 = annotation('textbox',[.9 .5 .1 .2],'String','Planar Fit','EdgeColor','none');

figure('Name','O_2 Cumulated Fluxes','NumberTitle','off');
x = tLoge(1:length(Time)*QuantityofSegts);
y = OxFluxCumuluated;
plot(x,y);
ylabel('O_2 Cumulated Fluxes (mmol/m^2)');
xlabel('Time');
title('O_2 Cumulated Fluxes for Eddy Covariance')




% SaveAllFigures('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/Figures');

%% %% REA 

for iDeployment = 1:8; %Choose the segment to be analyzed

iSegment = iDeployment;

Depl = deployment_parameter_loge_clem( iDeployment, Param );%selecting parameters for each segment


%% Uploading velocity dataset and selecting parameters and durations 
   
% Import the velocity data
Automate.velocityFile = readtable(Depl.velocityfile);
  
    % New version for matlab 2020
    
    
    %time selection of segment
iStartrunningAvg = find(Automate.velocityFile{:,7}~=0, 1, 'first');
iStarthour = find(Automate.velocityFile{:,1}==Automate.velocityFile{iStartrunningAvg,1}, 1, 'first');
iStartSgt = iStarthour + (floor((iStartrunningAvg-iStarthour+1)/8)+1)*8;
StartSgtSecond = floor((iStartrunningAvg-iStarthour+1)/8)+1;

iEndhour = find(Automate.velocityFile{:,1}==Automate.velocityFile{end,1}, 1, 'first');
iEndSgt = iEndhour + floor((length(Automate.velocityFile{:,1})-iEndhour+1)/8)*8-1;
SgtDuration = iEndSgt - iStartSgt+1;
iEndSgt = iStartSgt + floor(SgtDuration/8)*8 -1 ;
EndSgtSecond = floor((length(Automate.velocityFile{:,1})-iEndhour+1)/8)-1;
SgtDuration = iEndSgt - iStartSgt+1;

DateStart = datetime(datetime(dayString+ ' '+string(datetime(Automate.velocityFile{iStarthour,1},'Format', 'HH:mm'))+':'+StartSgtSecond), 'Format', 'HH:mm:ss');
DateEnd = datetime(datetime(dayString+ ' '+string(datetime(Automate.velocityFile{iEndhour,1},'Format', 'HH:mm'))+':'+EndSgtSecond), 'Format', 'HH:mm:ss');

%select oxygen duration

OxiStart = find(Oxygenhour2==DateStart, 1, 'first');
OxiEnd = find(Oxygenhour2==DateEnd, 1, 'last');
OxDurationi = OxiEnd - OxiStart +1;
stdz = std(Automate.velocityFile{iStartSgt:iEndSgt,10});

OxEC = oxygeninterp2(((OxiStart-1)*2)+1:OxiEnd*2);
OxUP = oxygeninterp2Up(((OxiStart-1)*2)+1:OxiEnd*2);
OxDW = oxygeninterp2Dw(((OxiStart-1)*2)+1:OxiEnd*2);
    
    Automate.iStart = iStartSgt ;
    Automate.iEnd = iEndSgt ; 
    Compensation.Firesting.Start = datetime(datetime(dayString+ ' '+Depl.dateStringCompStart,'Format', 'HH:mm:ss'));
    Compensation.Firesting.End = datetime(datetime(dayString+ ' '+Depl.dateStringCompEnd,'Format',  'HH:mm:ss'));
    Compensation.Ox.iStart = knnsearch(datenum(Oxygenhour2),datenum(Compensation.Firesting.Start));
    Compensation.Ox.iEnd = knnsearch(datenum(Oxygenhour2),datenum(Compensation.Firesting.End))-1;
     
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
    
    Automate.meanvelocityZ = mean(Automate.velocityZ)
    Automate.stdvelocityZ = std(Automate.velocityZ)
    Automate.meanvelocityX = mean(Automate.velocityX)
    Automate.stdvelocityX = std(Automate.velocityX)
    Automate.meanvelocityY = mean(Automate.velocityY)
    Automate.stdvelocityY = std(Automate.velocityY)
    
    Automate.meanvelocityZPrimeAutomate = mean(Automate.velocityZPrimeAutomate)
    Automate.stdvelocityZPrimeAutomate = std(Automate.velocityZPrimeAutomate)
    
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

REA.stdVelocityZ(iDeployment) = std(Automate.velocityZPrimeAutomate);
%REA.stdVelocityZ = std(ECsegt.VelocityZAligned);
REA.VelocityThreshold(iDeployment) = Automate.velocityZThreshold;

% condition de validité

if max(Automate.velocityZThreshold./REA.stdVelocityZ) < 2
%REA.bCoefFit = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./REA.stdVelocityZ);%!!!
REA.bCoefFit(iDeployment) = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./REA.stdVelocityZ(iDeployment));%!!!
Condition{iDeployment} = 'Yes';


    Automate.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(Automate.velocityZPrimeAutomate)-1)/Param.ADVSAMPLINGFREQUENCY];
    figure('Name','Vertical velocity fluctuation segment '+string(iDeployment),'NumberTitle','off');
    plot(Automate.time,Automate.velocityZPrimeAutomate)
    ylabel('Velocity fluctuation (m.s-^1)')
    xlabel('Time (s)')
    set(title({['Vertical velocity Fluctuation segment '+string(iDeployment)]}))
    a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{['$\bar{w}='+string(Automate.meanvelocityZPrimeAutomate)+'m.s^{-1}$'];...
        [' $\sigma_{w''}='+string(Automate.stdvelocityZPrimeAutomate)+'m.s^{-1}$'];['$\frac{w_{0}}{\sigma_{w''}}<2 ,b='+string(REA.bCoefFit(iDeployment))+'$']},'FitBoxToText','on', 'Fontsize', 16);
    %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_vertical_velocity'])


else 
    
        Automate.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(Automate.velocityZPrimeAutomate)-1)/Param.ADVSAMPLINGFREQUENCY];
    figure('Name','Vertical velocity fluctuation segment '+string(iDeployment),'NumberTitle','off');
    plot(Automate.time,Automate.velocityZPrimeAutomate)
    ylabel('Velocity fluctuation (m.s-^1)')
    xlabel('Time (s)')
    set(title({['Vertical velocity Fluctuation segment '+string(iDeployment)]}))
    a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{w}='+string(Automate.meanvelocityZPrimeAutomate)+'m.s^{-1}$'];...
        [' $\sigma_{w''}='+string(Automate.stdvelocityZPrimeAutomate)+'m.s^{-1}$'];['$\frac{w_{0}}{\sigma_{w''}}<2$']},'FitBoxToText','on', 'Fontsize', 16);
    %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_vertical_velocity'])

REA.bCoefFit(iDeployment)= 0.6;
Condition{iDeployment}='NO';

end


  Automate.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(Automate.velocityZ)-1)/Param.ADVSAMPLINGFREQUENCY];
    figure('Name','Vertical velocity segment '+string(iDeployment),'NumberTitle','off');
    plot(Automate.time,Automate.velocityZ)
    ylabel('Velocity (m.s-^1)')
    xlabel('Time (s)')
    set(title({['Vertical velocity segment '+string(iDeployment)]}))
    a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{w}='+string(Automate.meanvelocityZ)+'m.s^{-1}$'];[' $\sigma_{w}='+string(Automate.stdvelocityZ)+'m.s^{-1}$']},'FitBoxToText','on', 'Fontsize', 16);


    figure('Name','Horizontal velocity segment '+string(iDeployment),'NumberTitle','off');
    plot(Automate.time,Automate.velocityX)
    ylabel('Velocity (m.s-^1)')
    xlabel('Time (s)')
    set(    title({['Horizontal velocity measured during segment '+string(iDeployment)];['$\bar{u}$='+string(Automate.meanvelocityX)];['$\sigma_{u}$='+string(Automate.stdvelocityX)]}),'Interpreter','Latex');
    title({['Horizontal velocity measured during segment '+string(iDeployment)]});
    a = annotation('textbox',[0.2 0.55 0.3 0.3],'interpreter','latex','String',{ ['$\bar{u}='+string(Automate.meanvelocityX)+'m.s^{-1}$'];[' $\sigma_{u}='+string(Automate.stdvelocityX)+'m.s^{-1}$']},'FitBoxToText','on', 'Fontsize', 16);

    %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_horizontal_velocity'])


    
%% Selecting velocity from the ADV for comparison

% iStart = find(Automate.velocityFileSegt(1,14:16)/1000==loge02(:,3:5), 1, 'first');
iStart = knnsearch(loge02(:,3:5), Automate.velocityFileSegt(1,14:16)/1000);
iEnd = knnsearch(loge02(:,3:5), Automate.velocityFileSegt(end,14:16)/1000);
VelADVSgt = loge02(iStart:iEnd, 3:5);

% Traitement Planar fit 

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
 
 figure('Name','Reg vertical velocity EC and rEA Segment '+string(iDeployment),'NumberTitle','off');
 scatter(x,y);
hold on
plot(x, yCalc1);
hold on
plot(x,yCalc2,'--')
hold on 
plot(x,x, '-')
legend('Data','Slope','Slope & Intercept','Location','best');
 xlabel('Vertical velocity EC');
 ylabel('Vertical velocity REA')
 title({'Vertical Velocity comparison between EC and REA Segment '+string(iDeployment)})  
 grid on
 annotation('textbox',[.9 .5 .1 .2],'String',{['r^2 linear = '+string(Rsq1)];['a='+string(b1)];['r^2 affine = '+string(Rsq2)];['a='+string(b(2))];[ ',b=' + string(b(1))]},'EdgeColor','none');

 
 VelADV = loge02(iStart-240:iEnd+240,3:5);
 VelADVPrime = subtract_running_average(VelADV(:,3),Param.RUNNINGAVERAGE);
 
  figure('Name','Reg vertical velocity fluctuation EC and REA Segment '+string(iDeployment),'NumberTitle','off');
 scatter(Automate.velocityZPrimeAutomate,VelADVPrime);
 xlabel('Vertical velocity fluctuation EC');
 ylabel('Vertical velocity fluctuation REA')
 title({'Vertical Velocity fluctuation comparison between EC and REA Segment '+string(iDeployment)})  

 %% oxygen conversion 


for i = 1:SgtDuration;

setCalibrationData(probeCalibration.temp0,probeCalibration.temp100, probeCalibration.pressure, probeCalibration.humidity, probeCalibration.dphi0, probeCalibration.dphi100);
F1 = calculateOxygen(OxEC(i), Automate.velocityFile{i,26}, 1020, 0, 'Z');
OxEC(i) = F1(5);

setCalibrationData(probeCalibration.DOWN.temp0,probeCalibration.DOWN.temp100, probeCalibration.DOWN.pressure, probeCalibration.DOWN.humidity, probeCalibration.DOWN.dphi0, probeCalibration.DOWN.dphi100);
F2 = calculateOxygen(OxUP(i), Automate.velocityFile{i,26}, 1020, 0, 'Y');
OxUP(i) = F2(5);

setCalibrationData(probeCalibration.UP.temp0,probeCalibration.UP.temp100, probeCalibration.UP.pressure, probeCalibration.UP.humidity, probeCalibration.UP.dphi0, probeCalibration.UP.dphi100);
F3 = calculateOxygen(OxDW(i), Automate.velocityFile{i,26}, 1020, 0, 'Y');
OxDW(i) = F3(5);

end

%% Oxygen measurements in the tubes

Firesting.DOWN.timeInterp = time2(OxiStart:OxiEnd);
Firesting.DOWN.oxygenInterp = OxDW ;

Firesting.UP.timeInterp = time2(OxiStart:OxiEnd);
Firesting.UP.oxygenInterp = OxUP ;

REA.valveDOWNactionOxygenTemp = Automate.valveDOWNaction.*OxDW;
REA.valveUPactionOxygenTemp = Automate.valveUPaction.*OxUP;

%UP

REA.valveUPactionOxygenMean = ((Firesting.UP.oxygenInterp') * Automate.valveUPaction )/ nnz(Automate.valveUPaction);

%DOWN
REA.valveDOWNactionOxygenMean = ((Firesting.DOWN.oxygenInterp') * Automate.valveDOWNaction )/ nnz(Automate.valveDOWNaction);

%% Compensation


Compensation.Firesting.DOWN.oxygenCompensated = oxygeninterp2Dw(((Compensation.Ox.iStart-1)*2)+1:Compensation.Ox.iEnd*2);
Compensation.Firesting.UP.oxygenCompensated = oxygeninterp2Up(((Compensation.Ox.iStart-1)*2)+1:Compensation.Ox.iEnd*2);

Compensation.Firesting.DOWN.oxygenCompensatedMean = nanmean(Compensation.Firesting.DOWN.oxygenCompensated);
Compensation.Firesting.UP.oxygenCompensatedMean = nanmean(Compensation.Firesting.UP.oxygenCompensated);
Compensation.concDiff = Compensation.Firesting.UP.oxygenCompensatedMean-Compensation.Firesting.DOWN.oxygenCompensatedMean;



% Calculating oxygen fluxes by REA no delay is applied

REA.oxyDifConcCompensated = REA.valveUPactionOxygenMean-REA.valveDOWNactionOxygenMean-Compensation.concDiff;%previously Allopen.ConcDiff was subtracted 

% REA.oxyDifConcEC = REA.valveUPactionECOxygenMean-REA.valveDOWNactionECOxygenMean;%previously Allopen.ConcDiff was subtracted 

% if Automate.velocityZThreshold==0
% REA.bCoef = 0.6;
% end
% 
% if Automate.velocityZThreshold ~=0 
% REA.bCoef = 0.3;
% end

% REA.stdVelocityZ = std(Automate.velocityZPrimeAutomate);
%REA.stdVelocityZ = std(ECsegt.VelocityZAligned);

% % condition de validité
% if max(Automate.velocityZThreshold./REA.stdVelocityZ) < 2
% %REA.bCoefFit = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./REA.stdVelocityZ);%!!!
% REA.bCoefFit = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./REA.stdVelocityZ);%!!!
% 
% else 
% REA.bCoefFit = 0.6;  
% end



REA.OxyFlux(iDeployment) = (REA.bCoefFit(iDeployment)*REA.stdVelocityZ(iDeployment)*REA.oxyDifConcCompensated)*24*3600/1000; %mmol/m2/day

end

Parameters = {'Segment 1';'Segment 2';'Segment 3';'Segment 4';'Segment 5';'Segment 6';'Segment 7';'Segment 8'}
T = table(REA.VelocityThreshold', REA.stdVelocityZ',Condition', REA.bCoefFit',REA.OxyFlux','RowNames',Parameters);
T.Properties.VariableNames = {'W_0' 'W''fluctuation' 'Validity condition' 'b Coeff' 'Flux'}

% Get the table in string form.
TString = evalc('disp(T)');
% Use TeX Markup for bold formatting and underscores.
TString = strrep(TString,'<strong>','\bf');
TString = strrep(TString,'</strong>','\rm');
TString = strrep(TString,'_','\_');
% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');
% Output the table using the annotation command.
figure('Name','Details for REA','NumberTitle','off');
annotation(gcf,'Textbox','String',TString,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);

figure('Name','O_2 Fluxes REA','NumberTitle','off');
x =[1 : length(REA.OxyFlux)];
y = REA.OxyFlux;
bar(x,y);
barvalues;
title('O_2 Fluxes REA')
ylabel('O_2 Fluxes (mmol/m^2/d)');
xlabel('Time');
a1 = annotation('textbox',[.9 .5 .1 .2],'String','Planar Fit','EdgeColor','none');

% SaveAllFigures('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/Figures2904');


