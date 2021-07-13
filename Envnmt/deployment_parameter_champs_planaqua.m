function Depl = deployment_parameter_champs_planaqua( iDeployment, Param )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Depl.segNFft = 2^nextpow2(Param.FLUXRANGE); %test copied from main5
Depl.iDeployment = iDeployment;
    switch Depl.iDeployment
        
        case 01111 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_1.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen1.txt'; 
            Depl.Segmentduration = 5*60-31; %seconds
            Depl.iOxyFirestingStart = 211; %12:17:32 %111Flux calculation starts at 12:17:02
            Depl.iOxyFirestingEnd = 1110; % Flux calculation ends at  12:22:01	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velFilePath = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_121631.csv';
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_121631.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 483;%12:17:32 %243 12:17:02
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 211;%12:17:32 %111 12:17:02 %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 483;% %when the fist valve action is made
            Depl.valveActionDuration = 5*60-31; %Valve action duration
            Depl.allOpenNeedleStart = 120;%delay to be discovered between the measurements
            Depl.allOpenUpStart = 120;
            Depl.allOpenDownStart = 120;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1216';
            
        case 0111 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_2.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen2.txt'; 
            Depl.Segmentduration = 5*60-4; %seconds
            Depl.iOxyFirestingStart = 119; %Flux calculation starts at 12:47:40
            Depl.iOxyFirestingEnd = 1108; % Flux calculation ends at  12:52:36	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_124707.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 263;%12:17:32 
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 119;%12:47:40 %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 263;%when the fist valve action is made
            Depl.valveActionDuration = 5*60-4; %Valve action duration
            Depl.allOpenNeedleStart = 30;%delay to be discovered between the measurements
            Depl.allOpenUpStart = 30;
            Depl.allOpenDownStart = 30;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1247';
            
        case 01 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_3.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen3.txt'; 
            Depl.Segmentduration = 4*60; %seconds
            Depl.iOxyFirestingStart = 232; %Flux calculation starts at 13:25:00
            Depl.iOxyFirestingEnd = 1034; % Flux calculation ends at  13:29:00	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_132354.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 529;%13:25:00 
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 232;%12:47:40 %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 529;%when the fist valve action is made
            Depl.valveActionDuration = 4*60; %Valve action duration
            Depl.allOpenNeedleStart = 30;%delay to be discovered between the measurements
            Depl.allOpenUpStart = 30;
            Depl.allOpenDownStart = 30;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1325';
          
        case 02 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_4.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen4.txt'; 
            Depl.Segmentduration = 5*60-5; %seconds
            Depl.iOxyFirestingStart = 122; %Flux calculation starts at 13:51:56
            Depl.iOxyFirestingEnd = 1108; %Flux calculation ends at  13:56:51	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_135122.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 246; %13:51:56
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 122; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 246; %when the fist valve action is made
            Depl.valveActionDuration = 5*60-5; %Valve action duration
            Depl.allOpenNeedleStart = 20; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 20;
            Depl.allOpenDownStart = 20;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1351';
            
        case 03 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_5.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen5.txt'; 
            Depl.Segmentduration = 10*60-38; %seconds
            Depl.iOxyFirestingStart = 132; %Flux calculation starts at 14:04:52
            Depl.iOxyFirestingEnd = 2007; %Flux calculation ends at  14:14:14	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_140415.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 293; %13:51:56
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 132; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 293; %when the fist valve action is made
            Depl.valveActionDuration = 10*60-38; %Valve action duration
            Depl.allOpenNeedleStart = 20; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 20;
            Depl.allOpenDownStart = 20;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1404';
            
        case 04 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_9.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen7.txt'; 
            Depl.Segmentduration = 8*60+32; %seconds
            Depl.iOxyFirestingStart = 399; %Flux calculation starts at 17:35:07
            Depl.iOxyFirestingEnd = 2108; %Flux calculation ends at  16:34:43	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_162414.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 933; %16:26:11
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 397; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 933; %when the fist valve action is made
            Depl.valveActionDuration = 8*60+32; %Valve action duration
            Depl.allOpenNeedleStart = 20; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 20;
            Depl.allOpenDownStart = 20;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1626';
            
        case 05 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_10.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen7.txt'; 
            Depl.Segmentduration = 5*60+2; %seconds
            Depl.iOxyFirestingStart = 300; %Flux calculation starts at 16:39:26	
            Depl.iOxyFirestingEnd = 1309; %Flux calculation ends at  16:44:28	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_163759.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 696; %16:39:26
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 300; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 696; %when the fist valve action is made
            Depl.valveActionDuration = 5*60+2; %Valve action duration
            Depl.allOpenNeedleStart = 20; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 20;
            Depl.allOpenDownStart = 20;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1639';

        case 06 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_11.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen7.txt'; 
            Depl.Segmentduration = 6*60-38; %seconds
            Depl.iOxyFirestingStart = 232; %Flux calculation starts at 16:48:45	
            Depl.iOxyFirestingEnd = 1308; %Flux calculation ends at  16:54:07	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_164738.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 534; %16:48:45
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 232; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 534; %when the fist valve action is made
            Depl.valveActionDuration = 6*60-38; %Valve action duration
            Depl.allOpenNeedleStart = 20; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 20;
            Depl.allOpenDownStart = 20;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1648';              
            
        case 07 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_12.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen7.txt'; 
            Depl.Segmentduration = 5*60+15; %seconds
            Depl.iOxyFirestingStart = 257; %Flux calculation starts at 16:57:59	
            Depl.iOxyFirestingEnd = 1309; %Flux calculation ends at  17:03:14	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_165644.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 594; %16:57:59
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 257; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 594; %when the fist valve action is made
            Depl.valveActionDuration = 5*60+15; %Valve action duration
            Depl.allOpenNeedleStart = 20; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 20;
            Depl.allOpenDownStart = 20;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1657';             
            
        case 08 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_13.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen12.txt'; 
            Depl.Segmentduration = 4*60+19; %seconds
            Depl.iOxyFirestingStart = 256; %Flux calculation starts at 17:12:42	
            Depl.iOxyFirestingEnd = 1122; %Flux calculation ends at  17:17:01	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_171131.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 562; %17:12:42
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 256; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 562; %when the fist valve action is made
            Depl.valveActionDuration = 4*60+19; %Valve action duration
            Depl.allOpenNeedleStart = 10; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 10;
            Depl.allOpenDownStart = 10;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1712';            
            
        case 09 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_14.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen12.txt'; 
            Depl.Segmentduration = 4*60+15; %seconds
            Depl.iOxyFirestingStart = 258; %Flux calculation starts at 17:20:30	
            Depl.iOxyFirestingEnd = 1110; %Flux calculation ends at  17:24:45	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_171916.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 586; %17:20:30
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 258; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 586; %when the fist valve action is made
            Depl.valveActionDuration = 4*60+15; %Valve action duration
            Depl.allOpenNeedleStart = 10; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 10;
            Depl.allOpenDownStart = 10;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1720';
            
        case 10 % 02/03/2020, P5
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_15.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen12.txt'; 
            Depl.Segmentduration = 3*60+32; %seconds
            Depl.iOxyFirestingStart = 400; %Flux calculation starts at 17:35:07	
            Depl.iOxyFirestingEnd = 1109; %Flux calculation ends at  17:38:39	
            Depl.sampfreqoxy = (Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/(Depl.Segmentduration);
            Depl.velocityfile = dlmread('C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_173310.csv',';',0,1);%XLS read before
            Depl.velocityfile = [ones(length(Depl.velocityfile),1),Depl.velocityfile];
            Depl.veldataStart = 937; %17:35:07
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 400; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 937; %when the fist valve action is made
            Depl.valveActionDuration = 3*60+32; %Valve action duration
            Depl.allOpenNeedleStart = 10; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 10;
            Depl.allOpenDownStart = 10;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1735';
            
        case 11 % 02/03/2020, P5 %!!!
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_chatou_16.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Firesting_data/20200302_allopen12.txt'; 
            Depl.dateStringSegtO2Start = {'17:42:00'};
            Depl.dateStringSegtO2End = {'17:46:16'};	
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Validation/Automation_data/15-03-03_174047.csv';%XLS read before
            Depl.veldataStart = 580; %16:26:11
            Depl.veldataEnd =  Depl.veldataStart + ((Depl.iOxyFirestingEnd - Depl.iOxyFirestingStart)/Depl.sampfreqoxy)*Param.ADVSAMPLINGFREQUENCY; 
            Depl.iTubeProbeStart = 252; %when the oxygen measurement in the tubes start it means 
            Depl.valveActionStart = 580; %when the fist valve action is made
            Depl.valveActionDuration = 4*60+16; %Valve action duration
            Depl.allOpenNeedleStart = 10; %delay to be discovered between the measurements
            Depl.allOpenUpStart = 10;
            Depl.allOpenDownStart = 10;
            Depl.filepathBottleUp = '';
            Depl.location = 'Chatou';
            Depl.date = '20200302_1742';
       
        case 12
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_segment1.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_allopen1.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-09_122252.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'12:23:22'};
            Depl.dateStringSegtO2End = {'12:32:49'};
            Depl.dateStringSegtAutoStart = {'09/07/2015 12:23:22'};
            Depl.dateStringSegtAutoEnd = {'09/07/2015 12:32:49'};
            Depl.dateStringCompStart = {'12:18:46'};
            Depl.dateStringCompEnd = {'12:20:16'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs-Canal-North';
            Depl.date = '202000708-S1';

        case 13
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_segment3.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_allopen3.txt'; 
            Depl.Segmentduration = 5*60+23; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-09_133741.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'13:38:11'};
            Depl.dateStringSegtO2End = {'13:43:34'};
            Depl.dateStringSegtAutoStart = {'09/07/2015 13:38:11'};
            Depl.dateStringSegtAutoEnd = {'09/07/2015 13:43:34'};
            Depl.dateStringCompStart = {'13:34:15'};
            Depl.dateStringCompEnd = {'13:35:54'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs-Canal-North';
            Depl.date = '202000708-S3';
            
        case 14
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_segment4.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_allopen4.txt'; 
            Depl.Segmentduration = 9*60+28; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-09_141053.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:11:23'};
            Depl.dateStringSegtO2End = {'14:20:51'};
            Depl.dateStringSegtAutoStart = {'09/07/2015 14:11:23'};
            Depl.dateStringSegtAutoEnd = {'09/07/2015 14:20:51'};
            Depl.dateStringCompStart = {'14:08:48'};
            Depl.dateStringCompEnd = {'14:10:17'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs-Canal-North';
            Depl.date = '202000708-S4';
            
        case 15
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_segment6.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_allopen6.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-09_170531.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:06:01'};
            Depl.dateStringSegtO2End = {'17:15:30'};
            Depl.dateStringSegtAutoStart = {'09/07/2015 17:06:01'};
            Depl.dateStringSegtAutoEnd = {'09/07/2015 17:15:30'};
            Depl.dateStringCompStart = {'17:02:11'};
            Depl.dateStringCompEnd = {'17:03:38'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs-Canal-North';
            Depl.date = '202000708-S6';
            
        case 16
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_segment7.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_allopen7.txt'; 
            Depl.Segmentduration = 9*60+28; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-09_173001.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:30:32'};
            Depl.dateStringSegtO2End = {'17:40:00'};
            Depl.dateStringSegtAutoStart = {'09/07/2015 17:30:32'};
            Depl.dateStringSegtAutoEnd = {'09/07/2015 17:40:00'};
            Depl.dateStringCompStart = {'17:27:50'};
            Depl.dateStringCompEnd = {'17:29:20'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs-Canal-North';
            Depl.date = '202000708-S7';

        case 17
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_segment8.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200708/Oxygen/20200708_allopen8.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-09_175248.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:53:18'};
            Depl.dateStringSegtO2End = {'18:02:47'};
            Depl.dateStringSegtAutoStart = {'09/07/2015 17:53:18'};
            Depl.dateStringSegtAutoEnd = {'09/07/2015 18:02:47'};
            Depl.dateStringCompStart = {'17:51:44'};
            Depl.dateStringCompEnd = {'17:52:15'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs-Canal-North';
            Depl.date = '202000708-S8';
            
        case 18
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200709/Oxygen/20200709-Segment1.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200709/Oxygen/20200709-Allopen1.txt'; 
            Depl.Segmentduration = 9*60+35; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-10_134150.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'13:42:13'};
            Depl.dateStringSegtO2End = {'13:51:48'};
            Depl.dateStringSegtAutoStart = {'10/07/2015 13:42:13'};
            Depl.dateStringSegtAutoEnd = {'10/07/2015 13:51:48'};
            Depl.dateStringCompStart = {'13:37:15'};
            Depl.dateStringCompEnd = {'13:37:43'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Courcelles';
            Depl.date = '202000709-S1';

        case 19
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200709/Oxygen/20200709-Segment4.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200709/Oxygen/20200709-Allopen4.txt'; 
            Depl.Segmentduration = 14*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-10_164747.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'16:48:17'};
            Depl.dateStringSegtO2End = {'17:02:46'};
            Depl.dateStringSegtAutoStart = {'10/07/2015 16:48:17'};
            Depl.dateStringSegtAutoEnd = {'10/07/2015 17:02:46'};
            Depl.dateStringCompStart = {'16:45:40'};
            Depl.dateStringCompEnd = {'16:46:40'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Courcelles';
            Depl.date = '202000709-S4';

        case 20
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200709/Oxygen/20200709-Segment5.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200709/Oxygen/20200709-Allopen5.txt'; 
            Depl.Segmentduration = 14*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-10_171653.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:17:23'};
            Depl.dateStringSegtO2End = {'17:31:52'};
            Depl.dateStringSegtAutoStart = {'10/07/2015 17:17:23'};
            Depl.dateStringSegtAutoEnd = {'10/07/2015 17:31:52'};
            Depl.dateStringCompStart = {'17:14:00'};
            Depl.dateStringCompEnd = {'17:15:00'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Courcelles';
            Depl.date = '202000709-S5';

        case 21
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200709/Oxygen/20200709-Segment6.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200709/Oxygen/20200709-Allopen6.txt'; 
            Depl.Segmentduration = 14*60+27; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-10_174935.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:50:07'};
            Depl.dateStringSegtO2End = {'18:04:34'};
            Depl.dateStringSegtAutoStart = {'10/07/2015 17:50:07'};
            Depl.dateStringSegtAutoEnd = {'10/07/2015 18:04:34'};
            Depl.dateStringCompStart = {'17:48:05'};
            Depl.dateStringCompEnd = {'17:49:05'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Courcelles';
            Depl.date = '202000709-S6';
            
       case 22
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200710/Oxygen/20200710-Segment1.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200710/Oxygen/20200710-Allopen1.txt'; 
            Depl.Segmentduration = 9*60+27; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-11_152646.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:27:17'};
            Depl.dateStringSegtO2End = {'15:36:44'};
            Depl.dateStringSegtAutoStart = {'11/07/2015 15:27:17'};
            Depl.dateStringSegtAutoEnd = {'11/07/2015 15:36:44'};
            Depl.dateStringCompStart = {'15:23:01'};
            Depl.dateStringCompEnd = {'15:24:17'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000710-S1';
            
       case 23
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200710/Oxygen/20200710-Segment2.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200710/Oxygen/20200710-Allopen2.txt'; 
            Depl.Segmentduration = 9*60+24; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-11_154812.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:48:44'};
            Depl.dateStringSegtO2End = {'15:58:08'};
            Depl.dateStringSegtAutoStart = {'11/07/2015 15:48:44'};
            Depl.dateStringSegtAutoEnd = {'11/07/2015 15:58:08'};
            Depl.dateStringCompStart = {'15:46:04'};
            Depl.dateStringCompEnd = {'15:46:19'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000710-S2';
            
       case 24
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200710/Oxygen/20200710-Segment3.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200710/Oxygen/20200710-Allopen3.txt'; 
            Depl.Segmentduration = 9*60+28; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-11_164616.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'16:46:47'};
            Depl.dateStringSegtO2End = {'16:56:15'};
            Depl.dateStringSegtAutoStart = {'11/07/2015 16:46:47'};
            Depl.dateStringSegtAutoEnd = {'11/07/2015 16:56:15'};
            Depl.dateStringCompStart = {'16:41:45'};
            Depl.dateStringCompEnd = {'16:42:04'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000710-S3';
    
        case 25
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200713/Oxygen/20200713-Segment2.txt'; % measurement at 3 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200713/Oxygen/20200713-Allopen2.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-14_145011.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:50:41'};
            Depl.dateStringSegtO2End = {'15:00:10'};
            Depl.dateStringSegtAutoStart = {'14/07/2015 14:50:41'};
            Depl.dateStringSegtAutoEnd = {'14/07/2015 15:00:10'};
            Depl.dateStringCompStart = {'14:44:01'};
            Depl.dateStringCompEnd = {'14:44:30'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000713-S2';
            
        case 26
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200713/Oxygen/20200713-Segment3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200713/Oxygen/20200713-Allopen3.txt'; 
            Depl.Segmentduration = 4*60+27; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-14_152328.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:24:00'};
            Depl.dateStringSegtO2End = {'15:28:27'};
            Depl.dateStringSegtAutoStart = {'14/07/2015 15:24:00'};
            Depl.dateStringSegtAutoEnd = {'14/07/2015 15:28:27'};
            Depl.dateStringCompStart = {'15:22:42'};
            Depl.dateStringCompEnd = {'15:23:02'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000713-S3';
            
         case 27
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200713/Oxygen/20200713-Segment4.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200713/Oxygen/20200713-Allopen3.txt'; 
            Depl.Segmentduration = 7*60+8; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-14_153016.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:30:51'};
            Depl.dateStringSegtO2End = {'15:37:59'};
            Depl.dateStringSegtAutoStart = {'14/07/2015 15:30:51'};
            Depl.dateStringSegtAutoEnd = {'14/07/2015 15:37:59'};
            Depl.dateStringCompStart = {'15:22:42'};
            Depl.dateStringCompEnd = {'15:23:02'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000713-S4';

          case 28
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200715/Oxygen/20200715-Segment1.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200715/Oxygen/20200715-Allopen1.txt'; 
            Depl.Segmentduration = 10*60-30; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-16_124911.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'12:49:41'};
            Depl.dateStringSegtO2End = {'12:59:11'};
            Depl.dateStringSegtAutoStart = {'16/07/2015 12:49:41'};
            Depl.dateStringSegtAutoEnd = {'16/07/2015 12:59:11'};
            Depl.dateStringCompStart = {'12:47:38'};
            Depl.dateStringCompEnd = {'12:47:53'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000715-S1';
            
           case 29
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200715/Oxygen/20200715-Segment2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200715/Oxygen/20200715-Allopen2.txt'; 
            Depl.Segmentduration = 10*60-32; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-16_144729.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:47:59'};
            Depl.dateStringSegtO2End = {'14:57:27'};
            Depl.dateStringSegtAutoStart = {'16/07/2015 14:47:59'};
            Depl.dateStringSegtAutoEnd = {'16/07/2015 14:57:27'};
            Depl.dateStringCompStart = {'14:46:26'};
            Depl.dateStringCompEnd = {'14:46:41'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000715-S2';
            
           case 30
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200715/Oxygen/20200715-Segment3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200715/Oxygen/20200715-Allopen3.txt'; 
            Depl.Segmentduration = 9*60+20; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-16_151826.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:19:00'};
            Depl.dateStringSegtO2End = {'15:28:20'};
            Depl.dateStringSegtAutoStart = {'16/07/2015 15:19:00'};
            Depl.dateStringSegtAutoEnd = {'16/07/2015 15:28:20'};
            Depl.dateStringCompStart = {'15:16:50'};
            Depl.dateStringCompEnd = {'15:17:21'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000715-S3';
            
           case 31
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Segment1.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Allopen1.txt'; 
            Depl.Segmentduration = 10*60-36; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-17_115105.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'11:51:40'};
            Depl.dateStringSegtO2End = {'12:01:04'};
            Depl.dateStringSegtAutoStart = {'17/07/2015 11:51:40'};
            Depl.dateStringSegtAutoEnd = {'17/07/2015 12:01:04'};
            Depl.dateStringCompStart = {'11:47:43'};
            Depl.dateStringCompEnd = {'11:47:58'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000716-S1';
            
           case 32
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Segment2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Allopen2.txt'; 
            Depl.Segmentduration = 9*60+27; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-17_123730.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'12:38:02'};
            Depl.dateStringSegtO2End = {'12:47:29'};
            Depl.dateStringSegtAutoStart = {'17/07/2015 12:38:02'};
            Depl.dateStringSegtAutoEnd = {'17/07/2015 12:47:29'};
            Depl.dateStringCompStart = {'12:34:49'};
            Depl.dateStringCompEnd = {'12:35:04'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000716-S2';
            
           case 33
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Segment3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Allopen3.txt'; 
            Depl.Segmentduration = 9*60+30; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-17_133359.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'13:34:29'};
            Depl.dateStringSegtO2End = {'13:43:59'};
            Depl.dateStringSegtAutoStart = {'17/07/2015 13:34:29'};
            Depl.dateStringSegtAutoEnd = {'17/07/2015 13:43:59'};
            Depl.dateStringCompStart = {'13:32:23'};
            Depl.dateStringCompEnd = {'13:32:38'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000716-S3';
            
           case 34
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Segment4.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Allopen4.txt'; 
            Depl.Segmentduration = 8*60+28; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-17_140315.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:03:56'};
            Depl.dateStringSegtO2End = {'14:12:14'};
            Depl.dateStringSegtAutoStart = {'17/07/2015 14:03:56'};
            Depl.dateStringSegtAutoEnd = {'17/07/2015 14:13:14'};
            Depl.dateStringCompStart = {'14:02:26'};
            Depl.dateStringCompEnd = {'14:02:41'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000716-S4';
            
           case 35
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Segment5.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Allopen5.txt'; 
            Depl.Segmentduration = 9*60-9; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-17_143118.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:32:27'};
            Depl.dateStringSegtO2End = {' 14:41:18'};
            Depl.dateStringSegtAutoStart = {'17/07/2015 14:32:27'};
            Depl.dateStringSegtAutoEnd = {'17/07/2015 14:41:18'};
            Depl.dateStringCompStart = {'14:30:22'};
            Depl.dateStringCompEnd = {'14:30:37'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000716-S5';
            
           case 36
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Segment6.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/20200716/Oxygen/20200716-Allopen6.txt'; 
            Depl.Segmentduration = 9*60+27; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/July 2020/Velocity/15-07-17_145843.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:59:15'};
            Depl.dateStringSegtO2End = {' 15:08:42'};
            Depl.dateStringSegtAutoStart = {'17/07/2015 14:59:15'};
            Depl.dateStringSegtAutoEnd = {'17/07/2015  15:08:42'};
            Depl.dateStringCompStart = {'14:57:25'};
            Depl.dateStringCompEnd = {'14:57:40'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000716-S6';
            
           case 37
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200825/Oxygen/20200825_Segment1.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200825/Oxygen/20200825_Allopen1.txt'; 
            Depl.Segmentduration = 9*60+24-1/8; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/Velocity/15-08-26_155052.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:51:26'};
            Depl.dateStringSegtO2End = {'16:00:50'};
            Depl.dateStringSegtAutoStart = {'26/08/2015 15:51:26'};
            Depl.dateStringSegtAutoEnd = {'26/08/2015 16:00:50'};
            Depl.dateStringCompStart = {'15:49:09'};
            Depl.dateStringCompEnd = {'15:49:24'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000825-S1';
                                
           case 38
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200825/Oxygen/20200825_Segment3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200825/Oxygen/20200825_Allopen3.txt'; 
            Depl.Segmentduration = 9*60+27; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/Velocity/15-08-26_184823.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'18:48:54'};
            Depl.dateStringSegtO2End = {'18:58:21'};
            Depl.dateStringSegtAutoStart = {'26/08/2015 18:48:54'};
            Depl.dateStringSegtAutoEnd = {'26/08/2015 18:58:21'};
            Depl.dateStringCompStart = {'18:45:54'};
            Depl.dateStringCompEnd = {'18:46:09'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000825-S3';
                     
            case 39
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Segment1.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Allopen1.txt'; 
            Depl.Segmentduration = 9*60+26; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/Velocity/15-08-27_152319.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:23:49'};
            Depl.dateStringSegtO2End = {'15:33:15'};
            Depl.dateStringSegtAutoStart = {'27/08/2015 15:23:49'};
            Depl.dateStringSegtAutoEnd = {'27/08/2015 15:33:15'};
            Depl.dateStringCompStart = {'15:21:51'};
            Depl.dateStringCompEnd = {'15:22:11'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000826-S1';
            
            case 40
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Segment2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Allopen2.txt'; 
            Depl.Segmentduration = 9*60+16-1/8; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/Velocity/15-08-27_154845.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:49:22'};
            Depl.dateStringSegtO2End = {'15:58:38'};
            Depl.dateStringSegtAutoStart = {'27/08/2015 15:49:22'};
            Depl.dateStringSegtAutoEnd = {'27/08/2015 15:58:38'};
            Depl.dateStringCompStart = {'15:47:30'};
            Depl.dateStringCompEnd = {'15:47:50'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000826-S2';
            
            case 41
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Segment3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Allopen3.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/Velocity/15-08-27_171033.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:11:03'};
            Depl.dateStringSegtO2End = {'17:20:32'};
            Depl.dateStringSegtAutoStart = {'27/08/2015 17:11:03'};
            Depl.dateStringSegtAutoEnd = {'27/08/2015 17:20:32'};
            Depl.dateStringCompStart = {'17:09:30'};
            Depl.dateStringCompEnd = {'17:09:50'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000826-S3';
            
            case 42
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Segment4.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Allopen4.txt'; 
            Depl.Segmentduration = 2*60+44; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/Velocity/15-08-27_173644.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:37:14'};
            Depl.dateStringSegtO2End = {'17:39:58'};
            Depl.dateStringSegtAutoStart = {'27/08/2015 17:37:14'};
            Depl.dateStringSegtAutoEnd = {'27/08/2015 17:39:58'};
            Depl.dateStringCompStart = {'17:35:48'};
            Depl.dateStringCompEnd = {'17:36:08'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000826-S4';
            
            case 43
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Segment5.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Allopen5.txt'; 
            Depl.Segmentduration = 9*60+28; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/Velocity/15-08-27_175307.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:53:37'};
            Depl.dateStringSegtO2End = {'18:03:05'};
            Depl.dateStringSegtAutoStart = {'27/08/2015 17:53:37'};
            Depl.dateStringSegtAutoEnd = {'27/08/2015 18:03:05'};
            Depl.dateStringCompStart = {'17:52:11'};
            Depl.dateStringCompEnd = {'17:52:31'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000826-S5';
            
%             case 44
%             Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Segment5.txt'; % measurement at 4 Hz
%             Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Allopen5.txt'; 
%             Depl.Segmentduration = 9*60+28; %seconds
%             Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/Velocity/15-08-27_175307.csv';%XLS read before
%             Depl.dateStringSegtO2Start = {'17:53:37'};
%             Depl.dateStringSegtO2End = {'18:03:05'};
%             Depl.dateStringSegtAutoStart = {'27/08/2015 17:53:37'};
%             Depl.dateStringSegtAutoEnd = {'27/08/2015 18:03:05'};
%             Depl.dateStringCompStart = {'17:52:11'};
%             Depl.dateStringCompEnd = {'17:52:31'};
%             Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
%             Depl.formatInO2 = 'HH:MM:SS';
%             Depl.location = 'Champs Platform pA';
%             Depl.date = '202000826-S5';
            
            case 45
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Segment6.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/20200826/Oxygen/20200826_Allopen6.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/August 2020/Velocity/15-08-27_183145.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'18:32:15'};
            Depl.dateStringSegtO2End = {'18:41:44'};
            Depl.dateStringSegtAutoStart = {'27/08/2015 18:32:15'};
            Depl.dateStringSegtAutoEnd = {'27/08/2015 18:41:44'};
            Depl.dateStringCompStart = {'18:30:50'};
            Depl.dateStringCompEnd = {'18:31:10'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '202000826-S6';
            
            case 46
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment1.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_120943.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'12:10:13'};
            Depl.dateStringSegtO2End = {'12:19:42'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 12:10:13'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 12:19:42'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S1';
            
            case 47
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_123217.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'12:32:48'};
            Depl.dateStringSegtO2End = {'12:42:17'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 12:32:48'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 12:42:17'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S2';
            
            case 48
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_125554.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'12:56:24'};
            Depl.dateStringSegtO2End = {'13:05:53'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 12:56:24'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 13:05:53'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S3';
            
            case 49
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment4.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_143137.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:32:53'};
            Depl.dateStringSegtO2End = {'14:41:38'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 14:32:53'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 14:41:38'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S4';
            
            case 50
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment4.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_143137.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:42:02'};
            Depl.dateStringSegtO2End = {'14:46:36'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 14:42:02'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 14:46:36'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S4-2';
            
            case 51
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment5.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_150328.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:03:58'};
            Depl.dateStringSegtO2End = {'15:13:28'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 15:03:58'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 15:13:28'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S5';
            
            case 52
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment6.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_152436.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:25:12'};
            Depl.dateStringSegtO2End = {'15:34:36'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 15:25:12'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 15:34:36'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S6';
            
            case 53
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment6.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_153639.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:37:12'};
            Depl.dateStringSegtO2End = {'15:46:38'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 15:37:12'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 15:46:38'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S6-2';
            
            case 54
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment7.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_160347.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'16:04:19'};
            Depl.dateStringSegtO2End = {'16:13:46'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 16:04:19'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 16:13:46'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S7';
            
            case 55
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Segment9.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/20200902/Oxygen/20200902_Allopen.txt'; 
            Depl.Segmentduration = 9*60+29; %seconds
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Summer campaign 2020/Campaigns/September 2020/Velocity/15-09-03_164057.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'16:41:27'};
            Depl.dateStringSegtO2End = {'16:50:56'};
            Depl.dateStringSegtAutoStart = {'03/09/2015 16:41:27'};
            Depl.dateStringSegtAutoEnd = {'03/09/2015 16:50:56'};
            Depl.dateStringCompStart = {'17:03:36'};
            Depl.dateStringCompEnd = {'17:04:46'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'Champs Platform pA';
            Depl.date = '20200902-S9'; 
            
           case 56  
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201013-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201013-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-13_152915.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-13_150808_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-13_151807_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:30:30'};
            Depl.dateStringSegtO2End = {'15:39:14'};
            Depl.dateStringSegtAutoStart = {'13/10/2020  15:30:30'};
            Depl.dateStringSegtAutoEnd = {'13/10/2020  15:39:14'};
            Depl.dateStringCompStart = {'15:14:09'};
            Depl.dateStringCompEnd = {'15:14:49'};
            Depl.dateStringCompAutoStart = {'13/10/2020  15:14:09'};
            Depl.dateStringCompAutoEnd = {'13/10/2020  15:14:49'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201013';
            Depl.hour = '1529';
            
       case 57
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201013-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201013-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-13_164946.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-13_150808_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-13_163626_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'16:51:34'};
            Depl.dateStringSegtO2End = {'16:59:45'};
            Depl.dateStringSegtAutoStart = {'13/10/2020  16:51:34'};
            Depl.dateStringSegtAutoEnd = {'13/10/2020  16:59:45'};
            Depl.dateStringCompStart = {'15:14:09'};
            Depl.dateStringCompEnd = {'15:14:49'};
            Depl.dateStringCompAutoStart = {'13/10/2020  15:14:09'};
            Depl.dateStringCompAutoEnd = {'13/10/2020  15:14:49'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201013';
            Depl.hour = '1650';
       
        case 58  
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201013-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201013-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-13_171120.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-13_150808_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-13_170001_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:12:21'};
            Depl.dateStringSegtO2End = {'17:21:18'};
            Depl.dateStringSegtAutoStart = {'13/10/2020  17:12:21'};
            Depl.dateStringSegtAutoEnd = {'13/10/2020  17:21:18'};
            Depl.dateStringCompStart = {'15:14:09'};
            Depl.dateStringCompEnd = {'15:14:49'};
            Depl.dateStringCompAutoStart = {'13/10/2020  15:14:09'};
            Depl.dateStringCompAutoEnd = {'13/10/2020  15:14:49'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201013';
            Depl.hour = '1711';    
            
          case 59
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_091915.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_090100_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'09:20:23'};
            Depl.dateStringSegtO2End = {'09:34:15'};
            Depl.dateStringSegtAutoStart = {'14/10/2020  09:20:23'};
            Depl.dateStringSegtAutoEnd = {'14/10/2020  09:34:15'};
            Depl.dateStringCompStart = {'10:35:14'};
            Depl.dateStringCompEnd = {'10:35:43'};
            Depl.dateStringCompAutoStart = {'14/10/2020  10:35:14'};
            Depl.dateStringCompAutoEnd = {'14/10/2020  10:35:43'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201014';
            Depl.hour = '0919';
            
          case 60
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_100439.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_094451_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'10:05:59'};
            Depl.dateStringSegtO2End = {'10:19:38'};
            Depl.dateStringSegtAutoStart = {'14/10/2020  10:05:59'};
            Depl.dateStringSegtAutoEnd = {'14/10/2020  10:19:38'};
            Depl.dateStringCompStart = {'10:35:14'};
            Depl.dateStringCompEnd = {'10:35:43'};
            Depl.dateStringCompAutoStart = {'14/10/2020  10:35:14'};
            Depl.dateStringCompAutoEnd = {'14/10/2020  10:35:43'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201014';
            Depl.hour = '1005';
            
           case 61
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_105944.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103551_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'11:00:52'};
            Depl.dateStringSegtO2End = {'11:14:43'};
            Depl.dateStringSegtAutoStart = {'14/10/2020  11:00:52'};
            Depl.dateStringSegtAutoEnd = {'14/10/2020  11:14:43'};
            Depl.dateStringCompStart = {'11:22:45'};
            Depl.dateStringCompEnd = {'11:23:15'};
            Depl.dateStringCompAutoStart = {'14/10/2020  11:22:45'};
            Depl.dateStringCompAutoEnd = {'14/10/2020  11:23:15'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201014';
            Depl.hour = '1100';

           case 62
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_113946.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_112314_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'11:40:49'};
            Depl.dateStringSegtO2End = {'11:54:46'};
            Depl.dateStringSegtAutoStart = {'14/10/2020  11:40:49'};
            Depl.dateStringSegtAutoEnd = {'14/10/2020  11:54:46'};
            Depl.dateStringCompStart = {'11:22:45'};
            Depl.dateStringCompEnd = {'11:23:15'};
            Depl.dateStringCompAutoStart = {'14/10/2020  10:35:14'};
            Depl.dateStringCompAutoEnd = {'14/10/2020  10:35:43'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201014';
            Depl.hour = '1140';
            
           case 63
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_121959.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_120306_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'12:21:21'};
            Depl.dateStringSegtO2End = {'12:34:58'};
            Depl.dateStringSegtAutoStart = {'14/10/2020  12:21:21'};
            Depl.dateStringSegtAutoEnd = {'14/10/2020  12:34:58'};
            Depl.dateStringCompStart = {'11:22:45'};
            Depl.dateStringCompEnd = {'11:23:15'};
            Depl.dateStringCompAutoStart = {'14/10/2020  10:35:10'};
            Depl.dateStringCompAutoEnd = {'14/10/2020  10:35:43'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201014';
            Depl.hour = '1220';
                   
           case 64
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_141225.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_135654_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:14:11'};
            Depl.dateStringSegtO2End = {'14:27:24'};
            Depl.dateStringSegtAutoStart = {'14/10/2020  14:14:11'};
            Depl.dateStringSegtAutoEnd = {'14/10/2020  14:27:24'};
            Depl.dateStringCompStart = {'14:40:53'};
            Depl.dateStringCompEnd = {'14:41:20'};
            Depl.dateStringCompAutoStart = {'14/10/2020  14:40:53'};
            Depl.dateStringCompAutoEnd = {'14/10/2020  14:41:20'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201014';
            Depl.hour = '1413';
            
           case 65
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_145834.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_144133_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'14:59:50'};
            Depl.dateStringSegtO2End = {'15:13:33'};
            Depl.dateStringSegtAutoStart = {'14/10/2020  14:59:50'};
            Depl.dateStringSegtAutoEnd = {'14/10/2020  15:13:33'};
            Depl.dateStringCompStart = {'14:40:53'};
            Depl.dateStringCompEnd = {'14:41:20'};
            Depl.dateStringCompAutoStart = {'14/10/2020  10:35:10'};
            Depl.dateStringCompAutoEnd = {'14/10/2020  10:35:43'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201014';
            Depl.hour = '1459';

           case 66
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_153828.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_152035_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'15:40:32'};
            Depl.dateStringSegtO2End = {'15:53:27'};
            Depl.dateStringSegtAutoStart = {'14/10/2020  15:40:32'};
            Depl.dateStringSegtAutoEnd = {'14/10/2020  15:53:27'};
            Depl.dateStringCompStart = {'14:40:53'};
            Depl.dateStringCompEnd = {'14:41:20'};
            Depl.dateStringCompAutoStart = {'14/10/2020  10:35:10'};
            Depl.dateStringCompAutoEnd = {'14/10/2020  10:35:43'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201014';
            Depl.hour = '1540';
            
           case 67
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201014-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_170414.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_164858_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'17:05:53'};
            Depl.dateStringSegtO2End = {'17:14:12'};
            Depl.dateStringSegtAutoStart = {'14/10/2020  17:05:53'};
            Depl.dateStringSegtAutoEnd = {'14/10/2020  17:14:12'};
            Depl.dateStringCompStart = {'14:40:53'};
            Depl.dateStringCompEnd = {'14:41:20'};
            Depl.dateStringCompAutoStart = {'14/10/2020  10:35:10'};
            Depl.dateStringCompAutoEnd = {'14/10/2020  10:35:43'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201014';
            Depl.hour = '1705';
            
           case 68
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201015-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201015-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-15_092944.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-15_091423_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'09:31:13'};
            Depl.dateStringSegtO2End = {'09:47:09'};
            Depl.dateStringSegtAutoStart = {'15/10/2020  09:31:13'};
            Depl.dateStringSegtAutoEnd = {'15/10/2020  09:47:09'};
            Depl.dateStringCompStart = {'09:55:15'};
            Depl.dateStringCompEnd = {'09:55:31'};
            Depl.dateStringCompAutoStart = {'15/10/2020  09:55:15'};
            Depl.dateStringCompAutoEnd = {'15/10/2020  09:55:31'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201015';
            Depl.hour = '0929';
            
           case 69
            Depl.filePathFiresting = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201015-planaqua.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Oxygen/20201015-planaqua.txt'; 
            Depl.velocityfile = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-15_101819.csv';%XLS read before
            Depl.velocityfileCompensation = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-14_103510_Comp.csv';%XLS read before
            Depl.velocityfileAngles = 'C:/Users/g.calabro-souza/Documents/Doctorat/Planaqua campaign 2020/Automation/20-10-15_095816_AR.csv';%XLS read before
            Depl.dateStringSegtO2Start = {'10:20:15'};
            Depl.dateStringSegtO2End = {'10:38:17'};
            Depl.dateStringSegtAutoStart = {'15/10/2020  10:20:15'};
            Depl.dateStringSegtAutoEnd = {'15/10/2020  10:38:17'};
            Depl.dateStringCompStart = {'09:55:11'};
            Depl.dateStringCompEnd = {'09:55:41'};
            Depl.dateStringCompAutoStart = {'15/10/2020  09:55:11'};
            Depl.dateStringCompAutoEnd = {'15/10/2020  09:55:41'};
            Depl.formatInAutomate = 'dd/mm/yyyy HH:MM:SS';
            Depl.formatInO2 = 'HH:MM:SS';
            Depl.location = 'PLANAQUA';
            Depl.date = '20201015';
            Depl.hour = '1018';
    end

