%% 21/06/2021
% Script for EC and REA calculations at Planqua in 2020 over three days,
% 13-14-15/10/2020
% v1 Clément
% The overall goal of this code is to provide a comparison of the O2 fluxes
% between REA and EC on the same segments.
% Time selection of segments are done automatically in the mentioned
% sections.
% The velocities must be taken from the Automate file (.csv) for the EC
% The oxygen data are compiled in the Automate file (.csv) but the
% compensation are only in the .txt 

clear all;
close all;

mydirectory = '../Campagnes/Planaqua2020/';%

set(0, 'defaultFigureUnits', 'normalized', 'defaultFigurePosition', [0 0 1 1]);
set(0,'DefaultFigureVisible','off')

% SEE THESE FUNCTIONS TO KNOW THE PARAMETERS INTRODUCED
Param = load_parameters;   % to define constant parameters
iDeployment = 1; % initialization to retrieve the first parameters from deployment_parameter
Depl = deployment_parameter_planaqua2020( iDeployment, Param ); %selecting deployment parameters for the campaign


%% Importing Oxygen dataset and parameters for calibration

[Firesting.CompleteDataset]=uploading_firesting_2020(Depl.filePathFiresting); %uploading file created by oxymeter for the segment at 4Hz
Firesting.rawOxygen = Firesting.CompleteDataset{:,Depl.ecRow};
Firesting.rawOxygenUP = Firesting.CompleteDataset{:,Depl.upRow};
Firesting.rawOxygenDOWN = Firesting.CompleteDataset{:,Depl.dwRow};

[Firesting.TestDataset]=uploading_firesting_2020(Depl.filePathFirestingCompensation); %uploading file created by oxymeter for the segment

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




%% %% REA 
clear REA Automate


%% Figure introduction
Automate.velocity.fig1 = figure('Name','Automate Vertical Velocities 1'+Depl.figName,'NumberTitle','off');
sgtitle({'Automate Vertical Velocities',Depl.figTitle},'fontweight','bold') 
Automate.velocityfluc.fig1 = figure('Name','Automate Vertical Velocities fluctuation 1'+Depl.figName,'NumberTitle','off');
sgtitle({'Automate Vertical Velocities',Depl.figTitle},'fontweight','bold') 

Automate.velocity.fig2 = figure('Name','Automate Vertical Velocities 2'+Depl.figName,'NumberTitle','off');
sgtitle({'Automate Vertical Velocities',Depl.figTitle},'fontweight','bold') 
Automate.velocityfluc.fig2 = figure('Name','Automate Vertical Velocities fluctuation 2'+Depl.figName,'NumberTitle','off');
sgtitle({'Automate Vertical Velocities',Depl.figTitle},'fontweight','bold') 


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

CorrelationFig2 = figure('Name','Correlation 2','NumberTitle','off');
sgtitle('time shifts and p-value for min-max correlation with velocity','fontweight','bold') 
OgiveFig2 = figure('Name','Ogives 2','NumberTitle','off');
sgtitle('ogives: REA (..) and EC(-) O2','fontweight','bold') 
FluxCumFig2 = figure('Name','EC O2 Mean cumulated flux 2','NumberTitle','off');
sgtitle('EC O2 Mean cumulated flux','fontweight','bold') 

VelFig1 = figure('Name','ADV Vertical Velocities 1'+Depl.figName,'NumberTitle','off');
sgtitle({'ADV Vertical Velocities PF 800 points',Depl.figTitle},'fontweight','bold') 
VelFluFig1 = figure('Name','ADV Vertical Velocities fluctuation 1'+Depl.figName,'NumberTitle','off');
sgtitle({'ADV Vertical Velocities fluctuation 60s running average',Depl.figTitle},'fontweight','bold') 

VelFig2 = figure('Name','ADV Vertical Velocities PF 800 points 2','NumberTitle','off');
sgtitle('ADV Vertical Velocities PF 800 points','fontweight','bold') 
VelFluFig2 = figure('Name','ADV Vertical Velocities fluctuation 2','NumberTitle','off');
sgtitle('ADV Vertical Velocities fluctuation 60s running average','fontweight','bold') 

oxygenPrimeFig1 = figure('Name','Oxygen concentration fluctuation 1'+Depl.figName,'NumberTitle','off');
sgtitle({'Oxygen concentration fluctuation',Depl.figTitle},'fontweight','bold') 

% oxygenPrimeFig2 = figure('Name','Oxygen concentration fluctuation 2','NumberTitle','off');
% sgtitle('Oxygen concentration fluctuation','fontweight','bold') 

% OxFluxCumulated= zeros(length(oxygenTimeseries),1);
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

%% Loop for the different segments

% for iDeployment = 1:Depl.nbSegments; %Choose the segment to be analyzed
iDeployment = 5;

iSegment = iDeployment;
Depl = deployment_parameter_planaqua2020( iDeployment, Param );%selecting deployment parameters for the campaign
[Firesting.CompleteDataset]=uploading_firesting_2020(Depl.filePathFiresting); %uploading file created by oxymeter for the segment at 4Hz
Firesting.rawOxygen = Firesting.CompleteDataset{:,Depl.ecRow};
Firesting.rawOxygenUP = Firesting.CompleteDataset{:,Depl.upRow};
Firesting.rawOxygenDOWN = Firesting.CompleteDataset{:,Depl.dwRow};

[Firesting.TestDataset]=uploading_firesting_2020(Depl.filePathFirestingCompensation); %uploading file created by oxymeter for the segment

oxygen_initiation_timeseries_raw = datetime(datetime(Depl.date+ ' '+string(Firesting.TestDataset{1:end,2})), 'Format','HH:mm:ss');
oxygen_timeseries_raw = datetime(datetime(Depl.date+ ' '+string(Firesting.CompleteDataset{1:end,2})), 'Format','HH:mm:ss');

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

DateStart = datetime(datetime(Depl.date+ ' '+string(datetime(Automate.velocityFile{iStarthourlast,1},'Format', 'HH:mm'))+':'+StartSgtSecond), 'Format', 'HH:mm:ss');
DateEnd = datetime(datetime(Depl.date+ ' '+string(datetime(Automate.velocityFile{iEndhour,1},'Format', 'HH:mm'))+':'+EndSgtSecond), 'Format', 'HH:mm:ss');

%select oxygen duration, same process as in EC

% OxiStart = find(oxygenTimeseries==DateStart, 1, 'first');%finds the index for beginning of the segment,
% OxiEnd = find(oxygenTimeseries==DateEnd, 1, 'first')+7;%finds index for end of the segment
% % same index for the beginning and end of the segment in the "velocities" from ADV
% OxDurationi = OxiEnd - OxiStart +1;%duration of the oxFile, mustt be a multiple of 8
% VelDurationi  = samplingRatio*OxDurationi;

OxiStart = iStartSgt;
OxiEnd = iEndSgt;
OxDurationi = OxiEnd - OxiStart +1;
VelDurationi  = OxDurationi;

% OxEC = oxygen8Hz(OxiStart:OxiEnd);
% OxUP = oxygen8HzUp(OxiStart:OxiEnd);
% OxDW = oxygen8HzDw(OxiStart:OxiEnd);

    
    Automate.iStart = iStartSgt ;
    Automate.iEnd = iEndSgt ; 
    Compensation.Firesting.Start = datetime(datetime(Depl.date+ ' '+Depl.dateStringCompStart,'Format', 'HH:mm:ss'));
    Compensation.Firesting.End = datetime(datetime(Depl.date+ ' '+Depl.dateStringCompEnd,'Format',  'HH:mm:ss'));
    Compensation.Ox.iStart = knnsearch(datenum(oxygen_initiation_timeseries_raw),datenum(Compensation.Firesting.Start));% finds the earliest st
    Compensation.Ox.iEnd = knnsearch(datenum(oxygen_initiation_timeseries_raw),datenum(Compensation.Firesting.End))-1;
     
    Automate.velocityFileSegt = Automate.velocityFile{Automate.iStart:Automate.iEnd,2:end};
    
    Automate.velocityZ = Automate.velocityFileSegt(:,9);
    Automate.velocityY = Automate.velocityFileSegt(:,8); 
    Automate.velocityX = Automate.velocityFileSegt(:,7);
    
    Automate.velocityRAW = Automate.velocityFileSegt(:,13:15);
      
    Automate.correlationX = Automate.velocityFileSegt(:,18);
    Automate.correlationY = Automate.velocityFileSegt(:,19);
    Automate.correlationZ = Automate.velocityFileSegt(:,20);
    Automate.goodCorrelation = Automate.velocityFileSegt(:,21);
    
    Automate.velocityZPrimeAutomate = Automate.velocityFileSegt(:,5);
    Automate.velocityZThreshold = Automate.velocityFileSegt(1,10);
    
    
% CONVERSION FROM mm/s TO m/s if needed
    Automate.velocityZPrimeAutomate = Automate.velocityZPrimeAutomate/1000;
    Automate.velocityZ = Automate.velocityZ/1000; % velocity data was collected in mm/s directly from Depl.and here it is selected and converted in m/s
    Automate.velocityZThreshold = Automate.velocityZThreshold/1000; %w0 selection in the velocity file and converted from mm/s to m/s
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
    
OxEC = Automate.velocityFileSegt(:,23);
OxUP = Automate.velocityFileSegt(:,22);
OxDW = Automate.velocityFileSegt(:,24);


%% Double Axis Rotation on Raw Data from the Automate
% % double rotation (DR) in u2
% a=atan2(nanmean(u1segm(:,(i-1)*3+2)), nanmean(u1segm(:,1+3*(i-1))));    %rotation around z-axis
% u2(:,1+3*(i-1))=u1segm(:,1+3*(i-1))*cos(a)+u1segm(:,2+3*(i-1))*sin(a);
% u2(:,2+3*(i-1))=-u1segm(:,1+3*(i-1))*sin(a)+u1segm(:,2+3*(i-1))*cos(a);
% 
% a=atan2(nanmean(u1segm(:,3*i)), nanmean(u2(:,1+3*(i-1))));   %rotation around y-axis
% u2(:,3*i)=-u2(:,1+3*(i-1))*sin(a)+u1segm(:,3*i)*cos(a);
% u2(:,1+3*(i-1))=u2(:,1+3*(i-1))*cos(a)+u1segm(:,3*i)*sin(a);
    
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
REA.stdvelocityZPrimeAutomate(iDeployment)= Automate.stdvelocityZPrimeAutomate;
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
REA.Condition(iDeployment)={'NO'};

end

Automate.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(Automate.velocityZPrimeAutomate)-1)/Param.ADVSAMPLINGFREQUENCY];

if iDeployment < 10
    set(0,'CurrentFigure',Automate.velocity.fig1);
    subplot(3,3,iSegment);
else
    set(0,'CurrentFigure',Automate.velocity.fig2);
    subplot(3,3,iSegment-9);
end
    plot(Automate.time,Automate.velocityZ)
    ylabel('(m.s-^1)')
    xlabel('Time (s)')
    set(title('Segment '+string(iDeployment)))


if iDeployment < 10
    set(0,'CurrentFigure',Automate.velocityfluc.fig1);
    subplot(3,3,iSegment);
else
    set(0,'CurrentFigure',Automate.velocityfluc.fig2);
    subplot(3,3,iSegment-9);
end
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
% 
% % iStart = find(Automate.velocityFileSegt(1,14:16)/1000==loge02(:,3:5), 1, 'first');
% iStart = knnsearch(velocityFile_raw(:,3:5), Automate.velocityFileSegt(1,14:16)/1000);
% iEnd = knnsearch(velocityFile_raw(:,3:5), Automate.velocityFileSegt(end,14:16)/1000);
% VelADVSgt = velocity_raw_despiked(iStart:iEnd, 1:3);
% 
% % Traitement Planar fit 
% 
% u=nan(floor(length(VelADVSgt)/Depl.ave),3);
% for i=1:floor(length(VelADVSgt)/Depl.ave)
%     u(i,1)=nanmean(VelADVSgt((i-1)*Depl.ave+1:i*Depl.ave,1));
%     u(i,2)=nanmean(VelADVSgt((i-1)*Depl.ave+1:i*Depl.ave,2));
%     u(i,3)=nanmean(VelADVSgt((i-1)*Depl.ave+1:i*Depl.ave,3));
% end
% H=[length(u) sum(u(:,1)) sum(u(:,2)); sum(u(:,1)) sum(u(:,1).*u(:,1)) sum(u(:,1).*u(:,2)); sum(u(:,2)) sum(u(:,1).*u(:,2)) sum(u(:,2).*u(:,2))];
% g=[sum(u(:,3)) sum(u(:,1).*u(:,3)) sum(u(:,2).*u(:,3))];
% b=H\g';
% p31=-b(2)/sqrt(b(2)^2+b(3)^2+1);
% p32=-b(3)/sqrt(b(2)^2+b(3)^2+1);
% p33=1/sqrt(b(2)^2+b(3)^2+1);
% D=[sqrt(p32^2+p33^2) 0 p31; 0 1 0; -p31 0 sqrt(p32^2+p33^2)];
% C=[1 0 0; 0 p33/sqrt(p32^2+p33^2) p32/sqrt(p32^2+p33^2); 0 -p32/sqrt(p32^2+p33^2) p33/sqrt(p32^2+p33^2)];
% P=D'*C';
% VelADVSgt_PF =(D'*C'*[VelADVSgt(:,1) VelADVSgt(:,2) VelADVSgt(:,3)-b(1)]')';
% 
% x = VelADVSgt_PF(:,3);
% y = Automate.velocityZ;
% b1= Automate.velocityZ'/VelADVSgt_PF(:,3)';
% X = [ones(length(x),1) x];
% b = X\y;
% yCalc1 = b1*x;
% yCalc2 = X*b;
%  
%  Rsq1 = 1 - sum((y - yCalc1).^2)/sum((y - mean(y)).^2);
%  Rsq2 = 1 - sum((y - yCalc2).^2)/sum((y - mean(y)).^2);
%  
% % figure('Name','Reg vertical velocity EC and rEA Segment '+string(iDeployment),'NumberTitle','off');
% % scatter(x,y);
% % hold on
% % plot(x, yCalc1);
% % hold on
% % plot(x,yCalc2,'--')
% % hold on 
% % plot(x,x, '-')
% % legend('Data','Slope','Slope & Intercept','Location','best');
% % xlabel('Vertical velocity EC');
% % ylabel('Vertical velocity REA')
% % title({'Vertical Velocity comparison between EC and REA Segment '+string(iDeployment)})  
% % grid on
% % annotation('textbox',[.9 .5 .1 .2],'String',{['r^2 linear = '+string(Rsq1)];['a='+string(b1)];['r^2 affine = '+string(Rsq2)];['a='+string(b(2))];[ ',b=' + string(b(1))]},'EdgeColor','none');
% % 
% %  
% %  VelADV = loge02(iStart-240:iEnd+240,3:5);
% %  VelADVPrime = subtract_running_average(VelADV(:,3),Param.RUNNINGAVERAGE);
% %  
% %   figure('Name','Reg vertical velocity fluctuation EC and REA Segment '+string(iDeployment),'NumberTitle','off');
% %  scatter(Automate.velocityZPrimeAutomate,VelADVPrime);
% %  xlabel('Vertical velocity fluctuation EC');
% %  ylabel('Vertical velocity fluctuation REA')
% %  title({'Vertical Velocity fluctuation comparison between EC and REA Segment '+string(iDeployment)})  

 %% oxygen conversion 

for i = 1:SgtDuration;

setCalibrationData(probeCalibration.temp0,probeCalibration.temp100, probeCalibration.pressure, ...
    probeCalibration.humidity, probeCalibration.dphi0, probeCalibration.dphi100);
F1 = calculateOxygen(OxEC(i), Automate.velocityFile{i,26}, 1020, 0, 'Z');
OxEC(i) = F1(5);

setCalibrationData(probeCalibration.DOWN.temp0,probeCalibration.DOWN.temp100, probeCalibration.DOWN.pressure...
    , probeCalibration.DOWN.humidity, probeCalibration.DOWN.dphi0, probeCalibration.DOWN.dphi100);
F2 = calculateOxygen(OxUP(i), Automate.velocityFile{i,26}, 1020, 0, 'Y');
OxUP(i) = F2(5);

setCalibrationData(probeCalibration.UP.temp0,probeCalibration.UP.temp100, probeCalibration.UP.pressure...
    , probeCalibration.UP.humidity, probeCalibration.UP.dphi0, probeCalibration.UP.dphi100);
F3 = calculateOxygen(OxDW(i), Automate.velocityFile{i,26}, 1020, 0, 'Y');
OxDW(i) = F3(5);

end

%% Oxygen measurements in the tubes

% Firesting.DOWN.timeInterp = time2(OxiStart:OxiEnd);
Firesting.DOWN.oxygenInterp = OxDW ;

% Firesting.UP.timeInterp = time2(OxiStart:OxiEnd);
Firesting.UP.oxygenInterp = OxUP ;
% 
% Firesting.EC.timeInterp = time2(OxiStart:OxiEnd);
Firesting.EC.oxygenInterp = OxEC ;

REA.valveDOWNactionOxygenTemp = Automate.valveDOWNaction.*OxDW;
REA.valveUPactionOxygenTemp = Automate.valveUPaction.*OxUP;

%UP

REA.valveUPactionOxygenMean(iDeployment) = ((Firesting.UP.oxygenInterp') * Automate.valveUPaction )/ nnz(Automate.valveUPaction);

%DOWN
REA.valveDOWNactionOxygenMean(iDeployment) = ((Firesting.DOWN.oxygenInterp') * Automate.valveDOWNaction )/ nnz(Automate.valveDOWNaction);

%% Compensation

Compensation.Firesting.DOWN.oxygenCompensated = Firesting.rawOxygenUP(Compensation.Ox.iStart:Compensation.Ox.iEnd);
Compensation.Firesting.UP.oxygenCompensated = Firesting.rawOxygenDOWN(Compensation.Ox.iStart:Compensation.Ox.iEnd);

for i = 1:length(Compensation.Firesting.DOWN.oxygenCompensated)
setCalibrationData(probeCalibration.DOWN.temp0,probeCalibration.DOWN.temp100, probeCalibration.DOWN.pressure...
    , probeCalibration.DOWN.humidity, probeCalibration.DOWN.dphi0, probeCalibration.DOWN.dphi100);
F2 = calculateOxygen(Compensation.Firesting.DOWN.oxygenCompensated(i), Automate.velocityFile{i,26}, 1020, 0, 'Y');
Compensation.Firesting.DOWN.oxygenCompensated(i) = F2(5);

setCalibrationData(probeCalibration.UP.temp0,probeCalibration.UP.temp100, probeCalibration.UP.pressure...
    , probeCalibration.UP.humidity, probeCalibration.UP.dphi0, probeCalibration.UP.dphi100);
F3 = calculateOxygen(Compensation.Firesting.UP.oxygenCompensated(i), Automate.velocityFile{i,26}, 1020, 0, 'Y');
Compensation.Firesting.UP.oxygenCompensated(i) = F3(5);

end

Compensation.Firesting.DOWN.oxygenCompensatedMean = nanmean(Compensation.Firesting.DOWN.oxygenCompensated);
Compensation.Firesting.UP.oxygenCompensatedMean = nanmean(Compensation.Firesting.UP.oxygenCompensated);
Compensation.concDiff = Compensation.Firesting.UP.oxygenCompensatedMean-Compensation.Firesting.DOWN.oxygenCompensatedMean;
REA.Compensation(iDeployment) = Compensation.concDiff;

%% Calculating oxygen fluxes by REA no delay is applied

REA.oxyDifConcCompensated = REA.valveUPactionOxygenMean-REA.valveDOWNactionOxygenMean-Compensation.concDiff;%previously Allopen.ConcDiff was subtracted 
REA.OxyFlux(iDeployment) = (REA.bCoefFit(iDeployment)*REA.stdvelocityZPrimeAutomate(iDeployment)*REA.oxyDifConcCompensated(iDeployment))*24*3600/1000; %mmol/m2/day

%% %% EC for comparison 

% w_Mean(iDeployment) = mean(velocities(OxiStart:OxiEnd,3));
% w_Std(iDeployment) = std(velocities(OxiStart:OxiEnd,3));


%% flux calculation, synchro and ogive, velocities

Time= 0:1/Param.ADVSAMPLINGFREQUENCY:length(Automate.velocityZPrimeAutomate)/Param.ADVSAMPLINGFREQUENCY;
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

% h1=get(gca, 'title');
% origtitle=get(h1,'string');
% a = 'Segment ' +string(iDeployment);
% origtitle = [ a, origtitle ];
% set(h1,'String',[origtitle])

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


% end

%% Plot of Fluxes and Cumulated fluxes N

figure('Name','EC O2 Fluxes'+Depl.figName,'NumberTitle','off');
% segmentsTimestamps = oxygenTimeseries(1+VelDurationi/2:VelDurationi:VelDurationi*Depl.nbSegments+VelDurationi/2);
% x = segmentsTimestamps;
y = FluxesShifted(:,2);
bar(y);
barvalues;
ylabel('O_2 Fluxes (mmol/m^2/d)');
% xlabel('Time');
title('O_2 Fluxes for Eddy Covariance',Depl.figTitle)
a1 = annotation('textbox',[.9 .5 .1 .2],'String','Planar Fit','EdgeColor','none');

% figure('Name','EC O_2 Cumulated Fluxes','NumberTitle','off');
% x = oxygenTimeseries;
% y = OxFluxCumulated;
% plot(x,y);
% ylabel('O_2 Cumulated Fluxes (mmol/m^2)');
% xlabel('Time');
% title('EC O_2 Cumulated Fluxes')




%% REA flux and tables

% w_Mean(14)= wAligned_Mean;
% w_Std(14)= wAligned_Std;
% FluxesShifted(14,2)= mean(FluxesShifted(:,2));
% timeShift = timeShift/Param.ADVSAMPLINGFREQUENCY; %conversion to seconds
% 
% Para = {'Segment 1';'Segment 2';'Segment 3';'Segment 4';'Segment 5';'Segment 6';'Segment 7';'Segment 8';'Segment 9';'Segment 10';'Segment 11';'Segment 12';'Segment 13';'campaign'}
% % Para = {'Segment 1';'Segment 2';'Segment 3';'Segment 4';'Segment 5';'Segment 6';'Segment 7';'Segment 8';'Segment 9';'Segment 10';'Segment 11';'Segment 12';'campaign'}
% % Para = {'Segment 1';'Segment 2';'Segment 3';'Segment 4';'Segment 5';'Segment 6';'campaign'}
% TEC = table(w_Mean, w_Std, FluxesShifted(:,2),'RowNames',Para);
% TEC.Properties.VariableNames = {'Mean W'  'W Std' 'Flux'}


% % Get the table in string form.
% TECString = evalc('disp(TEC)');
% % Use TeX Markup for bold formatting and underscores.
% TECString = strrep(TECString,'<strong>','\bf');
% TECString = strrep(TECString,'</strong>','\rm');
% TECString = strrep(TECString,'_','\_');
% % Get a fixed-width font.
% FixedWidth = get(0,'FixedWidthFontName');
% % Output the table using the annotation command.
% figure('Name','Details for EC'+ Depl.figName,'NumberTitle','off');
% annotation(gcf,'Textbox','String',TECString,'Interpreter','Tex',...
%     'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);

% Parameters = {'Segment 1';'Segment 2';'Segment 3';'Segment 4';'Segment 5';'Segment 6';'Segment 7';'Segment 8'}
% TREA = table(REA.VelocityThreshold', REA.stdVelocityZ',REA.ConditionValue', REA.Condition', REA.bCoefFit',REA.OxyFlux','RowNames',Parameters);
% TREA.Properties.VariableNames = {'W_0' 'Wstd' 'W_0/Wstd' 'Condition Validity' 'b Coeff' 'Flux'}


% % Get the table in string form.
% TREAString = evalc('disp(TREA)');
% % Use TeX Markup for bold formatting and underscores.
% TREAString = strrep(TREAString,'<strong>','\bf');
% TREAString = strrep(TREAString,'</strong>','\rm');
% TREAString = strrep(TREAString,'_','\_');
% % Get a fixed-width font.
% FixedWidth = get(0,'FixedWidthFontName');
% % Output the table using the annotation command.
% figure('Name','Details for REA'+Depl.figName,'NumberTitle','off');
% annotation(gcf,'Textbox','String',TREAString,'Interpreter','Tex',...
%     'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);

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


    
