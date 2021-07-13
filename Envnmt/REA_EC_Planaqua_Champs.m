%% 27/06/2020 
% Script for EC and REA calculations at Champs lake for summer campaign
% v0 Guilherme 



clear all;
% CompiledResultsPos = 1:27;
% CompiledREA = 1:4;
Compiledresults = 1:9;
%d =12;
%for d = 1:23
n=1;
f=12;
%while f<70
close all;

 
Param = load_parameters;   % to define constant parameters
%For Courcelles segt 18 change the sampling frequency from 8 Hz to 16 Hz

iDeployment = 68; %Choose the segment to be analyzed

%Segment 9 contain weird points of correlation!
%Planqua segments => 56
% =>12 Champs segments =<55
% segment 23  change Param.TIMESHIFTSEARCHRANGESEC to 7, despiking analysis
% do not found 2 peaks for Pearson's analysis. Some bug in segment_time_shift_EC and need to be fixed 
% segment 34 very different vector length for automate are much more bigger
% than for the oxygen
% 25, 26 and 27 change the UP for DOWN

iSegment = iDeployment;

%Depl = deployment_parameter_planaqua( iDeployment, Param );%selecting parameters for each segment


Depl = deployment_parameter_champs_planaqua( iDeployment, Param );%selecting parameters for each segment

Location.ChampsCanalNorth = regexp(Depl.location,'Champs-Canal-North');
Location.Courcelles = regexp(Depl.location,'Courcelles');
Location.ChampsPA = regexp(Depl.location,'Champs Platform pA');
Location.Planaqua = regexp(Depl.location,'PLANAQUA');


%% Uploading datasets and selecting parameters and durations 
    %Uploading the oxygen dataset
    
  if  Location.Planaqua == 1
    [Firesting.CompleteDataset]=uploading_firesting_2020(Depl.filePathFiresting); %uploading file created by oxymeter for the segment
    [Compensation.oxygenCompleteDataset]=uploading_firesting_2020(Depl.filePathFirestingCompensation); %uploading file created by oxymeter for the compensation

% If dataLines is not specified, define defaults
opts = delimitedTextImportOptions("NumVariables", 26);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ";";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "VarName20", "VarName21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "VarName1", "InputFormat", "dd/MM/yyyy HH:mm:ss");
opts = setvaropts(opts, ["VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "VarName20", "VarName21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26"], "DecimalSeparator", ",");
opts = setvaropts(opts, ["VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "VarName20", "VarName21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26"], "ThousandsSeparator", ".");

% Import the data
Automate.velocityFile = readtable(Depl.velocityfile, opts);
%Compensation.velocityFile = readtable(Depl.velocityfileCompensation, opts);
%Angles.velocityFile = readtable(Depl.velocityfileAngles, opts);
     %Stablishing the indexes for the oxygen measurements. 

  
  index.UP = [6,3,1,22];
  index.Needle = [7,4,2,23];
  index.DOWN = [8,5,3,24];
  
  probeCalibration.temp0 = 21;
  probeCalibration.temp100 = 21;
  probeCalibration.pressure = 1006;
  probeCalibration.humidity = 100;
  probeCalibration.dphi0 = 44.848;
  probeCalibration.dphi100 = 22.566;

  probeCalibration.UP.temp0 = 21;
  probeCalibration.UP.temp100 = 21;
  probeCalibration.UP.pressure = 1006;
  probeCalibration.UP.humidity = 100;
  probeCalibration.UP.dphi0 = 52.587;
  probeCalibration.UP.dphi100 = 22.237;

  probeCalibration.DOWN.temp0 = 21;
  probeCalibration.DOWN.temp100 = 21;
  probeCalibration.DOWN.pressure = 1006;
  probeCalibration.DOWN.humidity = 100;
  probeCalibration.DOWN.dphi0 = 51.947;
  probeCalibration.DOWN.dphi100 = 22.603;
  
    else
      if iDeployment >= 37 && iDeployment <= 55
[Firesting.CompleteDataset]=uploading_firesting_2020c(Depl.filePathFiresting); %uploading file created by oxymeter for the segment
[Compensation.oxygenCompleteDataset]=uploading_firesting_2020c(Depl.filePathFirestingCompensation); %uploading file created by oxymeter for the compensation   
      else
[Firesting.CompleteDataset]=uploading_firesting_2020b(Depl.filePathFiresting); %uploading file created by oxymeter for the segment
[Compensation.oxygenCompleteDataset]=uploading_firesting_2020b(Depl.filePathFirestingCompensation); %uploading file created by oxymeter for the compensation
       end
      
opts = delimitedTextImportOptions("NumVariables", 24);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ";";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "VarName20", "VarName21", "VarName22", "VarName23", "VarName24"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "VarName1", "InputFormat", "dd/MM/yyyy HH:mm:ss");

% Import the data
Automate.velocityFile = readtable(Depl.velocityfile, opts);
      
  end
  
  
  if Location.ChampsCanalNorth ==1

  if iDeployment == 12 || iDeployment == 13 || iDeployment == 14 || iDeployment == 16 || iDeployment == 17 %!!! are down and up ok?
  index.DOWN = [6,3];
  index.Needle = [7,4];
  index.UP = [8,5];
  
  probeCalibration.temp0 = 18.3;
  probeCalibration.temp100 = 18.3;
  probeCalibration.pressure = 1020;
  probeCalibration.humidity = 100;
  probeCalibration.dphi0 = 48.79;
  probeCalibration.dphi100 = 22.023;

  probeCalibration.UP.temp0 = 18.3;
  probeCalibration.UP.temp100 = 18.3;
  probeCalibration.UP.pressure = 1020;
  probeCalibration.UP.humidity = 100;
  probeCalibration.UP.dphi0 = 53.124;
  probeCalibration.UP.dphi100 = 20.366;

  probeCalibration.DOWN.temp0 = 18.3;
  probeCalibration.DOWN.temp100 = 18.3;
  probeCalibration.DOWN.pressure = 1020;
  probeCalibration.DOWN.humidity = 100;
  probeCalibration.DOWN.dphi0 = 52.675;
  probeCalibration.DOWN.dphi100 = 20.312;
  end
  if iDeployment == 15 
  index.UP = [6,3];
  index.Needle = [7,4];
  index.DOWN = [8,5];
  
  probeCalibration.temp0 = 18.3;
  probeCalibration.temp100 = 18.3;
  probeCalibration.pressure = 1020;
  probeCalibration.humidity = 100;
  probeCalibration.dphi0 = 48.79;
  probeCalibration.dphi100 = 22.023;

  probeCalibration.DOWN.temp0 = 18.3;
  probeCalibration.DOWN.temp100 = 18.3;
  probeCalibration.DOWN.pressure = 1020;
  probeCalibration.DOWN.humidity = 100;
  probeCalibration.DOWN.dphi0 = 53.124;
  probeCalibration.DOWN.dphi100 = 20.366;

  probeCalibration.UP.temp0 = 18.3;
  probeCalibration.UP.temp100 = 18.3;
  probeCalibration.UP.pressure = 1020;
  probeCalibration.UP.humidity = 100;
  probeCalibration.UP.dphi0 = 52.675;
  probeCalibration.UP.dphi100 = 20.312;
  
  end
  end
  
 if Location.Courcelles ==1 %19 -> 21
  index.DOWN = [6,3];
  index.Needle = [7,4];
  index.UP = [8,5];
 
  probeCalibration.temp0 = 18.3;
  probeCalibration.temp100 = 18.3;
  probeCalibration.pressure = 1020;
  probeCalibration.humidity = 100;
  probeCalibration.dphi0 = 48.79;
  probeCalibration.dphi100 = 22.023;

  probeCalibration.DOWN.temp0 = 18.3;
  probeCalibration.DOWN.temp100 = 18.3;
  probeCalibration.DOWN.pressure = 1020;
  probeCalibration.DOWN.humidity = 100;
  probeCalibration.DOWN.dphi0 = 53.124;
  probeCalibration.DOWN.dphi100 = 20.366;

  probeCalibration.UP.temp0 = 18.3;
  probeCalibration.UP.temp100 = 18.3;
  probeCalibration.UP.pressure = 1020;
  probeCalibration.UP.humidity = 100;
  probeCalibration.UP.dphi0 = 52.675;
  probeCalibration.UP.dphi100 = 20.312;
  
 end
 if Location.ChampsPA ==1
  index.UP = [6,3];
  index.Needle = [7,4];
  index.DOWN = [8,5];
  
  probeCalibration.temp0 = 18.3;
  probeCalibration.temp100 = 18.3;
  probeCalibration.pressure = 1020;
  probeCalibration.humidity = 100;
  probeCalibration.dphi0 = 48.79;
  probeCalibration.dphi100 = 22.023;

  probeCalibration.DOWN.temp0 = 18.3;
  probeCalibration.DOWN.temp100 = 18.3;
  probeCalibration.DOWN.pressure = 1020;
  probeCalibration.DOWN.humidity = 100;
  probeCalibration.DOWN.dphi0 = 53.124;
  probeCalibration.DOWN.dphi100 = 20.366;

  probeCalibration.UP.temp0 = 18.3;
  probeCalibration.UP.temp100 = 18.3;
  probeCalibration.UP.pressure = 1020;
  probeCalibration.UP.humidity = 100;
  probeCalibration.UP.dphi0 = 52.675;
  probeCalibration.UP.dphi100 = 20.312;
  
  if iDeployment >=37  
  index.DOWN = [5,3];
  index.Needle = [6,4];
  index.UP = [7,5];
  
   probeCalibration.temp0 = 23.6;
   probeCalibration.temp100 = 23.6;
   probeCalibration.pressure = 999;
   probeCalibration.humidity = 100;
   probeCalibration.dphi0 = 45.006;
   probeCalibration.dphi100 = 21.803;
 
   probeCalibration.DOWN.temp0 = 23.6;
   probeCalibration.DOWN.temp100 = 23.6;
   probeCalibration.DOWN.pressure = 999;
   probeCalibration.DOWN.humidity = 100;
   probeCalibration.DOWN.dphi0 = 50.669;
   probeCalibration.DOWN.dphi100 = 21.062;
 
   probeCalibration.UP.temp0 = 23.6;
   probeCalibration.UP.temp100 = 23.6;
   probeCalibration.UP.pressure = 999;
   probeCalibration.UP.humidity = 100;
   probeCalibration.UP.dphi0 = 47.787;
   probeCalibration.UP.dphi100 = 19.139;
  
%    probeCalibration.temp0 = 23.6;
%   probeCalibration.temp100 = 23.6;
%   probeCalibration.pressure = 999;
%   probeCalibration.humidity = 100;
%   probeCalibration.dphi0 = 50.669;
%   probeCalibration.dphi100 = 21.062;
% 
%   probeCalibration.DOWN.temp0 = 23.6;
%   probeCalibration.DOWN.temp100 = 23.6;
%   probeCalibration.DOWN.pressure = 999;
%   probeCalibration.DOWN.humidity = 100;
%   probeCalibration.DOWN.dphi0 = 47.787;
%   probeCalibration.DOWN.dphi100 = 19.139;
% 
%   probeCalibration.UP.temp0 = 23.6;
%   probeCalibration.UP.temp100 = 23.6;
%   probeCalibration.UP.pressure = 999;
%   probeCalibration.UP.humidity = 100;
%   probeCalibration.UP.dphi0 = 45.006;
%   probeCalibration.UP.dphi100 = 21.062;
  
  end
 end
  
  
    % New version for matlab 2020
    Firesting.Start = datetime(Depl.dateStringSegtO2Start,'Format','HH:mm:ss');
    Firesting.End = datetime(Depl.dateStringSegtO2End,'Format','HH:mm:ss');
    Automate.Start = datetime(Depl.dateStringSegtAutoStart, 'Format', 'dd/MM/yyyy HH:mm:ss');
    Automate.End = datetime(Depl.dateStringSegtAutoEnd, 'Format', 'dd/MM/yyyy HH:mm:ss');
    Compensation.Firesting.Start = datetime(Depl.dateStringCompStart,'Format','HH:mm:ss');
    Compensation.Firesting.End = datetime(Depl.dateStringCompEnd,'Format','HH:mm:ss');
    %Compensation.Automate.Start = datetime(Depl.dateStringCompAutoStart, 'Format', 'dd/MM/yyyy HH:mm:ss');
    %Compensation.Automate.End = datetime(Depl.dateStringCompAutoEnd, 'Format', 'dd/MM/yyyy HH:mm:ss');
    
    Firesting.time = Firesting.CompleteDataset{9:end,2};
    Compensation.Firesting.time = Compensation.oxygenCompleteDataset{9:end,2};
    Automate.velocityTime = Automate.velocityFile{:,1};
    %Compensation.Automate.velocityTime = Compensation.velocityFile{:,1};
    
    Firesting.iStart = knnsearch(datenum(Firesting.time),datenum(Firesting.Start));
    Firesting.iEnd = knnsearch(datenum(Firesting.time),datenum(Firesting.End));
    Automate.iStart = knnsearch(datenum(Automate.velocityTime),datenum(Automate.Start));
    Automate.iEnd = knnsearch(datenum(Automate.velocityTime),datenum(Automate.End));
    Compensation.Firesting.iStart = knnsearch(datenum(Compensation.Firesting.time),datenum(Compensation.Firesting.Start));
    Compensation.Firesting.iEnd = knnsearch(datenum(Compensation.Firesting.time),datenum(Compensation.Firesting.End));
    %Compensation.Automate.iStart = knnsearch(datenum(Compensation.Automate.velocityTime),datenum(Compensation.Automate.Start));
    %Compensation.Automate.iEnd = knnsearch(datenum(Compensation.Automate.velocityTime),datenum(Compensation.Automate.End));

    Compensation.Firesting.SelectedDataset = Compensation.oxygenCompleteDataset(9:end,:);
    Compensation.Firesting.rawOxygen = Compensation.Firesting.SelectedDataset{Compensation.Firesting.iStart:Compensation.Firesting.iEnd,index.Needle(1)};
    Compensation.Firesting.rawOxygenUP = Compensation.Firesting.SelectedDataset{Compensation.Firesting.iStart:Compensation.Firesting.iEnd,index.UP(1)};
    Compensation.Firesting.rawOxygenDOWN = Compensation.Firesting.SelectedDataset{Compensation.Firesting.iStart:Compensation.Firesting.iEnd,index.DOWN(1)};
    
    %Compensation.velocityFileOxy = Compensation.velocityFile(:,2:4);
    %Compensation.velocityFileOxy = Compensation.velocityFileOxy{:,:};
    %Compensation.Automate.rawOxygen = Compensation.velocityFileOxy(Compensation.Firesting.iStart:Compensation.Automate.iEnd,index.Needle(3));
    %Compensation.Automate.rawOxygenUP = Compensation.velocityFileOxy(Compensation.Firesting.iStart:Compensation.Automate.iEnd,index.UP(3));
    %Compensation.Automate.rawOxygenDOWN = Compensation.velocityFileOxy(Compensation.Firesting.iStart:Compensation.Automate.iEnd,index.DOWN(3));
     
    Automate.velocityFileSegt = Automate.velocityFile{Automate.iStart:Automate.iEnd,2:end};
    
    if iDeployment == 56+8 || iDeployment == 23 || iDeployment == 37 || iDeployment == 40 || iDeployment == 47 || iDeployment == 53 || iDeployment == 63 
    
   Automate.velocityFileSegt(end,:) = [];
        
    end
    
    if iDeployment == 25
    
   Automate.velocityFileSegt(end-1:end,:) = [];
        
    end
    
%     if iDeployment == 14
%     
%         Automate.velocityFileSegt(2103:2183,:) = [];
%     
%     end
%     

    
    Automate.rawvelocityZ = Automate.velocityFileSegt(:,9);
    Automate.rawvelocityZThreshold = Automate.velocityFileSegt(1,10); 
    Automate.rawvelocityX = Automate.velocityFileSegt(:,7);
      
    Automate.correlationX = Automate.velocityFileSegt(:,18);
    Automate.correlationY = Automate.velocityFileSegt(:,19);
    Automate.correlationZ = Automate.velocityFileSegt(:,20);
    Automate.goodCorrelation = Automate.velocityFileSegt(:,21);
    
    Automate.rawvelocityZPrimeAutomate = Automate.velocityFileSegt(:,5);
    
    Automate.velocityZPrimeAutomate = Automate.rawvelocityZPrimeAutomate/1000;
    Automate.velocityZ = Automate.rawvelocityZ/1000; % velocity data was collected in mm/s directly from Depl.and here it is selected and converted in m/s
    Automate.velocityZThreshold = Automate.rawvelocityZThreshold/1000; %w0 selection in the velocity file and converted from cm/s to m/s
    Automate.velocityX = Automate.rawvelocityX/1000;
%    Automate.counter = Depl.velocityfile(Automate.iStart:Automate.iEnd,18);
    Automate.velocityY = Automate.velocityFileSegt(:,8)/1000;
    
    Automate.meanCourrent = mean(Automate.velocityX);
    Automate.meanCourrentModule = mean(sqrt((Automate.velocityX).^2.+(Automate.velocityY).^2));
       
    %Automate.rawOxygenFiresting = Automate.velocityFileSegt(:,index.Needle(4));
    %Automate.rawOxygenFirestingUP = Automate.velocityFileSegt(:,index.UP(4));
    %Automate.rawOxygenFirestingDOWN = Automate.velocityFileSegt(:,index.DOWN(4));
    
    Firesting.SelectedDataset = Firesting.CompleteDataset(9:end,:);
    Firesting.rawOxygenFiresting = Firesting.SelectedDataset{Firesting.iStart:Firesting.iEnd,index.Needle(1)};
    Firesting.rawOxygenFirestingUP = Firesting.SelectedDataset{Firesting.iStart:Firesting.iEnd,index.UP(1)};
    Firesting.rawOxygenFirestingDOWN = Firesting.SelectedDataset{Firesting.iStart:Firesting.iEnd,index.DOWN(1)};
    Firesting.timeOxygenFiresting = Firesting.SelectedDataset{Firesting.iStart:Firesting.iEnd,3}-Firesting.SelectedDataset{Firesting.iStart,3}; %Time (s) selected from the beginning of the segt giving the mesurement time step from each oxygen mesurement 
    
    Automate.valveUPaction = Automate.velocityFileSegt(:,1);
    Automate.valveDOWNaction = Automate.velocityFileSegt(:,3);  
    
    Automate.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(Automate.velocityZ)-1)/Param.ADVSAMPLINGFREQUENCY];
    figure;plot(Automate.time,Automate.velocityZ)
    ylabel('Velocity (m.s-^1)')
    xlabel('Time (s)')
    title('Vertical velocity measured during segment')
%print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_vertical_velocity'])

    figure;plot(Automate.time,Automate.velocityX)
    ylabel('Velocity (m.s-^1)')
    xlabel('Time (s)')
    title('Horizontal velocity measured during segment')
    %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_horizontal_velocity'])

%  figure;
%  subplot(3,1,1);
%  plot(Automate.rawOxygenFiresting);hold on
%  plot(Firesting.rawOxygenFiresting,'r')
%  ylabel('Oxygen(Dphi)')
%  legend('Automate','Firesting','location','southeast')
%  legend('boxoff')
%  title('Needle')
%  
%  subplot(3,1,2);
%  plot(Automate.rawOxygenFirestingUP);hold on
%  plot(Firesting.rawOxygenFirestingUP,'r')
%  ylabel('Oxygen(Dphi)')
%  title('UP')
%  
%  subplot(3,1,3);
%  plot(Automate.rawOxygenFirestingDOWN);hold on
%  plot(Firesting.rawOxygenFirestingDOWN,'r')
%  ylabel('Oxygen(Dphi)')
%  xlabel('Time (s)')
%  title('DOWN')
%  print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_oxygen_firesting_automate']) 
%  
      %figure;plot(automate.time,automate.velocityZ);hold on;plot(automate.time(automate.ivelocityZ),automate.velocityZ(automate.ivelocityZ),'ro')
      
%% Calibrating the oxygen to the oxygen probes caracteristics and conveting units
temperature = Firesting.CompleteDataset{10,10}; %°C %fixed temperature during measurement
%temperature = 22.6; 
salinity = 0; % ‰


setCalibrationData(probeCalibration.temp0,probeCalibration.temp100, probeCalibration.pressure, probeCalibration.humidity, probeCalibration.dphi0, probeCalibration.dphi100);

Firesting.FirestingRawNeedle = calculateOxygen(Firesting.rawOxygenFiresting,temperature,probeCalibration.pressure,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

Firesting.CompensatedNeedle = Firesting.FirestingRawNeedle(:,6)*10^3/32; %[O2]mg/l --> [O2]mmol/m3 = µmol/L

%Automate.FirestingRawNeedle = calculateOxygen(Automate.rawOxygenFiresting,temperature,probeCalibration.pressure,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

%Automate.CompensatedNeedle = Automate.FirestingRawNeedle(:,6)*10^3/32; %[O2]mg/l --> [O2]mmol/m3 = µmol/L

Compensation.Firesting.Needle.oxygenFiresting = calculateOxygen(Compensation.Firesting.rawOxygen,temperature,probeCalibration.pressure,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

Compensation.Firesting.Needle.oxygenCompensated = Compensation.Firesting.Needle.oxygenFiresting(:,6)*10^3/32;%[O2]mg/l --> [O2]µmol/m3

%Compensation.Automate.Needle.oxygenAutomate = calculateOxygen(Compensation.Automate.rawOxygen,temperature,probeCalibration.pressure,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

%Compensation.Automate.Needle.oxygenCompensated = Compensation.Automate.Needle.oxygenAutomate(:,6)*10^3/32;%[O2]mg/l --> [O2]µmol/m3

%temperature = 22.9; %Test of temperature. Different temperatures effect on
%REA fluxes

setCalibrationData(probeCalibration.UP.temp0,probeCalibration.UP.temp100, probeCalibration.UP.pressure, probeCalibration.UP.humidity, probeCalibration.UP.dphi0, probeCalibration.UP.dphi100);

Firesting.UP.FirestingRaw = calculateOxygen(Firesting.rawOxygenFirestingUP,temperature,probeCalibration.UP.pressure ,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

Firesting.UP.oxygenCompensated = Firesting.UP.FirestingRaw(:,6)*10^3/32; %[O2]mg/l --> [O2]mmol/m3 = µmol/L

%Automate.UP.FirestingRaw = calculateOxygen(Automate.rawOxygenFirestingUP,temperature,probeCalibration.UP.pressure ,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

%Automate.UP.oxygenCompensated = Automate.UP.FirestingRaw(:,6)*10^3/32; %[O2]mg/l --> [O2]mmol/m3 = µmol/L

Compensation.Firesting.UP.oxygenFiresting = calculateOxygen(Compensation.Firesting.rawOxygenUP,temperature,probeCalibration.UP.pressure ,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

Compensation.Firesting.UP.oxygenCompensated = Compensation.Firesting.UP.oxygenFiresting(:,6)*10^3/32;%[O2]mg/l --> [O2]µmol/m3

%Compensation.Automate.UP.oxygenAutomate = calculateOxygen(Compensation.Automate.rawOxygenUP,temperature,probeCalibration.UP.pressure,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

%Compensation.Automate.UP.oxygenCompensated = Compensation.Automate.UP.oxygenAutomate(:,6)*10^3/32;%[O2]mg/l --> [O2]µmol/m3


%probeCalibration.DOWN.dphi0 = probeCalibration.UP.dphi0;
%probeCalibration.DOWN.dphi100 = probeCalibration.UP.dphi100;

%temperature = 23.1; %°C %Test of temperature. Different temperatures effect on
%REA fluxes

setCalibrationData(probeCalibration.DOWN.temp0,probeCalibration.DOWN.temp100, probeCalibration.DOWN.pressure, probeCalibration.DOWN.humidity, probeCalibration.DOWN.dphi0, probeCalibration.DOWN.dphi100);

Firesting.DOWN.FirestingRaw = calculateOxygen(Firesting.rawOxygenFirestingDOWN,temperature,probeCalibration.DOWN.pressure,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

Firesting.DOWN.oxygenCompensated = Firesting.DOWN.FirestingRaw(:,6)*10^3/32; %[O2]mg/l --> [O2]mmol/m3 = µmol/L

%Automate.DOWN.FirestingRaw = calculateOxygen(Automate.rawOxygenFirestingDOWN,temperature,probeCalibration.DOWN.pressure,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

%Automate.DOWN.oxygenCompensated = Automate.DOWN.FirestingRaw(:,6)*10^3/32; %[O2]mg/l --> [O2]mmol/m3 = µmol/L

Compensation.Firesting.DOWN.oxygenFiresting = calculateOxygen(Compensation.Firesting.rawOxygenDOWN,temperature,probeCalibration.DOWN.pressure,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

Compensation.Firesting.DOWN.oxygenCompensated = Compensation.Firesting.DOWN.oxygenFiresting(:,6)*10^3/32;%[O2]mg/l --> [O2]µmol/m3

%Compensation.Automate.DOWN.oxygenAutomate = calculateOxygen(Compensation.Automate.rawOxygenDOWN,temperature,probeCalibration.DOWN.pressure,salinity,'Y'); %Compensating oxygen measurements on temperature, pressure and salinity

%Compensation.Automate.DOWN.oxygenCompensated = Compensation.Automate.DOWN.oxygenAutomate(:,6)*10^3/32;%[O2]mg/l --> [O2]µmol/m3

clearvars temperature pressure salinity;

   figure;plot(Firesting.timeOxygenFiresting,Firesting.CompensatedNeedle)
    ylabel('Oxygen concentration(µmol.l^-^1)')
    xlabel('Time (s)')
    title('Oxygen measured during segment')
    %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_horizontal_velocity'])


%% Eddy Covariance calculation from automation velocity and and pre-segt angles

Firesting.meanCompensatedNeedle = mean(Firesting.CompensatedNeedle);

[Firesting.timeInterp,Firesting.FirestingInterp] = interpolation_field_validation(Param, Firesting.CompensatedNeedle,Firesting.timeOxygenFiresting); % interpolating the oxygen measurement frequency to the same frequency as the velocity

if iDeployment == 64 || iDeployment == 14
    Firesting.FirestingInterp(end) = [];
    Firesting.timeInterp(end) = [];
end

if iDeployment == 18
    Firesting.FirestingInterp(end-5:end) = [];
    Firesting.timeInterp(end-5:end) = [];
end

% if iDeployment == 14
%     Firesting.FirestingInterp(2103:2183) = [];
%     Firesting.timeInterp(2103:2183) = [];
% end

[EC.time_TimeShift_AutomateDouble, EC.velocityZPrime_TimeShift_AutomateDouble, EC.oxygenPrime_TimeShift_AutomateDouble, EC.ecFluxOxygen_TimeShift_AutomateDouble, EC.ecFluxOxygen_NoTimeShift_AutomateDouble, EC.velocityZPrime_AutomateDouble, EC.oxygenPrime_AutomateDouble, EC.iFigure_AutomateDouble, EC.bestpValue_AutomateDouble, EC.pvalues_AutomateDouble] ...
     = segment_time_shift_EC( Param,Firesting.timeInterp, Automate.velocityZPrimeAutomate, Firesting.FirestingInterp, 1);% synchronization of oxygen over velocity for EC flux calculation
  %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro'])
  
 [~, EC.ecFluxOxygen_AutomateDouble, ~, ~, EC.reaFluxOxygen_AutomateDouble, ~, ...
        ~, EC.ecOgiveOxygen_AutomateDouble, ~, ~, EC.reaOgiveOxygen_AutomateDouble, ~, EC.nFrequencyFFT_AutomateDouble]= ...
    segment_fluxes_ogives3(EC.velocityZPrime_TimeShift_AutomateDouble, EC.oxygenPrime_TimeShift_AutomateDouble, EC.oxygenPrime_TimeShift_AutomateDouble,EC.oxygenPrime_TimeShift_AutomateDouble,0,  ...
    Automate.velocityZThreshold, 1, 1,Param.NFREQUENCYFFT, Param.ADVSAMPLINGFREQUENCY, Param.RUNNINGAVERAGE);%calculating the ogive

[EC.segFrequency, fig] = segment_plots(Depl,Param,EC.ecOgiveOxygen_AutomateDouble,EC.ecOgiveOxygen_AutomateDouble);%ploting the ogive

% [EC.time_TimeShift_AutomateDouble, EC.velocityZPrime_TimeShift_AutomateDouble, EC.oxygenPrime_TimeShift_AutomateDouble, EC.ecFluxOxygen_TimeShift_AutomateDouble, EC.ecFluxOxygen_NoTimeShift_AutomateDouble, EC.velocityZPrime_AutomateDouble, EC.oxygenPrime_AutomateDouble, EC.iFigure_AutomateDouble, EC.bestpValue_AutomateDouble, EC.pvalues_AutomateDouble] ...
%      = segment_time_shift_EC( Param,Firesting.timeInterp, Automate.velocityZ, Firesting.FirestingInterp, 1);% synchronization of oxygen over velocity for EC flux calculation
%   print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro'])
% 
% 
%  [~, EC.ecFluxOxygen_AutomateDouble, ~, ~, EC.reaFluxOxygen_AutomateDouble, ~, ...
%         ~, EC.ecOgiveOxygen_AutomateDouble, ~, ~, EC.reaOgiveOxygen_AutomateDouble, ~, EC.nFrequencyFFT_AutomateDouble]= ...
%     segment_fluxes_ogives3(EC.velocityZPrime_TimeShift_AutomateDouble, EC.oxygenPrime_TimeShift_AutomateDouble, EC.oxygenPrime_TimeShift_AutomateDouble,EC.oxygenPrime_TimeShift_AutomateDouble,0,  ...
%     Automate.velocityZThreshold, 1, 1,Param.NFREQUENCYFFT, Param.ADVSAMPLINGFREQUENCY, Param.RUNNINGAVERAGE);%calculating the ogive
% 
% [EC.segFrequency, fig] = segment_plots(Depl,Param,EC.ecOgiveOxygen_AutomateDouble,EC.ecOgiveOxygen_AutomateDouble);%ploting the ogive
%% EC despiking

EC.despiking.velocityZ = Automate.velocityZPrimeAutomate;
EC.despiking.oxygenFirestingInterp = Firesting.FirestingInterp;
EC.despiking.timeInterp = Firesting.timeInterp;
for i =  1:length(Automate.velocityZ)
    if Automate.goodCorrelation(i) == 1
     EC.despiking.velocityZ(i) = NaN;
     %EC.despiking.oxygenFirestingInterp(i) = NaN;
     %EC.despiking.timeInterp(i) = NaN;
    end
end


%EC.despiking.velocityZDespiked = EC.despiking.velocityZ(~isnan(EC.despiking.velocityZ));
%EC.despiking.oxygenFirestingInterpDespiked = EC.despiking.oxygenFirestingInterp(~isnan(EC.despiking.oxygenFirestingInterp));
%EC.despiking.timeInterpDespiked = EC.despiking.timeInterp(~isnan(EC.despiking.timeInterp));

EC.despiking.oxygenFirestingInterpDespiked = EC.despiking.oxygenFirestingInterp;
EC.despiking.timeInterpDespiked = EC.despiking.timeInterp;

EC.despiking.velocityZDespiked = fillmissing(EC.despiking.velocityZ,'linear');

[EC.despiking.time_TimeShift, EC.despiking.velocityZPrime_TimeShift, EC.despiking.oxygenPrime_TimeShift, EC.despiking.ecFluxOxygen_TimeShift, EC.despiking.ecFluxOxygen_NoTimeShift, EC.despiking.velocityZPrime, EC.despiking.oxygenPrime, EC.despiking.iFigure, EC.despiking.bestpValue, EC.despiking.pvalues] ...
= segment_time_shift_EC( Param,EC.despiking.timeInterpDespiked, EC.despiking.velocityZDespiked, EC.despiking.oxygenFirestingInterpDespiked, 1);%this synchronazation use the velocity alligned collected by the automation NO FLUCTUATION EXTRACTION
   %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro_EC'])
  
[~, EC.despiking.ecFluxOxygen, ~, ~, EC.despiking.reaFluxOxygen, ~, ...
 ~, EC.despiking.ecOgiveOxygen, ~, ~, EC.despiking.reaOgiveOxygen, ~, EC.despiking.nFrequencyFFT]= ...
 segment_fluxes_ogives3(EC.despiking.velocityZPrime_TimeShift, EC.despiking.oxygenPrime_TimeShift, EC.despiking.oxygenPrime_TimeShift,EC.despiking.oxygenPrime_TimeShift,0,  ...
 Automate.velocityZThreshold, 1, 1,Param.NFREQUENCYFFT, Param.ADVSAMPLINGFREQUENCY, Param.RUNNINGAVERAGE);
  % 
[~, fig] = segment_plots(Depl,Param,EC.despiking.ecOgiveOxygen,EC.despiking.ecOgiveOxygen);%ploting the ogive
  
 EC.despiking.time = [0:1/Param.ADVSAMPLINGFREQUENCY:(length(EC.despiking.velocityZPrime_TimeShift)-1)/Param.ADVSAMPLINGFREQUENCY];
 
 figure;
 subplot(2,1,1);
 plot(EC.despiking.time,EC.despiking.velocityZPrime_TimeShift);hold on
 ylabel('Vertical velocity despiked (m.s-^1)')
 xlabel('Time (s)')
 
 subplot(2,1,2);
 plot(EC.despiking.time,EC.despiking.oxygenPrime_TimeShift,'r');hold on
 ylabel('Oxygen concentration despiked (µmol.l^-^1)')
 xlabel('Time (s)')
 %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_oxygen_velocity_despiked'])
 
 %EC.despiking.fluxECcum = EC.despiking.velocityZPrime_TimeShift.*EC.despiking.oxygenPrime_TimeShift;
 
%EC.despiking.fluxECcum = cumsum((EC.despiking.velocityZPrime_TimeShift.*EC.despiking.oxygenPrime_TimeShift)/Param.ADVSAMPLINGFREQUENCY);
EC.despiking.time = EC.despiking.time';
EC.despiking.fluxECcum = cumsum((EC.despiking.velocityZPrime_TimeShift.*EC.despiking.oxygenPrime_TimeShift).*EC.despiking.time);
 
 EC.despiking.fluxECcumTemp = EC.despiking.fluxECcum;
 
 for i = [1:length(EC.despiking.fluxECcum)]%before velocityZPrime_TimeShift
     EC.despiking.fluxECcumTemp(i) = mean( EC.despiking.velocityZPrime_TimeShift(1:i).*EC.despiking.oxygenPrime_TimeShift(1:i));
 end
 
%F_EC(EC.despiking.time) = integral(EC.despiking.velocityZPrime_TimeShift.*EC.despiking.oxygenPrime_TimeShift,min(EC.despiking.time),max(EC.despiking.time))/EC.despiking.time;
 
%fun = @(time)(EC.despiking.velocityZPrime_TimeShift.*EC.despiking.oxygenPrime_TimeShift)./EC.despiking.time; 


figure;plot(EC.despiking.time,(EC.despiking.fluxECcumTemp*24*3600))
 ylabel('Oxygen flux (mmol.m^-^2.day^-^1)')
 xlabel('Time (s)')

%EC.despiking.fluxEcCum = EC.despiking.fluxECcum.*EC.despiking.time;
 
%   figure;plot(EC.despiking.time,cumsum(EC.despiking.fluxEcCum))
figure;plot(EC.despiking.time,EC.despiking.fluxECcumTemp.*EC.despiking.time)
  ylabel('Cumulative O_2 flux (mmol.m^-^2)')
  xlabel('Time (s)')
 
%  figure;plot(EC.despiking.time,cumsum(EC.despiking.fluxECcumTemp.*EC.despiking.time))
%  ylabel('Cumulative O2 flux (mmol.m^-^2)')
%  xlabel('Time (s)')
%  
%% Eddy Covariance calculation from segment velocities and angles

ECsegt.rawvelocites = Automate.velocityFileSegt(:,14:16)/1000;
ECsegt.velocitiesAutomateAligned = Automate.velocityFileSegt(:,7:9)/1000;
ECsegt.oxygenFirestingInterp = Firesting.FirestingInterp;
ECsegt.timeInterp = Firesting.timeInterp;

for i =  1:length(Automate.velocityFileSegt)
    if Automate.goodCorrelation(i) == 1
     ECsegt.rawvelocites(i,:) = NaN;
     %ECsegt.oxygenFirestingInterp(i) = NaN;
     %ECsegt.timeInterp(i) = NaN;
     ECsegt.velocitiesAutomateAligned(i,:) = NaN;
    end
end

ECsegt.rawvelociteZ = ECsegt.rawvelocites(:,3);
ECsegt.rawvelociteY = ECsegt.rawvelocites(:,2);
ECsegt.rawvelociteX = ECsegt.rawvelocites(:,1);

% ECsegt.rawvelocityZDespiked =  ECsegt.rawvelociteZ(~isnan(ECsegt.rawvelociteZ));
% ECsegt.rawvelocityYDespiked =  ECsegt.rawvelociteY(~isnan(ECsegt.rawvelociteY));
% ECsegt.rawvelocityXDespiked =  ECsegt.rawvelociteX(~isnan(ECsegt.rawvelociteX));

ECsegt.rawvelocityZDespiked = fillmissing(ECsegt.rawvelociteZ,'linear');
ECsegt.rawvelocityYDespiked = fillmissing(ECsegt.rawvelociteY,'linear');
ECsegt.rawvelocityXDespiked = fillmissing(ECsegt.rawvelociteX,'linear');

ECsegt.rawvelocitiesDespiked = ECsegt.rawvelocityXDespiked;
ECsegt.rawvelocitiesDespiked(:,2) = ECsegt.rawvelocityYDespiked;
ECsegt.rawvelocitiesDespiked(:,3) = ECsegt.rawvelocityZDespiked;

ECsegt.rawvelociteZAutomateAligned = ECsegt.velocitiesAutomateAligned(:,3);
ECsegt.rawvelociteYAutomateAligned = ECsegt.velocitiesAutomateAligned(:,2);
ECsegt.rawvelociteXAutomateAligned = ECsegt.velocitiesAutomateAligned(:,1);

% ECsegt.rawvelocityZDespikedAutomateAligned =  ECsegt.rawvelociteZAutomateAligned(~isnan(ECsegt.rawvelociteZAutomateAligned));
% ECsegt.rawvelocityYDespikedAutomateAligned =  ECsegt.rawvelociteYAutomateAligned(~isnan(ECsegt.rawvelociteYAutomateAligned));
% ECsegt.rawvelocityXDespikedAutomateAligned =  ECsegt.rawvelociteXAutomateAligned(~isnan(ECsegt.rawvelociteXAutomateAligned));

ECsegt.rawvelocityZDespikedAutomateAligned = fillmissing(ECsegt.rawvelociteZAutomateAligned,'linear');
ECsegt.rawvelocityYDespikedAutomateAligned = fillmissing(ECsegt.rawvelociteYAutomateAligned,'linear');
ECsegt.rawvelocityXDespikedAutomateAligned = fillmissing(ECsegt.rawvelociteXAutomateAligned,'linear');

[ECsegt.Alpha,ECsegt.Beta,ECsegt.VelocitesAligned]=kot(ECsegt.rawvelocitiesDespiked,1,2,3);

ECsegt.VelocityZAligned = ECsegt.VelocitesAligned(:,3);

REA.stdVelocityZAligned = std(ECsegt.VelocityZAligned); 

ECsegt.oxygenFirestingInterpDespiked = ECsegt.oxygenFirestingInterp(~isnan(ECsegt.oxygenFirestingInterp));
ECsegt.timeInterpDespiked = ECsegt.timeInterp(~isnan(ECsegt.timeInterp));

%[ECsegt.VelocityZAlignedDespiked, ECsegt.Velip,] = func_despike_phasespace3d( ECsegt.VelocityZAligned, 9, 2 );

[ECsegt.time_TimeShift, ECsegt.velocityZPrime_TimeShift, ECsegt.oxygenPrime_TimeShift, ECsegt.ecFluxOxygen_TimeShift, ECsegt.ecFluxOxygen_NoTimeShift, ECsegt.velocityZPrime, ECsegt.oxygenPrime, ECsegt.iFigure, ECsegt.bestpValue, ECsegt.pvalues] ...
= segment_time_shift_EC( Param, ECsegt.timeInterpDespiked, ECsegt.VelocityZAligned, ECsegt.oxygenFirestingInterpDespiked, 1);%this synchronazation use the velocity alligned collected by the automation NO FLUCTUATION EXTRACTION
   %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro_EC'])
  
[~, ECsegt.ecFluxOxygen, ~, ~, ECsegt.reaFluxOxygen, ~, ...
 ~, ECsegt.ecOgiveOxygen, ~, ~, ECsegt.reaOgiveOxygen, ~, ECsegt.nFrequencyFFT]= ...
 segment_fluxes_ogives3(ECsegt.velocityZPrime_TimeShift, ECsegt.oxygenPrime_TimeShift, ECsegt.oxygenPrime_TimeShift,ECsegt.oxygenPrime_TimeShift,0,  ...
 Automate.velocityZThreshold, 1, 1,Param.NFREQUENCYFFT, Param.ADVSAMPLINGFREQUENCY, Param.RUNNINGAVERAGE);

[segFrequency, fig] = segment_plots(Depl,Param,ECsegt.ecOgiveOxygen,ECsegt.ecOgiveOxygen);%ploting the ogive


% Processes the running average from the angles from the automation 
[ECsegt.time_TimeShiftAutomateAligned, ECsegt.velocityZPrime_TimeShiftAutomateAligned, ECsegt.oxygenPrime_TimeShiftAutomateAligned, ECsegt.ecFluxOxygen_TimeShiftAutomateAligned, ECsegt.ecFluxOxygen_NoTimeShiftAutomateAligned, ECsegt.velocityZPrimeAutomateAligned, ECsegt.oxygenPrimeAutomateAligned, ECsegt.iFigureAutomateAligned, ECsegt.bestpValueAutomateAligned, ECsegt.pvaluesAutomateAligned] ...
= segment_time_shift_EC( Param, ECsegt.timeInterpDespiked, ECsegt.rawvelocityZDespikedAutomateAligned, ECsegt.oxygenFirestingInterpDespiked, 1);%this synchronazation use the velocity alligned collected by the automation NO FLUCTUATION EXTRACTION
   %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro_EC'])
  
[~, ECsegt.ecFluxOxygenAutomateAligned, ~, ~, ECsegt.reaFluxOxygenAutomateAligned, ~, ...
 ~, ECsegt.ecOgiveOxygenAutomateAligned, ~, ~, ECsegt.reaOgiveOxygenAutomateAligned, ~, ECsegt.nFrequencyFFTAutomateAligned]= ...
 segment_fluxes_ogives3(ECsegt.velocityZPrime_TimeShiftAutomateAligned, ECsegt.oxygenPrime_TimeShiftAutomateAligned, ECsegt.oxygenPrime_TimeShiftAutomateAligned,ECsegt.oxygenPrime_TimeShiftAutomateAligned,0,  ...
 Automate.velocityZThreshold, 1, 1,Param.NFREQUENCYFFT, Param.ADVSAMPLINGFREQUENCY, Param.RUNNINGAVERAGE);

[segFrequencyAutomateAligned, figAutomateAligned] = segment_plots(Depl,Param,ECsegt.ecOgiveOxygenAutomateAligned,ECsegt.ecOgiveOxygenAutomateAligned);%ploting the ogive


%% Transforming Velcoity in 4 Hz for Eddy Covariance at 4Hz
if iDeployment ~= 14
EC4Hz.rawvelocites = ECsegt.rawvelocites;
EC4Hz.rawvelocitesX= EC4Hz.rawvelocites(:,1);
EC4Hz.rawvelocitesY= EC4Hz.rawvelocites(:,2);
EC4Hz.rawvelocitesZ= EC4Hz.rawvelocites(:,3);

 EC4Hz.rawvelocitesZFilled = fillmissing(EC4Hz.rawvelocitesZ,'linear');
 EC4Hz.rawvelocitesYFilled = fillmissing(EC4Hz.rawvelocitesY,'linear');
 EC4Hz.rawvelocitesXFilled = fillmissing(EC4Hz.rawvelocitesX,'linear');

%EC4Hz.rawvelocitesZFilled = fillmissing(EC4Hz.rawvelocitesZ,'movmedian',30);
%EC4Hz.rawvelocitesYFilled = fillmissing(EC4Hz.rawvelocitesY,'movmedian',30);
%EC4Hz.rawvelocitesXFilled = fillmissing(EC4Hz.rawvelocitesX,'movmedian',30);

EC4Hz.rawvelocitesFilled = EC4Hz.rawvelocitesXFilled;
EC4Hz.rawvelocitesFilled(:,2) = EC4Hz.rawvelocitesYFilled;
EC4Hz.rawvelocitesFilled(:,3) = EC4Hz.rawvelocitesZFilled;

[EC4Hz.Alpha,EC4Hz.Beta,EC4Hz.VelocitesAligned]=kot(EC4Hz.rawvelocitesFilled,1,2,3);

EC4Hz.velocityZ = EC4Hz.VelocitesAligned(:,6);

%or
F = fillmissing(EC4Hz.rawvelocitesZ,'movmedian',20); % Using mooving median 

[EC4Hz.timeInterp,EC4Hz.VelocityZInterp4Hz] = interpolation_field_Vel_degradation(Param,EC4Hz.velocityZ,Firesting.timeOxygenFiresting); % interpolating the oxygen measurement frequency to the same frequency as the velocity

[EC4Hz.time_TimeShiftAutomateAligned, EC4Hz.velocityZPrime_TimeShiftAutomateAligned, EC4Hz.oxygenPrime_TimeShiftAutomateAligned, EC4Hz.ecFluxOxygen_TimeShiftAutomateAligned, EC4Hz.ecFluxOxygen_NoTimeShiftAutomateAligned, EC4Hz.velocityZPrimeAutomateAligned, EC4Hz.oxygenPrimeAutomateAligned, EC4Hz.iFigureAutomateAligned, EC4Hz.bestpValueAutomateAligned, EC4Hz.pvaluesAutomateAligned] ...
= segment_time_shift_EC( Param, Firesting.timeOxygenFiresting, EC4Hz.VelocityZInterp4Hz, Firesting.CompensatedNeedle, 1);%this synchronazation use the velocity alligned collected by the automation NO FLUCTUATION EXTRACTION
   %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro_EC'])
  
[~, EC4Hz.ecFluxOxygenAutomateAligned, ~, ~, EC4Hz.reaFluxOxygenAutomateAligned, ~, ...
 ~, EC4Hz.ecOgiveOxygenAutomateAligned, ~, ~, EC4Hz.reaOgiveOxygenAutomateAligned, ~, EC4Hz.nFrequencyFFTAutomateAligned]= ...
 segment_fluxes_ogives3(EC4Hz.velocityZPrime_TimeShiftAutomateAligned, EC4Hz.oxygenPrime_TimeShiftAutomateAligned, EC4Hz.oxygenPrime_TimeShiftAutomateAligned,EC4Hz.oxygenPrime_TimeShiftAutomateAligned,0,  ...
 Automate.velocityZThreshold, 1, 1,Param.NFREQUENCYFFT, Param.ADVSAMPLINGFREQUENCY, Param.RUNNINGAVERAGE);

[segFrequency, figAutomate] = segment_plots(Depl,Param,EC4Hz.ecOgiveOxygenAutomateAligned,EC4Hz.ecOgiveOxygenAutomateAligned);%ploting the ogive

end
%time = (0:1/Param.ADVSAMPLINGFREQUENCY:length(ECsegt.rawvelocityZDespikedAutomateAligned)/Param.ADVSAMPLINGFREQUENCY)';

%% REA data processing USELESS
%Analyzing the delay and estimating flow rate in each tube
%Analisys of the delay measured in the compensation procedure
%With the two valves open it is possible to estimate the inherent delay
%between the probes in the sampling tubes and the probe in the probe used
%for EC

% delayTest.oxygenFirestingNeedle = Compensation.Firesting.Needle.oxygenCompensated;
% delayTest.oxygenFirestingUp = Compensation.Firesting.UP.oxygenCompensated;
% delayTest.oxygenFirestingDown = Compensation.Firesting.DOWN.oxygenCompensated;
% 
% delayTest.oxygenFirestingNeedlePrime = Compensation.Firesting.Needle.oxygenCompensated - mean(Compensation.Firesting.Needle.oxygenCompensated);
% delayTest.oxygenFirestingUpPrime = Compensation.Firesting.UP.oxygenCompensated - mean(Compensation.Firesting.UP.oxygenCompensated);
% delayTest.oxygenFirestingDownPrime = Compensation.Firesting.DOWN.oxygenCompensated - mean(Compensation.Firesting.DOWN.oxygenCompensated);
% 
% figure;plot(delayTest.oxygenFirestingUpPrime);hold on
% plot(delayTest.oxygenFirestingDownPrime,'r')
% ylabel('Oxygen concentration (µmol.l^-^1)')
% legend('UP','DOWN','location','southeast')
% legend('boxoff')
% 
% delayTest.resultDownNeedle = (0:10)';% Initializing vectors for results of the test
% delayTest.resultPDownNeedle = (0:10)';
% 
% for i = 0:10 %10 points for delay analysis 
%     delayTest.aDown = delayTest.oxygenFirestingDownPrime(i+1:end);%shifiting down dataset over needle
%     delayTest.bNeedle1 = delayTest.oxygenFirestingNeedlePrime(1:end-i);
%     [delayTest.RDownNeedle,delayTest.PValueDownNeedle] = corrcoef(delayTest.aDown, delayTest.bNeedle1); %Pearson correlation test for each index shift
%     delayTest.resultDownNeedle(i+1) = delayTest.RDownNeedle(1,2);
%     delayTest.resultPDownNeedle(i+1) = delayTest.PValueDownNeedle(1,2);
%     delayTest.aDown = delayTest.oxygenFirestingDownPrime;
%     delayTest.bNeedle1 = delayTest.oxygenFirestingNeedlePrime;
% end
% 
% [delayTest.RDownNeedleNoShift,delayTest.PValueDownNeedleNoShift] = corrcoef(delayTest.oxygenFirestingDown, delayTest.oxygenFirestingNeedle);
% delayTest.RDownNeedleNoShift = delayTest.RDownNeedleNoShift(2,1);
% delayTest.PValueDownNeedleNoShift = delayTest.PValueDownNeedleNoShift(2,1);
% 
% delayTest.RDownNeedle = max(delayTest.resultDownNeedle);%Selecting highest Correlation coefficient
% delayTest.iDelayDownNeedle = find(delayTest.resultDownNeedle==max(delayTest.resultDownNeedle));
% delayTest.pDownNeedle = delayTest.resultPDownNeedle(delayTest.iDelayDownNeedle);
% 
% delayTest.resultUpNeedle = (0:10)';
% delayTest.resultPUpNeedle = (0:10)';
% 
% for i = 0:10
%     delayTest.aUp = delayTest.oxygenFirestingUpPrime(i+1:end);
%     delayTest.bNeedle2 = delayTest.oxygenFirestingNeedlePrime(1:end-i);
%     [delayTest.RUpNeedle,delayTest.PValueUpNeedle] = corrcoef(delayTest.aUp, delayTest.bNeedle2); 
%     delayTest.resultUpNeedle(i+1) = delayTest.RUpNeedle(1,2);
%     delayTest.resultPUpNeedle(i+1) = delayTest.PValueUpNeedle(1,2);    
%     delayTest.aUp = delayTest.oxygenFirestingUpPrime;
%     delayTest.bNeedle2 = delayTest.oxygenFirestingNeedlePrime;
% end
% 
% [delayTest.RUpNeedleNoShift,delayTest.PValueUpNeedleNoShift] = corrcoef(delayTest.oxygenFirestingUp, delayTest.oxygenFirestingNeedle);
% delayTest.RUpNeedleNoShift = delayTest.RUpNeedleNoShift(2,1);
% delayTest.PValueUpNeedleNoShift = delayTest.PValueUpNeedleNoShift(2,1);
% 
% delayTest.RUpNeedle = max(delayTest.resultUpNeedle);
% delayTest.iDelayUpNeedle = find(delayTest.resultUpNeedle==max(delayTest.resultUpNeedle));
% delayTest.pUpNeedle = delayTest.resultPUpNeedle(delayTest.iDelayUpNeedle);
% 
% delayTest.resultUpDown = (0:10)';
% delayTest.resultPUpDown = (0:10)';
% 
% for i = 0:10
%     delayTest.aUp2 = delayTest.oxygenFirestingUpPrime(i+1:end);
%     delayTest.bDown2 = delayTest.oxygenFirestingDownPrime(1:end-i);
%     [delayTest.RUpDown,delayTest.PValueUpDown] = corrcoef(delayTest.aUp2, delayTest.bDown2); 
%     delayTest.resultUpDown(i+1) = delayTest.RUpDown(1,2);
%     delayTest.resultPUpDown(i+1) = delayTest.PValueUpDown(1,2);    
%     delayTest.aUp2 = delayTest.oxygenFirestingUpPrime;
%     delayTest.bDown2 = delayTest.oxygenFirestingNeedlePrime;
% end
% 
% delayTest.RUpDown = max(delayTest.resultUpDown);
% delayTest.iDelayUpDown = find(delayTest.resultUpDown==max(delayTest.resultUpDown));

%% Oxygen measurements in the tubes
[Firesting.DOWN.timeInterp,Firesting.DOWN.oxygenInterp] = interpolation_field_validation(Param, Firesting.DOWN.oxygenCompensated,Firesting.timeOxygenFiresting); % interpolating the oxygen measurement frequency to the same frequency as the velocity
[Firesting.UP.timeInterp,Firesting.UP.oxygenInterp] = interpolation_field_validation(Param, Firesting.UP.oxygenCompensated,Firesting.timeOxygenFiresting); % interpolating the oxygen measurement frequency to the same frequency as the velocity

  if iDeployment == 56
    Automate.valveDOWNaction(140:146) = 0;
    Automate.valveUPaction(140:146) = 0;
    Automate.valveDOWNaction(1199:1202) = 0;
    Automate.valveUPaction(1199:1202) = 0;
    Automate.valveDOWNaction(1899:2053) = 0;
    Automate.valveUPaction(1899:2053) = 0;
  end
 
  if iDeployment == 57
    Automate.valveDOWNaction(1190:1310) = 0;
    Automate.valveUPaction(1190:1310) = 0;
    Automate.valveDOWNaction(3371:3375) = 0;
    Automate.valveUPaction(3371:3375) = 0;
  end
 
    if iDeployment == 58
    Automate.valveDOWNaction(3707:3780) = 0;
    Automate.valveUPaction(3707:3780) = 0;
    Automate.valveDOWNaction(3371:3375) = 0;
    Automate.valveUPaction(3371:3375) = 0;
    end
 
    if iDeployment == 61
    Automate.valveDOWNaction(1554:1609) = 0;
    Automate.valveUPaction(1554:1609) = 0;
    Automate.valveDOWNaction(2904:2996) = 0;
    Automate.valveUPaction(2904:2996) = 0;
    end

% if iDeployment == 14
%     Firesting.DOWN.timeInterp(2103:2183)=[];
%     Firesting.DOWN.oxygenInterp(2103:2183) = [];
%     Firesting.UP.timeInterp(2103:2183)=[];
%     Firesting.UP.oxygenInterp(2103:2183) = [];
% end

if iDeployment == 64 || iDeployment == 14
    Firesting.DOWN.timeInterp(end)=[];
    Firesting.DOWN.oxygenInterp(end) = [];
    Firesting.UP.timeInterp(end)=[];
    Firesting.UP.oxygenInterp(end) = [];
end

if iDeployment == 18
    
    Firesting.DOWN.timeInterp(end-5:end)=[];
    Firesting.DOWN.oxygenInterp(end-5:end) = [];
    Firesting.UP.timeInterp(end-5:end)=[];
    Firesting.UP.oxygenInterp(end-5:end) = [];
end


%   if iDeployment == 1
%     Automate.valveDOWNaction(140:146) = 0;
%     Automate.valveUPaction(140:146) = 0;
%     Automate.valveDOWNaction(1199:1202) = 0;
%     Automate.valveUPaction(1199:1202) = 0;
%     Automate.valveDOWNaction(1899:2053) = 0;
%     Automate.valveUPaction(1899:2053) = 0;
%   end
%  
%   if iDeployment == 2
%     Automate.valveDOWNaction(1190:1310) = 0;
%     Automate.valveUPaction(1190:1310) = 0;
%     Automate.valveDOWNaction(3371:3375) = 0;
%     Automate.valveUPaction(3371:3375) = 0;
%   end
%  
%     if iDeployment == 3
%     Automate.valveDOWNaction(3707:3780) = 0;
%     Automate.valveUPaction(3707:3780) = 0;
%     Automate.valveDOWNaction(3371:3375) = 0;
%     Automate.valveUPaction(3371:3375) = 0;
%     end
%  
%     if iDeployment == 5
%     Automate.valveDOWNaction(1554:1609) = 0;
%     Automate.valveUPaction(1554:1609) = 0;
%     Automate.valveDOWNaction(2904:2996) = 0;
%     Automate.valveUPaction(2904:2996) = 0;
%     end
 
REA.valveDOWNactionOxygenTemp = Automate.valveDOWNaction.*Firesting.DOWN.oxygenInterp;
REA.valveUPactionOxygenTemp = Automate.valveUPaction.*Firesting.UP.oxygenInterp;

REA.ivalveDOWNactionOxygenTemp = find(0==REA.valveDOWNactionOxygenTemp);
REA.ivalveUPactionOxygenTemp = find(0==REA.valveUPactionOxygenTemp);
REA.valveDOWNactionOxygenTemp(REA.ivalveDOWNactionOxygenTemp) = NaN;
REA.valveUPactionOxygenTemp(REA.ivalveUPactionOxygenTemp) = NaN;

REA.valveDOWNactionOxygenECTemp = Automate.valveDOWNaction.*Firesting.FirestingInterp;
REA.valveUPactionOxygenECTemp = Automate.valveUPaction.*Firesting.FirestingInterp;

REA.ivalveDOWNactionOxygenECTemp = find(0==REA.valveDOWNactionOxygenECTemp);
REA.ivalveUPactionOxygenECTemp = find(0==REA.valveUPactionOxygenECTemp);
REA.valveDOWNactionOxygenECTemp(REA.ivalveDOWNactionOxygenECTemp) = NaN;
REA.valveUPactionOxygenECTemp(REA.ivalveUPactionOxygenECTemp) = NaN;

%REA.valveDOWNactionOxygen = nonzeros(REA.valveDOWNactionOxygenTemp);
REA.valveDOWNactionOxygenMean = mean(REA.valveDOWNactionOxygenTemp,'omitnan');
%REA.valveUPactionOxygen = nonzeros(REA.valveUPactionOxygenTemp);
REA.valveUPactionOxygenMean = mean(REA.valveUPactionOxygenTemp,'omitnan');

%REA.valveDOWNactionECOxygen = nonzeros(REA.valveDOWNactionOxygenECTemp);
REA.valveDOWNactionECOxygenMean = mean(REA.valveDOWNactionOxygenECTemp,'omitnan');
%REA.valveUPactionECOxygen = nonzeros(REA.valveUPactionOxygenECTemp);
REA.valveUPactionECOxygenMean = mean(REA.valveUPactionOxygenECTemp,'omitnan');

% Compensating inherent probe bias
Compensation.Firesting.UP.oxygenCompensatedMean = mean(Compensation.Firesting.UP.oxygenCompensated);
Compensation.Firesting.DOWN.oxygenCompensatedMean = mean(Compensation.Firesting.DOWN.oxygenCompensated);
Compensation.concDiff = mean(Compensation.Firesting.UP.oxygenCompensated)-mean(Compensation.Firesting.DOWN.oxygenCompensated);
%Compensation.ConcDiffNeedleDown = mean(Compensation.Needle.oxygenFiresting)-mean(Compensation.DOWN.oxygenFirestingCompensation);
%Compensation.ConcDiffNeedleUp = mean(Compensation.Needle.oxygenFiresting)-mean(Compensation.UP.oxygenFirestingCompensation);

figure;plot(Firesting.DOWN.oxygenInterp+Compensation.concDiff);hold on
plot(Firesting.UP.oxygenInterp)
plot(REA.valveDOWNactionOxygenTemp+Compensation.concDiff,'ko')
plot(REA.valveUPactionOxygenTemp,'ko')
legend('DOWN', 'UP','Valve Open')
legend('boxoff')

figure;plot(Firesting.DOWN.oxygenInterp+Compensation.concDiff);hold on%!!!
plot(Firesting.UP.oxygenInterp)
plot(Firesting.FirestingInterp)
legend('DOWN', 'UP', 'Needle')
ylabel('Oxygen Concentration (mmol.m^-^3)')
 xlabel('Time 1/8 (s)')
 legend('boxoff')


figure;plot(Compensation.Firesting.Needle.oxygenCompensated-mean(Compensation.Firesting.Needle.oxygenCompensated));hold on; plot(Compensation.Firesting.UP.oxygenCompensated-mean(Compensation.Firesting.UP.oxygenCompensated));plot(Compensation.Firesting.DOWN.oxygenCompensated(5:end)-mean(Compensation.Firesting.DOWN.oxygenCompensated))
legend('Needle', 'UP', 'DOWN')

% Calculating oxygen fluxes by REA no delay is applied

REA.oxyDifConcCompensated = REA.valveUPactionOxygenMean-REA.valveDOWNactionOxygenMean-Compensation.concDiff;%previously Allopen.ConcDiff was subtracted 

REA.oxyDifConcEC = REA.valveUPactionECOxygenMean-REA.valveDOWNactionECOxygenMean;%previously Allopen.ConcDiff was subtracted 

% if Automate.velocityZThreshold==0
% REA.bCoef = 0.6;
% end
% 
% if Automate.velocityZThreshold ~=0 
% REA.bCoef = 0.3;
% end

REA.stdVelocityZ = std(Automate.velocityZPrimeAutomate);
%REA.stdVelocityZ = std(ECsegt.VelocityZAligned);

if max(Automate.velocityZThreshold./REA.stdVelocityZ) < 2
%REA.bCoefFit = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./REA.stdVelocityZ);%!!!
REA.bCoefFit = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./REA.stdVelocityZAligned);%!!!

else 
REA.bCoefFit = NaN;  
end

REA.OxyFlux = (REA.bCoefFit*REA.stdVelocityZ*REA.oxyDifConcCompensated)*24*3600; %mmol/m2/day

REA.bCoefEC = (EC.despiking.ecFluxOxygen_TimeShift/24/3600)/(REA.stdVelocityZ*REA.oxyDifConcCompensated);

REA.OxyFluxEC = (REA.bCoefFit*REA.stdVelocityZ*REA.oxyDifConcEC)*24*3600; %mmol/m2/day

REA.bCoefREAsimulated = (EC.despiking.ecFluxOxygen_TimeShift/3600/24)/(REA.stdVelocityZ*REA.oxyDifConcEC);

%% REA measurement analysis for oxygen fluxes
j=1;
REA.bCoefFitOvertime = 0;
REA.valveUPactionOxygenTempOvertime = 0;
REA.valveDOWNactionOxygenTempOvertime = 0;
REA.valveUPactionECOxygenOvertime = 0;
REA.valveDOWNactionECOxygenOvertime = 0;
REA.stdVelocityZOvertime = 0;
REA.oxyFluxOvertime = 0;

% for i = 30*8:length(REA.valveUPactionOxygenTemp)
% REA.bCoefFitOvertime(j) = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./std(Automate.velocityZPrimeAutomate(1:i,1)));
% REA.valveUPactionOxygenTempOvertime(j)= mean(REA.valveUPactionOxygenTemp(1:i,1),'omitnan');
% REA.valveDOWNactionOxygenTempOvertime(j)= mean(REA.valveDOWNactionOxygenTemp(1:i,1),'omitnan');
% REA.stdVelocityZOvertime(j) = std(Automate.velocityZPrimeAutomate(1:i,1));
% REA.oxyFluxOvertime(j) = REA.bCoefFit(j)*REA.stdVelocityZ(j)*(REA.valveUPactionOxygenTempOvertime(j)- REA.valveDOWNactionOxygenTempOvertime(j)-Compensation.concDiff)*24*3600;
% j = j+1;
% end

for i = 30*8:length(REA.valveUPactionOxygenTemp)
REA.valveUPactionOxygenTempOvertime(j,1)= nanmean(REA.valveUPactionOxygenTemp(1:i,1));
REA.valveDOWNactionOxygenTempOvertime(j,1)= nanmean(REA.valveDOWNactionOxygenTemp(1:i,1));
REA.valveUPactionECOxygenOvertime(j,1) = nanmean(REA.valveUPactionOxygenECTemp(1:i,1));
REA.valveDOWNactionECOxygenOvertime(j,1) = nanmean(REA.valveDOWNactionOxygenECTemp(1:i,1));
REA.bCoefFitOvertime(j) = 0.144 + (0.627-0.144)*exp(-1.04*Automate.velocityZThreshold./std(Automate.velocityZPrimeAutomate(1:i,1)));
REA.stdVelocityZOvertime(j) = std(Automate.velocityZPrimeAutomate(1:i,1));
REA.oxyFluxOvertime(j) = REA.bCoefFitOvertime(j)*REA.stdVelocityZOvertime(j)*(REA.valveUPactionOxygenTempOvertime(j)- REA.valveDOWNactionOxygenTempOvertime(j)-Compensation.concDiff)*24*3600;
%REA.concDiffOvertime(j)=(REA.valveUPactionOxygenTempOvertime(j)- REA.valveDOWNactionOxygenTempOvertime(j)-Compensation.concDiff);
j = j+1;
end

REA.time = 0:1/8:(length(REA.oxyFluxOvertime)/8);
REA.time(end) = [];
REA.time = REA.time';

REA.Test = REA.valveUPactionOxygenTempOvertime-REA.valveDOWNactionOxygenTempOvertime;
REA.Test(:,2) = REA.Test-Compensation.concDiff;
REA.Test(:,3) = REA.Test(:,2).*REA.time;
REA.stdVelocityZOvertime = REA.stdVelocityZOvertime';

REA.TestEC = REA.valveUPactionECOxygenOvertime-REA.valveDOWNactionECOxygenOvertime;
REA.TestEC(:,2) = REA.TestEC(:,1).*REA.time;
REA.TestEC(:,3) = REA.TestEC(:,2)*REA.stdVelocityZAligned*REA.bCoefFit;

%REA.Test(:,4) = REA.Test(:,3).*REA.stdVelocityZOvertime;



%   figure;
%   subplot(1,3,1);
%   plot(REA.time,REA.Test(:,3));hold on
%   plot(EC.despiking.time,cumsum(EC.despiking.fluxEcCum),'r')
%   xlabel('time(s)')
%  legend('REA: \DeltaC*time', ' EC: O_2 cum','location','northeast')
%   legend('boxoff')
%   title('REA: \DeltaC*time (mmol.m^-^3.s)','vs. EC: cumsum(wc) (mmol.m^-^2)')
% %  
%  subplot(1,3,2);
% plot(REA.time,REA.Test(:,4));hold on
%   plot(EC.despiking.time,cumsum(EC.despiking.fluxEcCum),'r')
% xlabel('time(s)')
%  legend('REA: \DeltaC*time*std(w)', 'EC: O_2 cum','location','northeast')
%   legend('boxoff')
%   title('REA: \DeltaC*time*std(w)(mmol.m^-^2)', 'vs. EC: O_2 cum (mmol.m^-^2)')
% %  
%   subplot(1,3,3);
% plot(REA.time,cumsum(REA.Test(:,4)));hold on
%   plot(EC.despiking.time,cumsum(EC.despiking.fluxEcCum),'r')
% xlabel('time(s)')
%  legend('REA: cumsum(\DeltaC*time*std(w))', 'EC: O_2 cum','location','northeast')
%   legend('boxoff')
%   title('REA: cumsum(\DeltaC*time*std(w)) (mmol.m^-^2)','vs. EC: O_2 cum (mmol.m^-^2)')

figure;plot(REA.oxyFluxOvertime)
title('REA overtime')

%% Angles analysis
%Angles.velocityFileVel = Angles.velocityFile{:,2:4};
%[Angles.noCorrAlpha,Angles.noCorrBeta,Angles.vel]=kot(Angles.velocityFileVel,1,2,3);
%Angles.noCorrVelocityThreshold = std(Angles.vel(:,6))*0.75;

Angles.preVelocityThreshold = Automate.velocityFileSegt(1,10);
Angles.preAlpha = Automate.velocityFileSegt(1,12);
Angles.preBeta = Automate.velocityFileSegt(1,13);

Angles.sgtRawVelocities = Automate.velocityFileSegt(:,14:16);
Angles.A = (0:1/Param.ADVSAMPLINGFREQUENCY:(length(Angles.sgtRawVelocities)/Param.ADVSAMPLINGFREQUENCY))';
Angles.A(end) = [];
Angles.sgtRawVelocities(:,4) = Angles.A;
Angles.iGoodCorrelation = find(1==Automate.goodCorrelation);
%Angles.sgtRawvelocitiesTest = Angles.sgtRawVelocities;
Angles.sgtRawVelocities(Angles.iGoodCorrelation,:) = [];
[Angles.sgtAlpha,Angles.sgtBeta,Angles.sgtvel]=kot(Angles.sgtRawVelocities,1,2,3);

Angles.sgtAlpha(2) = Angles.sgtAlpha*180/pi();
Angles.sgtBeta(2) = Angles.sgtBeta*180/pi();

j=1;
Angles.overtimeAlpha = 0;
Angles.overtimeBeta = 0;
for i = 240:length(Angles.sgtRawVelocities)
[Angles.overtimeAlpha(j),Angles.overtimeBeta(j),~]=kot(Angles.sgtRawVelocities(1:i,:),1,2,3);
j = j+1;
end
Angles.overtimeAlpha = (Angles.overtimeAlpha)';
Angles.overtimeBeta = (Angles.overtimeBeta)';

Angles.overtimeAlpha(:,2)= Angles.overtimeAlpha.*180/pi();
Angles.overtimeBeta(:,2)= Angles.overtimeBeta.*180/pi();
Angles.preAlpha(2) = Angles.preAlpha*180/pi();
Angles.preBeta(2) = Angles.preBeta*180/pi();

Angles.time = Angles.sgtRawVelocities(240:end,4);
Angles.x = [0 max(Angles.time)];
Angles.y = [Angles.preBeta(2) Angles.preBeta(2)];
Angles.y2 = [Angles.preAlpha(2) Angles.preAlpha(2)];


j=1;
Angles.windowsize = [30 60 90 120 180];%s
Angles.movingAlpha = [0 0 0 0];
Angles.movingBeta = [0 0 0 0];
for l = 1:length(Angles.windowsize)
for i = 0:(length(Angles.sgtRawVelocities)-Angles.windowsize(l)*Param.ADVSAMPLINGFREQUENCY)-1
[Angles.movingAlpha(j,l),Angles.movingBeta(j,l),~]=kot(Angles.sgtRawVelocities(1+i:Angles.windowsize(l)+i,:),1,2,3);
j = j+1;
end
j=1;
end
Angles.movingAlpha = Angles.movingAlpha*180/pi();
Angles.movingBeta = Angles.movingBeta*180/pi();
Angles.movingAlpha(0==Angles.movingAlpha) = NaN;
Angles.movingBeta(0==Angles.movingBeta) = NaN;

figure;
subplot(2,2,1)
plot(Angles.time,Angles.overtimeAlpha(:,2));hold on
line(Angles.x,Angles.y2,'Color','r')
xlabel('Time (s)')
ylabel('Angles (°)')
legend('During segt','Pre-calculated')
legend('boxoff')
title('Angle alpha during the segment')

subplot(2,2,2)
plot(Angles.movingAlpha)
%line(Angles.x,Angles.y,'Color','r')
title('Angle alpha during the segment','using different sizes of moving average')
xlabel('Time (s)')
ylabel('Angles (°)')
legend('30s', '60s', '90s', '120s', '180', 'Pre-calculated')
legend('boxoff')

subplot(2,2,3)
plot(Angles.time,Angles.overtimeBeta(:,2));hold on
line(Angles.x,Angles.y,'Color','r')
xlabel('Time 1/8 (s)')
ylabel('Angles (°)')
legend('During segt','Pre-calculated')
legend('boxoff')
title('Angle beta during the segment')

subplot(2,2,4)
plot(Angles.movingBeta)
title('Angle beta during the segment','using different sizes of moving average')
xlabel('Time 1/8 (s)')
ylabel('Angles (°)')
legend('30s', '60s', '90s', '120s', '180', 'Pre-calculated')
legend('boxoff')
%REA.OxyDiffBasedOnEC = EC.ecFluxOxygen_AutomateDouble/3600/24/(REA.stdVelocityZ*(REA.bCoef));

% Automate.VelocitiesForAlign = Depl.velocityfile(Automate.iStart:Automate.iEnd,15:17);
% [alpha,beta,Automate.VelocitiesAligned]=kot(Automate.VelocitiesForAlign,1,2,3);
% 
% % Calculating the b Coeff based on Ammann and Meixner 2002 calculations 
% Automate.VelocityAlignedZ = Automate.VelocitiesAligned(:,6);
% Automate.VelocityAlignedZpos = Automate.VelocityAlignedZ(Automate.VelocityAlignedZ>0);
% Automate.VelocityAlignedZneg = Automate.VelocityAlignedZ(Automate.VelocityAlignedZ<0);

% REA.bCoefFit = nan(size(automate.velocityZThreshold));
% indexGoodThreshold = automate.velocityZThreshold./REA.stdVelocityZ < 2;
% REA.bCoefFit(indexGoodThreshold) = 0.144 + (0.627-0.144)*exp(-1.04*automate.velocityZThreshold(indexGoodThreshold)./REA.stdVelocityZ(indexGoodThreshold));
%  REA.OxyFlux = (REA.bCoefFit*REA.stdVelocityZ*REA.oxyDifConcCompensatedDelayed)*24*3600; %mmol/m2/day
%  
%  figure;plot(REA.valveUPactionOxygenDelayed);hold on; plot(REA.valveDOWNactionOxygenDelayed+Compensation.concDiff,'r')
%  
 %% Advection contribution
 
%  EC.despiking.advection = mean(EC.despiking.velocityZDespiked.*EC.despiking.oxygenFirestingInterpDespiked)*24*3600;
%  EC.despiking.meanVelZ = mean(EC.despiking.velocityZDespiked); 

%% Correlation analysis
Automate.ratioGoodCorrelationOvertime = (cumsum(Automate.goodCorrelation))/length(Automate.goodCorrelation)*100;

Automate.ratioGoodCorrelation = max(Automate.ratioGoodCorrelationOvertime);

figure; plot(Automate.time, Automate.ratioGoodCorrelationOvertime)
 ylim([0 100])
 xlabel('Time (s)')
 ylabel('Proportion of bad velocity measurements (%)')
 title('Ratio of low correlation measurements',[num2str(Automate.ratioGoodCorrelation),'% low correlation values'])


figure;
t = tiledlayout(1,3);
correlation.mincorr = [min(Automate.velocityFile.VarName19) min(Automate.velocityFile.VarName20) min(Automate.velocityFile.VarName21)];
correlation.maxcorr = [max(Automate.velocityFile.VarName19) max(Automate.velocityFile.VarName20) max(Automate.velocityFile.VarName21)];
correlation.minvel = [min(Automate.velocityFile.VarName16/1000) min(Automate.velocityFile.VarName17/1000) min(Automate.velocityFile.VarName18/1000)];
correlation.maxvel = [max(Automate.velocityFile.VarName16/1000) max(Automate.velocityFile.VarName17/1000) max(Automate.velocityFile.VarName18/1000)];
correlation.mincorrPlot = min(correlation.mincorr);
correlation.maxcorrPlot = max(correlation.maxcorr);
correlation.minvelPlot = min(correlation.minvel);
correlation.maxvelPlot = max(correlation.maxvel);

%figure;
  
XcorX = [min(Automate.velocityFile.VarName15/1000) max(Automate.velocityFile.VarName15/1000)];
 Ycor = [70 70];
 ax1 = nexttile;
plot(Automate.velocityFile.VarName15/1000,Automate.velocityFile.VarName19,'.');hold on
 line(XcorX,Ycor,'Color','r')
 ylim([correlation.mincorrPlot correlation.maxcorrPlot])
% xlim([correlation.minvelPlot correlation.maxvelPlot]);
 xlabel('Velocity X (m.s^-^1)')
 ylabel('Correlation X (%)')
%  legend('Data','Correlation threshold','location','bestoutside')
%  legend('boxoff')
% title('Correlations for X velocities', '2020/10/14 - 2020/10/15')
ax2 = nexttile;
 XcorY = [min(Automate.velocityFile.VarName16/1000) max(Automate.velocityFile.VarName16/1000)];
 plot(Automate.velocityFile.VarName16/1000,Automate.velocityFile.VarName20,'.');hold on
 line(XcorY,Ycor,'Color','r')
  ylim([correlation.mincorrPlot correlation.maxcorrPlot])
% xlim([correlation.minvelPlot correlation.maxvelPlot]);
 xlabel('Velocity Y (m.s^-^1)')
 ylabel('Correlation Y (%)')
 hleg = legend('Data','Correlation threshold','location','northoutside');
htitle = get(hleg,'Title');
%set(htitle,'String','Beams Correlations for each velocity and its threshold')
 %legend('Data','Correlation threshold','location','northwest')
 legend('boxoff')
% title('Correlations for Y velocities', '2020/10/14 - 2020/10/15')

ax3 = nexttile;
 XcorZ = [min(Automate.velocityFile.VarName17/1000) max(Automate.velocityFile.VarName17/1000)];
 plot(Automate.velocityFile.VarName17/1000,Automate.velocityFile.VarName21,'.');hold on
 line(XcorZ,Ycor,'Color','r')
  ylim([correlation.mincorrPlot correlation.maxcorrPlot])
 %xlim([correlation.minvelPlot correlation.maxvelPlot]);
 xlabel('Velocity Z (m.s^-^1)')
 ylabel('Correlation Z (%)')
 %legend('Data','Correlation threshold','location','southeast')
 %legend('boxoff')
%  legend('Data','Correlation threshold','location','bestoutside')
%  legend('boxoff')
% title('Correlations for Z velocities', '2020/10/14 - 2020/10/15')

title(t,'Beams Correlations for each velocity and its threshold')

figure;plot(Compensation.Firesting.UP.oxygenCompensated);hold on;plot(Compensation.Firesting.DOWN.oxygenCompensated,'r')
legend('UP','Down')

figure;histfit(Firesting.CompensatedNeedle);
title('Oxygen data distribution for EC measurement')
xlabel('Oxygen concentration (mmol.m^-^3)')
ylabel('Total of observations')

%% Testing different oxygen delay over valve action on REA fluxes

for i = 0:5*Param.ADVSAMPLINGFREQUENCY
READelayed.valveDOWNactionOxygenTemp = Automate.valveDOWNaction(i+1:end).*Firesting.DOWN.oxygenInterp(1:end-i);
READelayed.valveUPactionOxygenTemp = Automate.valveUPaction(i+1:end).*Firesting.UP.oxygenInterp(1:end-i);
READelayed.ivalveDOWNactionOxygenTemp = find(0==READelayed.valveDOWNactionOxygenTemp);
READelayed.ivalveUPactionOxygenTemp = find(0==READelayed.valveUPactionOxygenTemp);
READelayed.valveDOWNactionOxygenTemp(READelayed.ivalveDOWNactionOxygenTemp) = NaN;
READelayed.valveUPactionOxygenTemp(READelayed.ivalveUPactionOxygenTemp) = NaN;

READelayed.valveDOWNactionOxygenMean(i+1) = mean(READelayed.valveDOWNactionOxygenTemp,'omitnan');
READelayed.valveUPactionOxygenMean(i+1) = mean(READelayed.valveUPactionOxygenTemp,'omitnan');
end

READelayed.valveDOWNactionOxygenMeanComp = READelayed.valveDOWNactionOxygenMean+Compensation.concDiff;

READelayed.valveDOWNactionOxygenMeanComp = (READelayed.valveDOWNactionOxygenMeanComp)';

READelayed.ConcDiffCompMatrix = REA.stdVelocityZAligned*REA.bCoefFit*(READelayed.valveUPactionOxygenMean - READelayed.valveDOWNactionOxygenMeanComp)*24*3600;


figure;plot(READelayed.valveDOWNactionOxygenMeanComp);hold on; plot(READelayed.valveUPactionOxygenMean,'r')
legend('DOWN', 'UP') 

figure;plot(24*3600*REA.stdVelocityZAligned*REA.bCoefFit*((READelayed.valveUPactionOxygenMean-READelayed.valveDOWNactionOxygenMean)-Compensation.concDiff));
title('Concentration difference on delay')

figure;contourf(READelayed.ConcDiffCompMatrix);
colorbar('southoutside')

%% Evaluating and Simulating axis alignement on measurement executed by REA
REAsimulated.velocityZThresholdSimulated = 0.75*REA.stdVelocityZAligned;

XcorX = [0 length(ECsegt.velocityZPrime)];
Ycor = [-(Automate.velocityZThreshold) -(Automate.velocityZThreshold)];
Zcor = [(Automate.velocityZThreshold) (Automate.velocityZThreshold)];
REAsimulated.valveDOWNactionTemp=Automate.valveDOWNaction;
REAsimulated.valveUPactionTemp=Automate.valveUPaction;
REAsimulated.ivalveDOWNactionTemp = find(0==Automate.valveDOWNaction);
REAsimulated.ivalveUPactionTemp = find(0==Automate.valveUPaction);
REAsimulated.valveDOWNactionTemp(REAsimulated.ivalveDOWNactionTemp) = NaN;
REAsimulated.valveUPactionTemp(REAsimulated.ivalveUPactionTemp) = NaN;

REAsimulated.oxygenUPTemp = Firesting.UP.oxygenInterp;
REAsimulated.oxygenDOWNTemp = Firesting.DOWN.oxygenInterp;

REAsimulated.oxygenUPTemp(1:Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY) = []; 
REAsimulated.oxygenUPTemp(end-(Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY)-1:end) = [];
REAsimulated.oxygenDOWNTemp(1:Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY) = [];
REAsimulated.oxygenDOWNTemp(end-(Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY)-1:end) = [];

REAsimulated.valveDOWNactionTemp(1:Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY) = []; 
REAsimulated.valveDOWNactionTemp(end-(Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY)-1:end) = [];
REAsimulated.valveUPactionTemp(1:Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY) = [];
REAsimulated.valveUPactionTemp(end-(Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY)-1:end) = [];

REAsimulated.valveDOWNactionCum = cumsum(REAsimulated.valveDOWNactionTemp,'omitnan');
REAsimulated.valveDOWNactionCumTotal = max(REAsimulated.valveDOWNactionCum);
REAsimulated.valveUPactionCum = cumsum(REAsimulated.valveUPactionTemp,'omitnan');
REAsimulated.valveUPactionCumTotal = max(REAsimulated.valveUPactionCum);

if iDeployment >= 12 %!!!
ECsegt.velocityZPrimeTemp = ECsegt.velocityZPrime(1:end-2);
REAsimulated.VelocityZPrimeValveDownAction = ECsegt.velocityZPrimeTemp.*REAsimulated.valveDOWNactionTemp;
REAsimulated.VelocityZPrimeValveUpAction = ECsegt.velocityZPrimeTemp.*REAsimulated.valveUPactionTemp;
else
REAsimulated.VelocityZPrimeValveDownAction = ECsegt.velocityZPrime.*REAsimulated.valveDOWNactionTemp;
REAsimulated.VelocityZPrimeValveUpAction = ECsegt.velocityZPrime.*REAsimulated.valveUPactionTemp;    
end


REAsimulated.VelocityZPrimeValveUpActionSimulated = REAsimulated.VelocityZPrimeValveUpAction;
REAsimulated.VelocityZPrimeValveDownActionSimulated = REAsimulated.VelocityZPrimeValveDownAction;

REAsimulated.valveUPactionTempSimulated = REAsimulated.valveUPactionTemp;
REAsimulated.valveDOWNactionTempSimulated = REAsimulated.valveDOWNactionTemp;

REAsimulated.valveUPactionTempSimulatedDesirable = ones(length(REAsimulated.valveUPactionTemp));
REAsimulated.valveUPactionTempSimulatedDesirable = REAsimulated.valveUPactionTempSimulatedDesirable(:,1);
REAsimulated.valveDOWNactionTempSimulatedDesirable = ones(length(REAsimulated.valveDOWNactionTemp));
REAsimulated.valveDOWNactionTempSimulatedDesirable = REAsimulated.valveDOWNactionTempSimulatedDesirable(:,1);


for i = 1:length(REAsimulated.VelocityZPrimeValveUpAction)
   if REAsimulated.VelocityZPrimeValveUpAction(i) <= Automate.velocityZThreshold
      REAsimulated.VelocityZPrimeValveUpActionSimulated(i) = NaN;
      REAsimulated.valveUPactionTempSimulated(i) = NaN;
      
   end
   if REAsimulated.VelocityZPrimeValveDownAction(i) >= -(Automate.velocityZThreshold)
      REAsimulated.VelocityZPrimeValveDownActionSimulated(i) = NaN;
      REAsimulated.valveDOWNactionTempSimulated(i) = NaN;
      
   end
end

REAsimulated.iValveUPpoorSampling = find(REAsimulated.VelocityZPrimeValveUpAction<=Automate.velocityZThreshold & REAsimulated.VelocityZPrimeValveUpAction>=0);
REAsimulated.iValveUPBadSampling = find(REAsimulated.VelocityZPrimeValveUpAction<0);

REAsimulated.iValveDOWNpoorSampling = find(REAsimulated.VelocityZPrimeValveDownAction>=-(Automate.velocityZThreshold)& REAsimulated.VelocityZPrimeValveDownAction<=0);
REAsimulated.iValveDOWNBadSampling = find(REAsimulated.VelocityZPrimeValveDownAction>0);

REAsimulated.oxygenUPPoorSampling = REAsimulated.oxygenUPTemp(REAsimulated.iValveUPpoorSampling);
REAsimulated.oxygenUPBadSampling = REAsimulated.oxygenUPTemp(REAsimulated.iValveUPBadSampling);

REAsimulated.oxygenDOWNPoorSampling = REAsimulated.oxygenDOWNTemp(REAsimulated.iValveDOWNpoorSampling);
REAsimulated.oxygenDOWNBadSampling = REAsimulated.oxygenDOWNTemp(REAsimulated.iValveDOWNBadSampling);

%REAsimulated.ValveUPpoorSampling = (length(REAsimulated.iValveUPpoorSampling)/max(cumsum(REAsimulated.valveUPactionTemp,'omitnan')))*100;
%REAsimulated.ValveDOWNpoorSampling = (length(REAsimulated.iValveDOWNpoorSampling)/max(cumsum(REAsimulated.valveDOWNactionTemp,'omitnan')))*100;
REAsimulated.ValveUPpoorSampling = (length(REAsimulated.iValveUPpoorSampling)/length(REAsimulated.valveUPactionCum))*100;
REAsimulated.ValveUPBadSampling = (length(REAsimulated.iValveUPBadSampling)/length(REAsimulated.valveUPactionCum))*100;

REAsimulated.ValveDOWNpoorSampling = (length(REAsimulated.iValveDOWNpoorSampling)/length(REAsimulated.valveDOWNactionCum))*100;
REAsimulated.ValveDOWNBadSampling = (length(REAsimulated.iValveDOWNBadSampling)/length(REAsimulated.valveDOWNactionCum))*100;


Xo2X = [0 max(REAsimulated.iValveUPpoorSampling)];
Yo2 = [(REA.valveUPactionOxygenMean) (REA.valveUPactionOxygenMean)];
Zo2 = [mean(REAsimulated.oxygenUPPoorSampling) mean(REAsimulated.oxygenUPPoorSampling)];
Wo2 = [mean(REAsimulated.oxygenUPBadSampling) mean(REAsimulated.oxygenUPBadSampling)];
figure;subplot(2,1,1)
plot(REAsimulated.iValveUPpoorSampling,REAsimulated.oxygenUPPoorSampling,'yo');hold on
plot(REAsimulated.iValveUPBadSampling,REAsimulated.oxygenUPBadSampling,'ro');
line(Xo2X,Yo2,'Color','g')
line(Xo2X,Zo2,'Color','y')
line(Xo2X,Wo2,'Color','r')
tf = isempty(REAsimulated.iValveUPBadSampling);
if tf == 0
legend('poor sampling','bad sampling','Mean C UP', 'Mean poor C UP','Mean bad C UP','location','southoutside','Orientation','horizontal')
else
legend('poor sampling','Mean C UP', 'Mean poor C UP','location','southoutside','Orientation','horizontal')
end
legend('boxoff')
xlabel('Time (1/8 s)')
ylabel('Oxygen concentration (mmol.m^-^3)')
title('Poor and bad sampling UP over segment duration')

Xo2X = [0 max(REAsimulated.iValveDOWNpoorSampling)];
Yo2 = [(REA.valveDOWNactionOxygenMean) (REA.valveDOWNactionOxygenMean)];
Zo2 = [mean(REAsimulated.oxygenDOWNPoorSampling) mean(REAsimulated.oxygenDOWNPoorSampling)];
Wo2 = [mean(REAsimulated.oxygenDOWNBadSampling) mean(REAsimulated.oxygenDOWNBadSampling)];
subplot(2,1,2)
plot(REAsimulated.iValveDOWNpoorSampling,REAsimulated.oxygenDOWNPoorSampling,'yo'); hold on
plot(REAsimulated.iValveDOWNBadSampling,REAsimulated.oxygenDOWNBadSampling,'ro');
line(Xo2X,Yo2,'Color','g')
line(Xo2X,Zo2,'Color','y')
line(Xo2X,Wo2,'Color','r')
tf = isempty(REAsimulated.iValveDOWNBadSampling);
if tf == 0
legend('poor sampling','bad sampling','Mean C DOWN', 'Mean poor C DOWN','Mean bad C DOWN','location','southoutside','Orientation','horizontal')
else
legend('poor sampling','Mean C DOWN', 'Mean poor C DOWN','location','southoutside','Orientation','horizontal')
end
legend('boxoff')
xlabel('Time (1/8 s)')
ylabel('Oxygen concentration (mmol.m^-^3)')
title('Poor and bad sampling DOWN over segment duration')

REAsimulated.ValveUPpoorSamplingTemp = 1:length(REAsimulated.iValveUPpoorSampling);
REAsimulated.ValveDOWNpoorSamplingTemp = 1:length(REAsimulated.iValveDOWNpoorSampling);

REAsimulated.ValveUPpoorSamplingOvertime = ((REAsimulated.ValveUPpoorSamplingTemp)/length(REAsimulated.valveUPactionCum))*100;
REAsimulated.ValveDOWNpoorSamplingOvertime = ((REAsimulated.ValveDOWNpoorSamplingTemp)/length(REAsimulated.valveDOWNactionCum))*100;

figure;plot(REAsimulated.iValveUPpoorSampling,REAsimulated.ValveUPpoorSamplingOvertime);hold on
plot(REAsimulated.iValveDOWNpoorSampling,REAsimulated.ValveDOWNpoorSamplingOvertime)
legend('UP','DOWN')
legend('boxoff')
xlabel('Time (1/8 s)')
ylabel('Poor sampling (%)')
title('Poor sampling over segment duration')



for i = 1:length(ECsegt.velocityZPrime)
    if ECsegt.velocityZPrime(i) <= Automate.velocityZThreshold
    REAsimulated.valveUPactionTempSimulatedDesirable(i) = NaN;
    end
    
    if ECsegt.velocityZPrime(i) >= -(Automate.velocityZThreshold)
    REAsimulated.valveDOWNactionTempSimulatedDesirable(i) = NaN;
    end
end


%REAsimulated.valveUPactionTempSimulatedDesirable(end-1:end) = [];
%REAsimulated.valveDOWNactionTempSimulatedDesirable(end-1:end) = [];

REAsimulated.valveDOWNactionCumSimulated = cumsum(REAsimulated.valveDOWNactionTempSimulated,'omitnan');
REAsimulated.valveDOWNactionCumTotalSimulated = max(REAsimulated.valveDOWNactionCumSimulated);
REAsimulated.valveUPactionCumSimulated = cumsum(REAsimulated.valveUPactionTempSimulated,'omitnan');
REAsimulated.valveUPactionCumTotalSimulated = max(REAsimulated.valveUPactionCumSimulated);

REAsimulated.valveDOWNactionCumSimulatedDesirable = cumsum(REAsimulated.valveDOWNactionTempSimulatedDesirable,'omitnan');
REAsimulated.valveDOWNactionCumTotalSimulatedDesirable = max(REAsimulated.valveDOWNactionCumSimulatedDesirable);
REAsimulated.valveUPactionCumSimulatedDesirable = cumsum(REAsimulated.valveUPactionTempSimulatedDesirable,'omitnan');
REAsimulated.valveUPactionCumTotalSimulatedDesirable = max(REAsimulated.valveUPactionCumSimulatedDesirable);


REAsimulated.valveDOWNactionSampling = (REAsimulated.valveDOWNactionCumTotal/length(REAsimulated.valveDOWNactionCum))*100;
REAsimulated.valveUPactionSampling = (REAsimulated.valveUPactionCumTotal/length(REAsimulated.valveUPactionCum))*100;

REAsimulated.valveDOWNactionSamplingSimulated = (REAsimulated.valveDOWNactionCumTotalSimulated/length(REAsimulated.valveDOWNactionCumSimulated))*100;
REAsimulated.valveUPactionSamplingSimulated = (REAsimulated.valveUPactionCumTotalSimulated/length(REAsimulated.valveUPactionCumSimulated))*100;

REAsimulated.valveDOWNactionSamplingSimulatedDesirable = (REAsimulated.valveDOWNactionCumTotalSimulatedDesirable/length(REAsimulated.valveDOWNactionCumSimulatedDesirable))*100;
REAsimulated.valveUPactionSamplingSimulatedDesirable = (REAsimulated.valveUPactionCumTotalSimulatedDesirable/length(REAsimulated.valveUPactionCumSimulatedDesirable))*100;

REAsimulated.VelocityZPrimeValveDownActionSimulatedDesirable = ECsegt.velocityZPrimeTemp.*REAsimulated.valveDOWNactionTempSimulatedDesirable(1:length(ECsegt.velocityZPrimeTemp));
REAsimulated.VelocityZPrimeValveUpActionSimulatedDesirable = ECsegt.velocityZPrimeTemp.*REAsimulated.valveUPactionTempSimulatedDesirable(1:length(ECsegt.velocityZPrimeTemp));

%figure;
figure;
%t = tiledlayout(2,1);
%ax1 = nexttile;
subplot(3,1,1)
plot(ECsegt.velocityZPrime);hold on%!!! Make plot as for uptake O2
plot(REAsimulated.VelocityZPrimeValveDownAction,'r.')
plot(REAsimulated.VelocityZPrimeValveUpAction,'k.')
line(XcorX,Ycor,'Color','g')
line(XcorX,Zcor,'Color','g')
title('Valves action over the fluctuation of vertical velocity aligned using angles by the end segment ', ['Total sampling - Up: ', num2str(REAsimulated.valveUPactionSampling),' % Down: ', num2str(REAsimulated.valveDOWNactionSampling),' % ; Poor sampling - Up: ',num2str(REAsimulated.ValveUPpoorSampling),' % , Down: ',num2str(REAsimulated.ValveDOWNpoorSampling),'% ; Bad sampling - Up:',num2str(REAsimulated.ValveUPBadSampling),' % , Down:',num2str(REAsimulated.ValveDOWNBadSampling),' %' ])
legend('Velocity Z', 'Valve Down', 'Valve Up', 'Threshold velocity','location','northeast','Orientation','horizontal')
legend('boxoff')
xlabel('Time (1/8 s)')
ylabel('Fluctuation of w aligned (m.s^-^1)')

%ax2 = nexttile;
subplot(3,1,2)
plot(ECsegt.velocityZPrime)
hold on
plot(REAsimulated.VelocityZPrimeValveDownActionSimulated,'r.')
plot(REAsimulated.VelocityZPrimeValveUpActionSimulated,'k.')
line(XcorX,Ycor,'Color','g')
line(XcorX,Zcor,'Color','g')
xlabel('Time (1/8 s)')
ylabel('Fluctuation of w aligned (m.s^-^1)')
title('Real valve action above w_0', ['Up: ', num2str(REAsimulated.valveUPactionSamplingSimulated),' % Down: ', num2str(REAsimulated.valveDOWNactionSamplingSimulated),' %'])

subplot(3,1,3)
plot(ECsegt.velocityZPrime)
hold on
plot(REAsimulated.VelocityZPrimeValveDownActionSimulatedDesirable,'r.')
plot(REAsimulated.VelocityZPrimeValveUpActionSimulatedDesirable,'k.')
line(XcorX,Ycor,'Color','g')
line(XcorX,Zcor,'Color','g')
xlabel('Time (1/8 s)')
ylabel('Fluctuation of w aligned (m.s^-^1)')
title('Desirable valve action above w_0', ['Up: ', num2str(REAsimulated.valveUPactionSamplingSimulatedDesirable),' % Down: ', num2str(REAsimulated.valveDOWNactionSamplingSimulatedDesirable),' %'])


%title(t,'Valve action over the fluctuation of the aligned vertical speed of the corresponding segment ',[' Total sampling',num2str(REAEC.ECfluxNoDelay),' mmol.m^{-2}.day^{-1} - REA: ',num2str(REAEC.REAfluxNoDelay),' mmol.m^{-2}.day^{-1}  -  R^{2}: ',num2str(REAECAnalysis.Rsquared.Ordinary),' - RMSE: ',num2str(REAEC.RMSE)])


REAsimulated.DOWNoxygenInterp = Firesting.DOWN.oxygenInterp;
REAsimulated.DOWNoxygenInterp(1:Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY) = [];
REAsimulated.DOWNoxygenInterp(end-(Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY)-1:end) = [];
REAsimulated.UPoxygenInterp = Firesting.UP.oxygenInterp;
REAsimulated.UPoxygenInterp(1:Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY) = [];
REAsimulated.UPoxygenInterp(end-(Param.RUNNINGAVERAGEMIN*30*Param.ADVSAMPLINGFREQUENCY)-1:end) = [];

REAsimulated.OxygenValveDownActionSimulated = REAsimulated.DOWNoxygenInterp.*REAsimulated.valveDOWNactionTempSimulated;
REAsimulated.OxygenValveUpActionSimulated = REAsimulated.UPoxygenInterp.*REAsimulated.valveUPactionTempSimulated;

j=1;
for i = 30*8:length(REAsimulated.OxygenValveDownActionSimulated)
REAsimulated.OxygenValveUpActionSimulatedOvertime(j,1)= nanmean(REAsimulated.OxygenValveUpActionSimulated(1:i,1));
REAsimulated.OxygenValveDownActionSimulatedOvertime(j,1)= nanmean(REAsimulated.OxygenValveDownActionSimulated(1:i,1));
REAsimulated.oxyFluxSimulatedOvertime(j) = REA.bCoefFit*REA.stdVelocityZAligned*(REA.valveUPactionOxygenTempOvertime(j)- REA.valveDOWNactionOxygenTempOvertime(j)-Compensation.concDiff)*24*3600;
REAsimulated.concDiffOvertime(j)=(REA.valveUPactionOxygenTempOvertime(j)- REA.valveDOWNactionOxygenTempOvertime(j)-Compensation.concDiff);
j = j+1;
end

figure;plot(REAsimulated.DOWNoxygenInterp)
hold on
plot(REAsimulated.UPoxygenInterp)
plot(REAsimulated.OxygenValveDownActionSimulated,'ko')
plot(REAsimulated.OxygenValveUpActionSimulated,'ko')

REAsimulated.OxygenValveDownActionSimulatedMEAN = nanmean(REAsimulated.OxygenValveDownActionSimulated);
REAsimulated.OxygenValveUpActionSimulatedMEAN = nanmean(REAsimulated.OxygenValveUpActionSimulated);

REAsimulated.oxygenFlux = REA.bCoefFit*REA.stdVelocityZAligned*((REAsimulated.OxygenValveUpActionSimulatedMEAN - REAsimulated.OxygenValveDownActionSimulatedMEAN) - Compensation.concDiff)*3600*24;
%% Plot REA and EC flux
REA.O2uptake = REA.Test(:,3)*REA.bCoefFit*REA.stdVelocityZAligned;
EC.despiking.O2uptake = EC.despiking.fluxECcumTemp.*EC.despiking.time;
REAsimulated.time = 0:1/8:(length(REAsimulated.concDiffOvertime)/8);
REAsimulated.time(end) = [];
REAsimulated.concDiffOvertime(2,:) = REAsimulated.concDiffOvertime.*REAsimulated.time;
REAsimulated.concDiffOvertime(3,:) = REAsimulated.concDiffOvertime(2,:)*REA.bCoefFit*REA.stdVelocityZAligned;
% figure;plot(REA.O2uptake);hold on
% plot(EC.despiking.O2uptake)
% legend('REA', 'EC')
% legend('boxoff')
%  xlabel('Time (1/8 s)')
%  ylabel('Oxygen uptake (mmol.m^-^2)')
% 
% figure;plot(REA.O2uptake(1:length(EC.despiking.O2uptake)), EC.despiking.O2uptake)
% ylabel('EC Oxygen uptake (mmol.m^-^2)')
% xlabel('REA Oxygen uptake (mmol.m^-^2)')
REAECAnalysis = fitlm(REA.O2uptake(1:length(EC.despiking.O2uptake)), EC.despiking.O2uptake);
REAEC.commonDelay = (REA.O2uptake(1:length(EC.despiking.O2uptake))-EC.despiking.O2uptake);
REAEC.differencesize = (length(REA.O2uptake)-length(EC.despiking.O2uptake))/2;
REAEC.REAO2uptakeDurationAdpated4EC = REA.O2uptake(REAEC.differencesize:end-REAEC.differencesize);
REAEC.REAO2uptakeDurationAdpated4EC(end) = [];
%REAEC.commonDelay = REA.O2uptake(1:length(EC.despiking.O2uptake))-EC.despiking.O2uptake;
REAEC.commonDelay = REAEC.REAO2uptakeDurationAdpated4EC-EC.despiking.O2uptake;

% Spliting the segment to search the minimun difference allover the segment
REAEC.iSplited = ceil(length(REAEC.commonDelay)/5);
REAEC.iEnd1 = knnsearch(abs(REAEC.commonDelay(REAEC.iSplited:2*REAEC.iSplited)),0);
REAEC.iEnd1 = REAEC.iEnd1+REAEC.iSplited;

REAEC.iEnd2 = knnsearch(abs(REAEC.commonDelay(2*REAEC.iSplited:3*REAEC.iSplited)),0);
REAEC.iEnd2 = REAEC.iEnd2+2*REAEC.iSplited;

REAEC.iEnd3 = knnsearch(abs(REAEC.commonDelay(3*REAEC.iSplited:4*REAEC.iSplited)),0);
REAEC.iEnd3 = REAEC.iEnd3+3*REAEC.iSplited;

REAEC.iEnd4 = knnsearch(abs(REAEC.commonDelay(4*REAEC.iSplited:end)),0);
REAEC.iEnd4 = REAEC.iEnd4+4*REAEC.iSplited;

REAEC.iEndAll = [REAEC.iEnd1 REAEC.iEnd2 REAEC.iEnd3 REAEC.iEnd4]';
REAEC.iEndAll(:,2) = [REAEC.commonDelay(REAEC.iEnd1) REAEC.commonDelay(REAEC.iEnd2) REAEC.commonDelay(REAEC.iEnd3) REAEC.commonDelay(REAEC.iEnd4)];

REAEC.iEndValue = knnsearch(REAEC.iEndAll(:,2),0);
REAEC.iEnd = REAEC.iEndAll(REAEC.iEndValue,1);

REAEC.RMSE = sqrt(mean(EC.despiking.O2uptake-REAEC.REAO2uptakeDurationAdpated4EC));

REAEC.REAfluxNoDelay = (REA.O2uptake(end)/REA.time(end))*3600*24;

REAEC.ECfluxNoDelay = (EC.despiking.O2uptake(end)/EC.despiking.time(end))*3600*24;

%is.Rsquared.Ordinary),'RMSE:',num2str(REAECAnalysis.RMSE))
figure;
t = tiledlayout(2,1);
ax1 = nexttile;
plot(REAEC.REAO2uptakeDurationAdpated4EC);hold on
%plot(REAsimulated.concDiffOvertime(3,:))
plot(EC.despiking.O2uptake)
%plot(REAEC.iEnd,EC.despiking.O2uptake(REAEC.iEnd),'ko')
legend('REA', 'EC')
legend('boxoff')
 xlabel('Time (1/8 s)')
 ylabel('Oxygen uptake (mmol.m^-^2)')

 ax2 = nexttile;
plot(REAEC.REAO2uptakeDurationAdpated4EC, EC.despiking.O2uptake,'.'); hold on
%plot(REAECAnalysis);hold on
ylabel('EC Oxygen uptake (mmol/m2)')
xlabel('REA Oxygen uptake (mmol/m2)')
%title('R^{2}:',num2str(REAECAnalys
title(t,'Cumulative oxygen flux:',[' EC: ',num2str(REAEC.ECfluxNoDelay),' mmol.m^{-2}.day^{-1} - REA: ',num2str(REAEC.REAfluxNoDelay),' mmol.m^{-2}.day^{-1}  -  R^{2}: ',num2str(REAECAnalysis.Rsquared.Ordinary),' - RMSE: ',num2str(REAEC.RMSE)])

REAEC.REAflux = (REA.O2uptake(REAEC.iEnd)/REA.time(REAEC.iEnd))*3600*24;

REAEC.ECflux = (EC.despiking.O2uptake(REAEC.iEnd)/EC.despiking.time(REAEC.iEnd))*3600*24;
REAEC.SegmentDuration = REAEC.iEnd/Param.ADVSAMPLINGFREQUENCY;

REAEC.RMSE2 = sqrt(mean(EC.despiking.O2uptake(1:REAEC.iEnd)-REA.O2uptake(1:REAEC.iEnd)));

REAECAnalysis = fitlm(REA.O2uptake(1:REAEC.iEnd), EC.despiking.O2uptake(1:REAEC.iEnd));
figure;
t = tiledlayout(2,1);
ax1 = nexttile;
plot(REAEC.REAO2uptakeDurationAdpated4EC);hold on
%plot(REAsimulated.concDiffOvertime(3,:))
plot(EC.despiking.O2uptake)
plot(REAEC.iEnd,EC.despiking.O2uptake(REAEC.iEnd),'ko')
%plot(REAEC.iEnd,REA.O2uptake(REAEC.iEnd),'ko')
legend('REA', 'EC', 'Selected Delay')
legend('boxoff')
 xlabel('Time (1/8 s)')
 ylabel('Oxygen uptake (mmol.m^-^2)')

 ax2 = nexttile;
plot(REA.O2uptake(1:REAEC.iEnd), EC.despiking.O2uptake(1:REAEC.iEnd),'.'); hold on
%plot(REAECAnalysis);hold on
ylabel('EC Oxygen uptake (mmol/m2)')
xlabel('REA Oxygen uptake (mmol/m2)')
%title('R^{2}:',num2str(REAECAnalysis.Rsquared.Ordinary),'RMSE:',num2str(REAECAnalysis.RMSE))

title(t,'Cumulative oxygen flux:',[' EC: ',num2str(REAEC.ECflux),' mmol.m^{-2}.day^{-1} - REA: ',num2str(REAEC.REAflux),' mmol.m^{-2}.day^{-1}  -  R^{2}: ',num2str(REAECAnalysis.Rsquared.Ordinary),' - RMSE: ',num2str(REAEC.RMSE2),' Segt duration: ',num2str(REAEC.SegmentDuration),' s'])

%% EC and REA fluxes reducing the t0 of the segments duration
%t0 was always 0 the main idea here is to change t0 until delta t = 2 minutes and check the effect on
%the fluxes values

t0analysis.REA.valveDOWNactionOxygenTemp = REA.valveDOWNactionOxygenTemp;
t0analysis.REA.valveUPactionOxygenTemp = REA.valveUPactionOxygenTemp;
t0analysis.EC.oxygenFirestingInterpDespiked = EC.despiking.oxygenFirestingInterpDespiked; 
t0analysis.EC.timeInterpDespiked = EC.despiking.timeInterpDespiked;
t0analysis.EC.velocityZDespiked = EC.despiking.velocityZDespiked;
j = 1;

t0analysis.REA.valveDOWNactionOxygenTemp = [1:(length(Automate.valveDOWNaction))-120*Param.ADVSAMPLINGFREQUENCY];
t0analysis.REA.valveUPactionOxygenTemp = (1:(length(Automate.valveUPaction))-120*Param.ADVSAMPLINGFREQUENCY)';
t0analysis.REA.ivalveDOWNactionOxygenTemp = 1:(length(Automate.valveDOWNaction))-120*Param.ADVSAMPLINGFREQUENCY;
t0analysis.REA.ivalveUPactionOxygenTemp = 1:(length(Automate.valveUPaction))-120*Param.ADVSAMPLINGFREQUENCY;
t0analysis.REA.valveDOWNactionOxygenTempmean = 1:(length(Automate.valveDOWNaction))-120*Param.ADVSAMPLINGFREQUENCY;
t0analysis.REA.valveUPactionOxygenTempmean = 1:(length(Automate.valveUPaction))-120*Param.ADVSAMPLINGFREQUENCY;


for i = 1:(length(Automate.valveDOWNaction))-120*Param.ADVSAMPLINGFREQUENCY

t0analysis.EC.timeInterpDespiked(1:i) = [];
t0analysis.EC.velocityZDespiked(1:i) = [];
t0analysis.EC.oxygenFirestingInterpDespiked(1:i) = []; 

[~, t0analysis.EC.velocityZPrime_TimeShift, ~, t0analysis.EC.ecFluxOxygen_TimeShift(i), t0analysis.EC.ecFluxOxygen_NoTimeShift(i), ~, ~, ~, t0analysis.EC.bestpValue(i), ~] ...
= segment_time_shift_EC( Param,t0analysis.EC.timeInterpDespiked, t0analysis.EC.velocityZDespiked, t0analysis.EC.oxygenFirestingInterpDespiked, 0);%this synchronazation use the velocity alligned collected by the automation NO FLUCTUATION EXTRACTION
   %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro_EC'])

t0analysis.REA.iStart = (length(Automate.valveDOWNaction) - length(t0analysis.EC.velocityZPrime_TimeShift))/2;
% new aspect addapted to the REA flux which the it has the same duration as
% the EC. REA = REA - EC(running average + shift)
%t0analysis.REA.valveDOWNactionOxygenTemp = Automate.valveDOWNaction(fix(t0analysis.REA.iStart):end-fix(t0analysis.REA.iStart)-1).*Firesting.DOWN.oxygenInterp(fix(t0analysis.REA.iStart):end-fix(t0analysis.REA.iStart)-1);
%t0analysis.REA.valveUPactionOxygenTemp = Automate.valveUPaction(fix(t0analysis.REA.iStart):end-fix(t0analysis.REA.iStart)-1).*Firesting.UP.oxygenInterp(fix(t0analysis.REA.iStart):end-fix(t0analysis.REA.iStart)-1);
t0analysis.REA.valveDOWNactionOxygenTemp = Automate.valveDOWNaction(i:end).*Firesting.DOWN.oxygenInterp(i:end);
t0analysis.REA.valveUPactionOxygenTemp = Automate.valveUPaction(i:end).*Firesting.UP.oxygenInterp(i:end);

t0analysis.REA.ivalveDOWNactionOxygenTemp = find(0==t0analysis.REA.valveDOWNactionOxygenTemp);
t0analysis.REA.ivalveUPactionOxygenTemp = find(0==t0analysis.REA.valveUPactionOxygenTemp);
t0analysis.REA.valveDOWNactionOxygenTemp(t0analysis.REA.ivalveDOWNactionOxygenTemp) = NaN;
t0analysis.REA.valveUPactionOxygenTemp(t0analysis.REA.ivalveUPactionOxygenTemp) = NaN;

t0analysis.REA.valveDOWNactionOxygenTempmean(i)= mean(t0analysis.REA.valveDOWNactionOxygenTemp,'omitnan');
t0analysis.REA.valveUPactionOxygenTempmean(i)= mean(t0analysis.REA.valveUPactionOxygenTemp,'omitnan');

t0analysis.EC.timeInterpDespiked = EC.despiking.timeInterpDespiked;
t0analysis.EC.velocityZDespiked = EC.despiking.velocityZDespiked;
t0analysis.EC.oxygenFirestingInterpDespiked = EC.despiking.oxygenFirestingInterpDespiked; 
j=j+1;
end
t0analysis.REA.oxygenflux = REA.bCoefFit*REA.stdVelocityZAligned*((t0analysis.REA.valveUPactionOxygenTempmean-t0analysis.REA.valveDOWNactionOxygenTempmean)- Compensation.concDiff)*24*3600;
t0analysis.IntersectionECREA = (t0analysis.REA.oxygenflux-t0analysis.EC.ecFluxOxygen_TimeShift)';
t0analysis.iIntersectionECREA = knnsearch(abs(t0analysis.IntersectionECREA(1:end-120*Param.ADVSAMPLINGFREQUENCY)),0);

figure;plot(t0analysis.REA.oxygenflux);hold on; plot(t0analysis.EC.ecFluxOxygen_TimeShift)
plot(t0analysis.iIntersectionECREA,t0analysis.REA.oxygenflux(t0analysis.iIntersectionECREA),'ko')
plot(t0analysis.iIntersectionECREA, t0analysis.EC.ecFluxOxygen_TimeShift(t0analysis.iIntersectionECREA),'ko')
legend('REA','EC','selected delay','location','southeast')
legend('boxoff')
xlabel('t_{0} (1/8 s)')
ylabel('Oxygen flux (mmol.m^-^2.day^-^1)')

%% Until here everything is working fine
t0analysis.REAvalveDOWNactionOxygenTemp = Automate.valveDOWNaction(t0analysis.iIntersectionECREA:end).*Firesting.DOWN.oxygenInterp(t0analysis.iIntersectionECREA:end);
t0analysis.REAvalveUPactionOxygenTemp = Automate.valveUPaction(t0analysis.iIntersectionECREA:end).*Firesting.UP.oxygenInterp(t0analysis.iIntersectionECREA:end);

t0analysis.REAivalveDOWNactionOxygenTemp = find(0==t0analysis.REAvalveDOWNactionOxygenTemp);
t0analysis.REAivalveUPactionOxygenTemp = find(0==t0analysis.REAvalveUPactionOxygenTemp);
t0analysis.REAvalveDOWNactionOxygenTemp(t0analysis.REAivalveDOWNactionOxygenTemp) = NaN;
t0analysis.REAvalveUPactionOxygenTemp(t0analysis.REAivalveUPactionOxygenTemp) = NaN;
%-- old version just bellow

t0analysis.REAvalveDOWNactionOxygenTempmean= mean(t0analysis.REAvalveDOWNactionOxygenTemp,'omitnan');
t0analysis.REAvalveUPactionOxygenTempmean= mean(t0analysis.REAvalveUPactionOxygenTemp,'omitnan');

t0analysis.ECtimeInterpDespiked=EC.despiking.timeInterpDespiked;
t0analysis.ECvelocityZDespiked=EC.despiking.velocityZDespiked;
t0analysis.ECoxygenFirestingInterpDespiked=EC.despiking.oxygenFirestingInterpDespiked;

t0analysis.ECtimeInterpDespiked(1:t0analysis.iIntersectionECREA) = [];
t0analysis.ECvelocityZDespiked(1:t0analysis.iIntersectionECREA) = [];
t0analysis.ECoxygenFirestingInterpDespiked(1:t0analysis.iIntersectionECREA) = []; 

[~, t0analysis.velocityZPrime,t0analysis.oxygenPrime, t0analysis.ECecFluxOxygen_TimeShift, t0analysis.ECecFluxOxygen_NoTimeShift, ~, ~, ~, t0analysis.ECbestpValue, ~] ...
= segment_time_shift_EC( Param,t0analysis.ECtimeInterpDespiked, t0analysis.ECvelocityZDespiked, t0analysis.ECoxygenFirestingInterpDespiked, 0);%this synchronazation use the velocity alligned collected by the automation NO FLUCTUATION EXTRACTION
   %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro_EC'])

for j = 1:length(t0analysis.velocityZPrime)
t0analysis.ECfluxcumTemp(j) = mean( t0analysis.velocityZPrime(1:j).*t0analysis.oxygenPrime(1:j));
end

t0analysis.ECtime = 0:1/8:(length(t0analysis.ECfluxcumTemp)/8);
t0analysis.ECtime(end) = [];
 
t0analysis.ECUptake = t0analysis.ECfluxcumTemp.*t0analysis.ECtime;

for k = 1:length(t0analysis.REAvalveUPactionOxygenTemp)
t0analysis.valveUPactionOxygenTempOvertime(k)= nanmean(t0analysis.REAvalveUPactionOxygenTemp(1:k));
t0analysis.valveDOWNactionOxygenTempOvertime(k)= nanmean(t0analysis.REAvalveDOWNactionOxygenTemp(1:k));
end

t0analysis.REAtime = 0:1/8:(length(t0analysis.valveDOWNactionOxygenTempOvertime)/8);
t0analysis.REAtime (end) = [];
t0analysis.REAtime  = t0analysis.REAtime';

t0analysis.Test = (t0analysis.valveUPactionOxygenTempOvertime-t0analysis.valveDOWNactionOxygenTempOvertime)';
t0analysis.Test(:,2) = t0analysis.Test-Compensation.concDiff;
t0analysis.Test(:,3) = t0analysis.Test(:,2).*t0analysis.REAtime;
 
t0analysis.REAO2Uptake = REA.bCoefFit*REA.stdVelocityZAligned*t0analysis.Test(:,3);



%% Garbage maybe useful, finally useful 

% [~,t0analysis.velocityZPrime, t0analysis.oxygenPrime, t0analysis.ecFluxOxygen_TimeShift, t0analysis.ecFluxOxygen_NoTimeShift, ~, ~, ~, t0analysis.EC.bestpValue, ~] ...
% = segment_time_shift_EC( Param,t0analysis.EC.timeInterpDespiked, t0analysis.EC.velocityZDespiked, t0analysis.EC.oxygenFirestingInterpDespiked, 0);%this synchronazation use the velocity alligned collected by the automation NO FLUCTUATION EXTRACTION
   %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro_EC'])
  
t0analysis.REAOxygenflux = t0analysis.REA.oxygenflux(t0analysis.iIntersectionECREA);
t0analysis.ECOxygenflux_shifted= t0analysis.EC.ecFluxOxygen_TimeShift(t0analysis.iIntersectionECREA);
t0analysis.SegmentDuration = length(t0analysis.ECUptake)/8;
t0analysis.REAO2Uptake(isnan(t0analysis.REAO2Uptake))=0;
t0analysis.RMSE = sqrt(mean(t0analysis.ECUptake-(t0analysis.REAO2Uptake(1:length(t0analysis.ECUptake))')));
t0analysis.ECrunningAverageSize = (length(t0analysis.REAO2Uptake) - length(t0analysis.ECUptake))/2;

REAECAnalysis = fitlm(t0analysis.REAO2Uptake(fix(t0analysis.ECrunningAverageSize):(length(t0analysis.ECUptake)+fix(t0analysis.ECrunningAverageSize)-1)), t0analysis.ECUptake);

TEST = t0analysis.REAO2Uptake(fix(t0analysis.ECrunningAverageSize):(length(t0analysis.ECUptake)+fix(t0analysis.ECrunningAverageSize)-1));

%  t0analysis.ECUptake2 = t0analysis.ECUptake';
%  t0analysis.ECrunningAverageSizeDelay = 1:length(t0analysis.REAO2Uptake);
%  t0analysis.ECrunningAverageSizeDelay(1:end)=NaN;
%  t0analysis.ECrunningAverageSizeDelay = t0analysis.ECrunningAverageSizeDelay';
%  %t0analysis.ECrunningAverageSizeDelay(:,2) = t0analysis.ECUptake2;
%  t0analysis.ECrunningAverageSizeDelay(fix(t0analysis.ECrunningAverageSize):(length(t0analysis.ECUptake2)+ceil(t0analysis.ECrunningAverageSize)),1) = t0analysis.ECUptake2;
% % need to find a solution for vector which do not fit in eachother.

%t0analysis.ECtimeAdapted = fix(t0analysis.ECrunningAverageSize):1/Param.ADVSAMPLINGFREQUENCY:length(t0analysis.ECUptake);

figure;
t = tiledlayout(2,1);
ax1 = nexttile;
plot(t0analysis.REAO2Uptake);hold on
%plot(REAsimulated.concDiffOvertime(3,:))
plot(t0analysis.ECUptake)
legend('REA', 'EC')
legend('boxoff')
 xlabel('Time (1/8 s)')
 ylabel('Oxygen uptake (mmol.m^-^2)')

 ax2 = nexttile;
plot(t0analysis.REAO2Uptake(1:length(t0analysis.ECUptake)), t0analysis.ECUptake,'.'); hold on
%plot(REAECAnalysis);hold on
ylabel('EC Oxygen uptake (mmol/m2)')
xlabel('REA Oxygen uptake (mmol/m2)')
%title('R^{2}:',num2str(REAECAnalysis.Rsquared.Ordinary),'RMSE:',num2str(REAECAnalysis.RMSE))

title(t,['Cumulative oxygen flux: EC: ',num2str(t0analysis.ECOxygenflux_shifted),' mmol.m^{-2}.day^{-1} - REA: ',num2str(t0analysis.REAOxygenflux),' mmol.m^{-2}.day^{-1}'],['R^{2}: ',num2str(REAECAnalysis.Rsquared.Ordinary),' - RMSE: ',num2str(t0analysis.RMSE),' Segt duration: ',num2str(t0analysis.SegmentDuration),' s'])

figure;plot(REA.TestEC(:,3));hold on
plot(REAEC.REAO2uptakeDurationAdpated4EC)
plot(EC.despiking.O2uptake)
legend('Simulated REA', 'REA', 'EC')
legend('boxoff')
xlabel('Time (1/8 s)')
ylabel('Oxygen uptake (mmol.m^-^2)')

% figure;
% plot(TEST-TEST(1));hold on
% %plot(REAsimulated.concDiffOvertime(3,:))
% plot(t0analysis.ECUptake)
% legend('REA', 'EC')
% legend('boxoff')
%  xlabel('Time (1/8 s)')
%  ylabel('Oxygen uptake (mmol.m^-^2)')

%% Window size test

windowsize.Duration = [120 180 240 300 360 420];




%% Finding the best segment duration
% !!!
% t0analysis.REAECDelay.ECREA = zeros(((length(Automate.valveDOWNaction))-120*Param.ADVSAMPLINGFREQUENCY),(length(t0analysis.EC.timeInterpDespiked)));
% 
% for i = 1:(length(Automate.valveDOWNaction))-120*Param.ADVSAMPLINGFREQUENCY
% 
% t0analysis.REA.valveDOWNactionOxygenTemp2 = Automate.valveDOWNaction.*Firesting.DOWN.oxygenInterp;
% t0analysis.REA.valveUPactionOxygenTemp2 = Automate.valveUPaction.*Firesting.UP.oxygenInterp;
% 
% t0analysis.REA.valveDOWNactionOxygenTemp2(1:i)=[];
% t0analysis.REA.valveUPactionOxygenTemp2(1:i)=[];
% 
% t0analysis.REA.ivalveDOWNactionOxygenTemp2 = find(0==t0analysis.REA.valveDOWNactionOxygenTemp2);
% t0analysis.REA.ivalveUPactionOxygenTemp2 = find(0==t0analysis.REA.valveUPactionOxygenTemp2);
% t0analysis.REA.valveDOWNactionOxygenTemp2(t0analysis.REA.ivalveDOWNactionOxygenTemp2) = NaN;
% t0analysis.REA.valveUPactionOxygenTemp2(t0analysis.REA.ivalveUPactionOxygenTemp2) = NaN;
% 
% for k = 1:length(t0analysis.REA.valveUPactionOxygenTemp2)
% t0analysis.REA.valveUPactionOxygenTempOvertime2(k) = nanmean(t0analysis.REA.valveUPactionOxygenTemp2(1:k));
% t0analysis.REA.valveDOWNactionOxygenTempOvertime2(k)= nanmean(t0analysis.REA.valveDOWNactionOxygenTemp2(1:k));
% end
% 
% t0analysis.REA.time = 0:1/8:(length(t0analysis.REA.valveDOWNactionOxygenTempOvertime2)/8);
% t0analysis.REA.time (end) = [];
% t0analysis.REA.time  = t0analysis.REA.time';
% 
% t0analysis.REA.Test = (t0analysis.REA.valveUPactionOxygenTempOvertime2-t0analysis.REA.valveDOWNactionOxygenTempOvertime2)';
% t0analysis.REA.Test(:,2) = t0analysis.REA.Test-Compensation.concDiff;
% t0analysis.REA.Test(:,3) = t0analysis.REA.Test(:,2).*t0analysis.REA.time;
%  
% t0analysis.REA.O2Uptake = REA.bCoefFit*REA.stdVelocityZAligned*t0analysis.REA.Test(:,3);
% 
% 
% %-- old version just bellow
% %t0analysis.REA.valveDOWNactionOxygenTempmean(i)= mean(t0analysis.REA.valveDOWNactionOxygenTemp,'omitnan');
% %t0analysis.REA.valveUPactionOxygenTempmean(i)= mean(t0analysis.REA.valveUPactionOxygenTemp,'omitnan');
% t0analysis.EC.timeInterpDespiked = EC.despiking.timeInterpDespiked;
% t0analysis.EC.velocityZDespiked = EC.despiking.velocityZDespiked;
% t0analysis.EC.oxygenFirestingInterpDespiked = EC.despiking.oxygenFirestingInterpDespiked; 
% 
% t0analysis.EC.timeInterpDespiked(1:i) = [];
% t0analysis.EC.velocityZDespiked(1:i) = [];
% t0analysis.EC.oxygenFirestingInterpDespiked(1:i) = []; 
% 
% [~, t0analysis.EC.velocityZPrime, t0analysis.EC.oxygenPrime, t0analysis.EC.ecFluxOxygen_TimeShift(i), t0analysis.EC.ecFluxOxygen_NoTimeShift(i), ~, ~, ~, t0analysis.EC.bestpValue(i), ~] ...
% = segment_time_shift_EC( Param,t0analysis.EC.timeInterpDespiked, t0analysis.EC.velocityZDespiked, t0analysis.EC.oxygenFirestingInterpDespiked, 0);%this synchronazation use the velocity alligned collected by the automation NO FLUCTUATION EXTRACTION
%    %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(Depl.iDeployment),'_seg',num2str(iSegment),'_','_synchro_EC'])
% 
% 
% for j = 1:length(t0analysis.EC.velocityZPrime)
% t0analysis.EC.fluxcumTemp(j) = mean( t0analysis.EC.velocityZPrime(1:j).*t0analysis.EC.oxygenPrime(1:j));
% end
% 
% t0analysis.EC.time = 0:1/8:(length(t0analysis.EC.fluxcumTemp)/8);
% t0analysis.EC.time(end) = [];
%  
% t0analysis.EC.Uptake = t0analysis.EC.fluxcumTemp.*t0analysis.EC.time;
% 
% t0analysis.REAECDelay.ECREA(:,i) = t0analysis.REA.O2Uptake(1:length(t0analysis.EC.Uptake)) - t0analysis.EC.Uptake;
% 
% end

% t0analysis.EC.timeInterpDespiked = EC.despiking.timeInterpDespiked;
% t0analysis.EC.velocityZDespiked = EC.despiking.velocityZDespiked;
% t0analysis.EC.oxygenFirestingInterpDespiked = EC.despiking.oxygenFirestingInterpDespiked;
% t0analysis.REA.valveDOWNactionOxygenTemp = REA.valveDOWNactionOxygenTemp;
% t0analysis.REA.valveUPactionOxygenTemp = REA.valveUPactionOxygenTemp;

%end
%% Compiling results and parameters
%CompiledResultsPos(d,:) = [Depl.iDeployment, str2num(Depl.date), str2num(Depl.hour), Automate.meanCourrent, Automate.meanCourrentModule, Angles.preAlpha(2), Angles.preBeta(2), Angles.overtimeAlpha(end), Angles.overtimeBeta(end), EC.bestpValue_AutomateDouble, EC.ecFluxOxygen_TimeShift_AutomateDouble, EC.despiking.bestpValue ,EC.despiking.ecFluxOxygen_TimeShift, ECsegt.bestpValueAutomateAligned, ECsegt.ecFluxOxygen_TimeShiftAutomateAligned, ECsegt.bestpValue, ECsegt.ecFluxOxygen_TimeShift, Automate.velocityZThreshold, REA.stdVelocityZ, REA.bCoefFit, REA.valveUPactionOxygenMean, REA.valveDOWNactionOxygenMean, Compensation.concDiff, REA.OxyFlux, REA.valveUPactionECOxygenMean, REA.valveDOWNactionECOxygenMean, REA.OxyFluxEC];
%CompiledREA(iDeployment,:) = [EC.reaFluxOxygen_AutomateDouble, EC.despiking.reaFluxOxygen, ECsegt.reaFluxOxygen, ECsegt.reaFluxOxygenAutomateAligned];


%Compiledresults =[iDeployment, EC.despiking.ecFluxOxygen_TimeShift,REA.OxyFlux,REA.OxyFluxEC,REAEC.ECflux, EC.despiking.bestpValue, REAEC.REAflux, REAEC.SegmentDuration, t0analysis.ECOxygenflux_shifted, t0analysis.ECbestpValue, t0analysis.REAOxygenflux, t0analysis.SegmentDuration];
%Compiledresults(d) =[iDeployment, EC.despiking.ecFluxOxygen_TimeShift,REA.OxyFlux,REA.bCoefFit,REA.bCoefEC, REA.stdVelocityZ, REA.oxyDifConcCompensated, Automate.velocityZThreshold];
%end
Angles.Compiled = [Angles.preAlpha(2), Angles.sgtAlpha(2), Angles.preBeta(2), Angles.sgtBeta(2)];
close all

%filename = 'C:\Users\g.calabro-souza\Documents\Doctorat\Planaqua campaign 2020\Results\20201109_CompiledDataPos_Check.xlsx';
%writematrix(CompiledResultsPos,filename,'Sheet',2,'Range','A1')

%filename = 'C:\Users\g.calabro-souza\Documents\Doctorat\Planaqua campaign 2020\Results\20201109_CompiledREAPos.xlsx';
%writematrix(CompiledREA,filename,'Sheet',2,'Range','A1')
