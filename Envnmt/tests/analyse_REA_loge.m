clear all
close all

Param = load_parameters;

%% Upload Oxygen

[rudelaloge1]=uploading_firesting_2020('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/202010429_loge_1.txt'); %uploading file created by oxymeter for the segment
[rudelaloge2]=uploading_firesting_2020('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/202010429_loge_2.txt'); %uploading file created by oxymeter for the segment

%% upload velocity
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

%% date upload

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

%% selecting oxygen duration 

tLoge1Hour = datetime(tLoge1(:,1),'Format','HH:mm:ss');
tLoge2Hour = datetime(tLoge2(:,1),'Format','HH:mm:ss');

Oxygenhour1 = datetime(datetime(dayString+ ' '+string(rudelaloge1{1:end,2})), 'Format','HH:mm:ss');% time vector in 4Hz for oxygen measurements
Oxygenhour2 = datetime(datetime(dayString+ ' '+string(rudelaloge2{1:end,2})), 'Format','HH:mm:ss');
startLoge01 = max(tLoge1Hour(1), Oxygenhour1(4)); %finds the latest starts between velocity and oxygen
startLoge02 = max(tLoge2Hour(1), Oxygenhour2(4));
OxyiStartLoge01 = knnsearch(datenum(Oxygenhour1),datenum(startLoge01)); %finds the index for beginning of the segment in the time vector
OxyiStartLoge02 = knnsearch(datenum(Oxygenhour2),datenum(startLoge02));


endLoge01 = min(tLoge1Hour(end), Oxygenhour1(end-3)); %finds the earliest end between velocity and oxygen
endLoge02 = min(tLoge2Hour(end), Oxygenhour2(end-3));
OxyiEndLoge01 = knnsearch(datenum(Oxygenhour1),datenum(endLoge01))-1; %finds the index for end of the segment in the time vector
OxyiEndLoge02 = knnsearch(datenum(Oxygenhour2),datenum(endLoge02))-1;
OxDuration1 = OxyiEndLoge01-OxyiStartLoge01+1;
OxDuration2 = OxyiEndLoge02-OxyiStartLoge02+1;

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


%% Selecting velocity data period

Velocitiesloge1 = loge01(VeliStartLoge01:VeliEndLoge01,3:5);
Velocitiesloge2 = loge02(VeliStartLoge02:VeliEndLoge02,3:5);
u1 = Velocitiesloge2;

%% Velocity despiking

[u1(:,1), ~] = func_despike_phasespace3d(u1(:,1), 0, 2);
[u1(:,2), ~] = func_despike_phasespace3d(u1(:,2), 0, 2);
[u1(:,3), ~] = func_despike_phasespace3d(u1(:,3), 0, 2);

%% Oxygen despiking 

[oxygen, ~] = func_despike_phasespace3d(rudelaloge2{:,7}, 0, 2);


%% oxygen interpolation for whole campaign
timestepOxygen1 = rudelaloge1{OxyiStartLoge01:OxyiEndLoge01,3}-rudelaloge1{OxyiStartLoge01,3}; %Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
timestepVelocity1 = timingLoge1(VeliStartLoge01:VeliEndLoge01)-timingLoge1(VeliStartLoge01);
oxygen4Hz1 = rudelaloge1{OxyiStartLoge01:OxyiEndLoge01,7};

 [time1,oxygeninterp1] = interpolation_field_loge(timestepVelocity1,oxygen4Hz1,timestepOxygen1);
 oxygeninterp1 = oxygeninterp1';
 
 timestepOxygen2 = rudelaloge2{OxyiStartLoge02:OxyiEndLoge02,3}-rudelaloge2{OxyiStartLoge02,3}; %Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
timestepVelocity2 = timingLoge2(VeliStartLoge02:VeliEndLoge02)-timingLoge2(VeliStartLoge02);
oxygen4Hz2 = rudelaloge2{OxyiStartLoge02:OxyiEndLoge02,7};

 [time2,oxygeninterp2] = interpolation_field_loge(timestepVelocity2,oxygen4Hz2,timestepOxygen2);
  oxygeninterp2 = oxygeninterp2';
  
  
%% temperature interpolation
temp_0 = [9.8,12 ]; %initial and final temperature during the day
Temprt = interp1([1,VeliDuration2],temp_0,1:VeliDuration2,'linear')';

%% oxygen conversion from Dphi to mmol

setCalibrationData(18, 18, 1020, 100, 51.265, 22.843);

for i = 1:VeliDuration2;
    F4 = calculateOxygen(oxygeninterp2(i), Temprt(i), 1020, 0, 'Z');
    oxygeninterp2(i) = F4(5);
end


%% uploading csv files for REA

LogeBrut1 = readtable('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/21-04-29_111635.csv');

%time selection of segment
iStartrunningAvg = find(LogeBrut1{:,7}~=0, 1, 'first');
iStarthour = find(LogeBrut1{:,1}==LogeBrut1{iStartrunningAvg,1}, 1, 'first');
iStartSgt = iStarthour + (floor((iStartrunningAvg-iStarthour)/8)+1)*8;
StartSgtSecond = floor((iStartrunningAvg-iStarthour)/8)+1;

iEndhour = find(LogeBrut1{:,1}==LogeBrut1{end,1}, 1, 'first');
iEndSgt = iEndhour + floor((length(LogeBrut1{:,1})-iEndhour)/8)*8-1;
EndSgtSecond = floor((length(LogeBrut1{:,1})-iEndhour)/8);
SgtDuration = iEndSgt - iStartSgt+1;

DateStart = datetime(datetime(dayString+ ' '+string(datetime(LogeBrut1{iStarthour,1},'Format', 'HH:mm'))+':'+StartSgtSecond), 'Format', 'HH:mm:ss');
DateEnd = datetime(datetime(dayString+ ' '+string(datetime(LogeBrut1{iEndhour,1},'Format', 'HH:mm'))+':'+EndSgtSecond), 'Format', 'HH:mm:ss');

%select oxygen duration

OxyiStartLogei = find(Oxygenhour2==DateStart, 1, 'first');
OxyiEndLogei = find(Oxygenhour2==DateEnd, 1, 'last');
stdz = std(LogeBrut1{iStartSgt:iEndSgt,10});


%% oxygen interpolation for REA segments
VeliStartLogei =iStartSgt;
VeliEndLogei = iEndSgt;

timestepOxygeni = rudelaloge2{OxyiStartLogei:OxyiEndLogei,3}-rudelaloge2{OxyiStartLogei,3}; %Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
timestepVelocityi = timingLoge1(VeliStartLogei:VeliEndLogei)-timingLoge1(VeliStartLogei);
oxygen4HzEC = rudelaloge2{OxyiStartLogei:OxyiEndLogei,7};
oxygen4HzDW = rudelaloge2{OxyiStartLogei:OxyiEndLogei,6};
oxygen4HzUP = rudelaloge2{OxyiStartLogei:OxyiEndLogei,8};

 [timei,oxygenECinterpi] = interpolation_field_loge(timestepVelocityi,oxygen4HzEC,timestepOxygeni);
 oxygenECinterpi = oxygenECinterpi';
 
 [~,oxygenDWinterpi] = interpolation_field_loge(timestepVelocityi,oxygen4HzDW,timestepOxygeni);
 oxygenDWinterpi = oxygenDWinterpi';
 
 [~,oxygenUPinterpi] = interpolation_field_loge(timestepVelocityi,oxygen4HzUP,timestepOxygeni);
 oxygenUPinterpi = oxygenUPinterpi';
 
%% oxygen conversion 

setCalibrationData(18.602,17.947, 1020, 100, 52.352, 21.65);

for i = 1:SgtDuration;

F1 = calculateOxygen(rudelaloge2{i,7}, LogeBrut1{VeliStartLogei+i-1,26}, 1020, 0, 'Z');
oxygenECinterpi(i) = F1(5);

F2 = calculateOxygen(rudelaloge2{i,6}, LogeBrut1{VeliStartLogei+i-1,26}, 1020, 0, 'Y');
oxygenDWinterpi(i) = F2(5);

F3 = calculateOxygen(rudelaloge2{i,8}, LogeBrut1{VeliStartLogei+i-1,26}, 1020, 0, 'Y');
oxygenUPinterpi(i) = F3(5);

end

%% UP & DW treatment

%UP
UpValve = LogeBrut1{VeliStartLogei:VeliEndLogei,2};
UpOxmean = ((oxygenUPinterpi') * UpValve )/ nnz(UpValve);

%DOWN
DwValve = LogeBrut1{VeliStartLogei:VeliEndLogei,4};
DwOxmean = ((oxygenDWinterpi') * DwValve )/ nnz(DwValve);

%% Compensation computation

initiationduration = 40 %seconds
startinitation1 = {'10:53:07'};
StartIni = datetime(datetime(dayString+ ' '+startinitation1),'Format', 'HH:mm:ss')
endinitation1 = {'10:53:47'};
EndIni = datetime(datetime(dayString+ ' '+endinitation1),'Format', 'HH:mm:ss')

%select oxygen duration

OxyiStartLogeIni = knnsearch(datenum(Oxygenhour2),datenum(StartIni));
OxyiEndLogeIni = knnsearch(datenum(Oxygenhour2),datenum(EndIni))-1;
OxDurationIni = OxyiEndLogeIni - OxyiStartLogeIni +1;

%% oxygen interpolation for initiation segment
VeliStartLogeIni =iStartSgt;
VeliEndLogeIni = iEndSgt;

timestepOxygenini = 0:1/Param.ADVSAMPLINGFREQUENCY:(OxDurationIni/Param.ADVSAMPLINGFREQUENCY);%Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
timestepOxygenini(end)=[];
timestepVelocityini = 0:1/Param.ADVSAMPLINGFREQUENCY:(OxDurationIni*2/Param.ADVSAMPLINGFREQUENCY);
timestepVelocityini(end)=[];
oxygen4HzECini = rudelaloge2{OxyiStartLogeIni:OxyiEndLogeIni,7};
oxygen4HzDWini = rudelaloge2{OxyiStartLogeIni:OxyiEndLogeIni,6};
oxygen4HzUPini = rudelaloge2{OxyiStartLogeIni:OxyiEndLogeIni,8};

 [timeini,oxygenECinterpini] = interpolation_field_loge(timestepVelocityini,oxygen4HzECini,timestepOxygenini);
 oxygenECinterpini = oxygenECinterpini';
 
 [~,oxygenDWinterpini] = interpolation_field_loge(timestepVelocityini,oxygen4HzDWini,timestepOxygenini);
 oxygenDWinterpini = oxygenDWinterpini';
 
 [~,oxygenUPinterpini] = interpolation_field_loge(timestepVelocityini,oxygen4HzUPini,timestepOxygenini);
 oxygenUPinterpini = oxygenUPinterpini';
 
%% oxygen conversion 

setCalibrationData(18.602,17.947, 1020, 100, 52.352, 21.65);

for i = 1:SgtDuration;

F = calculateOxygen(rudelaloge2{i,7}, LogeBrut1{VeliStartLogeIni+i-1,26}, 1020, 0, 'Z');
oxygenECinterpini(i) = F(5);

F = calculateOxygen(rudelaloge2{i,6}, LogeBrut1{VeliStartLogeIni+i-1,26}, 1020, 0, 'Y');
oxygenDWinterpini(i) = F(5);

F = calculateOxygen(rudelaloge2{i,8}, LogeBrut1{VeliStartLogeIni+i-1,26}, 1020, 0, 'Y');
oxygenUPinterpini(i) = F(5);

end


%% UP & DW treatment

UpOxcomp = nanmean(oxygenUPinterpini);
DwOxcomp = nanmean(oxygenDWinterpini);
Oxcomp = UpOxcomp - DwOxcomp;

%% Result

if max(0.0029/stdz) < 2
%REA.bCoefFit = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./REA.stdVelocityZ);%!!!
REA.bCoefFit = 0.144 + (0.627-0.144)*exp(-1.04*0.0029/stdz);%!!!

else 
REA.bCoefFit = NaN;  
end
F = REA.bCoefFit*stdz*(UpOxmean-DwOxmean-Oxcomp);

%% Oxygen plot

Oxygen = zeros((length(oxygeninterp2(:,1))),1);
 
 Oxygen(1:length(oxygeninterp2)) = oxygeninterp2;
 
 tLoge = (startLoge02:seconds(1/Param.ADVSAMPLINGFREQUENCY):endLoge02)';
 tLoge(end)=[];
 
 figure('Name','O2 Concentration','NumberTitle','off');plot(tLoge,Oxygen)
 ylabel('[O_2] (mmol.m^-^3)')
 title({'O_2 Concentration'})    


% Oxygen = zeros((length(oxygeninterp1(:,1))),1);
%  
%  Oxygen(1:length(oxygeninterp1)) = oxygeninterp1;
%  
%  tLoge = (startLoge01:seconds(1/Param.ADVSAMPLINGFREQUENCY):endLoge01)';
%  
%   
%  figure;plot(tLoge,Oxygen)
%  ylabel('Oxygen concentration (mmol.m^-^3)')

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
ave=480/2;
u=nan(floor(length(u1segm(:,1))/ave),3*QuantityofSegts);

for j=1:QuantityofSegts
    
for i=1:floor(length(u1segm(:,1))/ave)
    u(i,1+(j-1)*3)=nanmean(u1segm((i-1)*ave+1:i*ave,1+(j-1)*3));
    u(i,2+(j-1)*3)=nanmean(u1segm((i-1)*ave+1:i*ave,2+(j-1)*3));
    u(i,3+(j-1)*3)=nanmean(u1segm((i-1)*ave+1:i*ave,3+(j-1)*3));
end

H=[length(u) sum(u(:,1+(j-1)*3)) sum(u(:,2+(j-1)*3)); sum(u(:,1+(j-1)*3)) sum(u(:,1+(j-1)*3).*u(:,1+(j-1)*3)) sum(u(:,1+(j-1)*3).*u(:,2+(j-1)*3)); sum(u(:,2+(j-1)*3)) sum(u(:,1+(j-1)*3).*u(:,2+(j-1)*3)) sum(u(:,2+(j-1)*3).*u(:,2+(j-1)*3))];
g=[sum(u(:,3+(j-1)*3)) sum(u(:,1+(j-1)*3).*u(:,3+(j-1)*3)) sum(u(:,2+(j-1)*3).*u(:,3+(j-1)*3))];
b=H\g';
p31=-b(2)/sqrt(b(2)^2+b(3)^2+1);
p32=-b(3)/sqrt(b(2)^2+b(3)^2+1);
p33=1/sqrt(b(2)^2+b(3)^2+1);
D=[sqrt(p32^2+p33^2) 0 p31; 0 1 0; -p31 0 sqrt(p32^2+p33^2)];
C=[1 0 0; 0 p33/sqrt(p32^2+p33^2) p32/sqrt(p32^2+p33^2); 0 -p32/sqrt(p32^2+p33^2) p33/sqrt(p32^2+p33^2)];
P=D'*C';
u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,1:3)=(D'*C'*[u1segm(:,1+(j-1)*3) u1segm(:,2+(j-1)*3) u1segm(:,3+(j-1)*3)-b(1)]')';
a=atan2(nanmean(u4(:,2)), nanmean(u4(:,1)));    %rotation around z-axis
u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,1)=u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)*cos(a)+u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)*sin(a);
u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)=-u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)*sin(a)+u4(1+iSegmentDuration*(j-1):iSegmentDuration*j,2)*cos(a);

end


figure('Name','Vertical Velocity','NumberTitle','off')
timew = tLoge(VeliStartLoge01:iSegmentDuration*QuantityofSegts+VeliStartLoge01-1);
plot(timew, u4(:,3));
xlabel('Time');
ylabel('Vertical Velocity w after PF)');



%% flux calculation, synchro and ogive

Time = 0:1/8:length(u2(:,1))/8;

for i = 1:QuantityofSegts

[~, velocityZPrime_TimeShift, oxygenPrime_TimeShift, FluxesShifted(i,2), FluxesNoShifted(1,i), ~, ~, ~, ~, ~] ...
     = segment_time_shift_EC( Param,Time, u4(1+iSegmentDuration*(i-1):iSegmentDuration*i,3), Oxygen4EC(:,i), 1);% PFsynchronization of oxygen over velocity for EC flux calculation
%   print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro'])
set(gcf,'name','Correlation Segment '+string(i),'numbertitle','off')

   [~, ~, ~,~,...
        ecOgiveOxygen, ~, ~]= ...
    segment_fluxes_ogives3(velocityZPrime_TimeShift, oxygenPrime_TimeShift, oxygenPrime_TimeShift,oxygenPrime_TimeShift,0,  ...
    0.75*std(velocityZPrime_TimeShift), 1, 1,Param.NFREQUENCYFFT, Param.ADVSAMPLINGFREQUENCY, Param.RUNNINGAVERAGE);%calculating the ogive

[EC.segFrequency, fig] = segment_plots_loge(Param,ecOgiveOxygen,ecOgiveOxygen);%ploting the ogive
set(gcf,'name','Ogive Segment '+string(i),'numbertitle','off')

end

spectrum_gui(u1(:,3));

figure('Name','O_2 Fluxes','NumberTitle','off');
x = tLoge(1+iSegmentDuration/2:iSegmentDuration:iSegmentDuration*QuantityofSegts+iSegmentDuration/2);
y = FluxesShifted(:,2);
bar(x,y);
barvalues;
ylabel('O_2 Fluxes (mmol/m^2/d)');
xlabel('Time');
a1 = annotation('textbox',[.9 .5 .1 .2],'String','Planar Fit','EdgeColor','none');

% SaveAllFigures('/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/Loge2904/Figures');





