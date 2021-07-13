function Depl = deployment_parameter_loge( iDeployment, Param )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


Depl.segNFft = 2^nextpow2(Param.FLUXRANGE); %test copied from main5
Depl.location = 'Loge'; %place of the camapign
Depl.date = '29-Apr-2021'; %date of the campaign
Depl.iDeployment = iDeployment;
Depl.temperature = [9.8,12 ]; %temperature at the beginning and at the end of the campaign for later interpolation
Depl.ecRow =20; % row corresponding to the EC oxymeter in the .txt file from the firesting
Depl.upRow = 21; % row corresponding to the Up REA oxymeter in the .txt file from the firesting
Depl.dwRow = 19; % row corresponding to the Down REA oxymeter in the .txt file from the firesting
Depl.ave = 800; % number of points used to calculate the angles for the planar fit 
Depl.segmentDuration = 15; %min, duration of the segments for EC alone
Depl.nbSegments = 8; %number of segments for EC to compare sepcifically with the segments from REA
Depl.figTitle = string(Depl.location) + ' '+string(Depl.date);
Depl.figName =  ' '+string(Depl.location) + ' '+string(Depl.date);
mydirectory = '../Campagnes/Loge2904/';%


    switch Depl.iDeployment
        
           case 1
            Depl.filePathFiresting = mydirectory+"202010429_loge_2.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"202010429_loge_2.txt"; 
            Depl.velocityfile = mydirectory+"21-04-29_110110.csv";%XLS read before
            Depl.dateStringCompStart = {'10:53:07'};
            Depl.dateStringCompEnd = {'10:53:47'};
            
            case 2
            Depl.filePathFiresting = mydirectory+"202010429_loge_2.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"202010429_loge_2.txt"; 
            Depl.velocityfile = mydirectory+"21-04-29_111635.csv";%XLS read before
            Depl.dateStringCompStart = {'10:53:07'};
            Depl.dateStringCompEnd = {'10:53:47'};
            
            case 3
            Depl.filePathFiresting = mydirectory+"202010429_loge_2.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"202010429_loge_2.txt"; 
            Depl.velocityfile = mydirectory+"21-04-29_114941.csv";%XLS read before
            Depl.dateStringCompStart = {'11:43:52'};
            Depl.dateStringCompEnd = {'11:44:32'};
            
            case 4
            Depl.filePathFiresting = mydirectory+"202010429_loge_2.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"202010429_loge_2.txt"; 
            Depl.velocityfile = mydirectory+"21-04-29_121246.csv";%XLS read before
            Depl.dateStringCompStart = {'11:43:52'};
            Depl.dateStringCompEnd = {'11:44:32'};
            
            case 5
            Depl.filePathFiresting = mydirectory+"202010429_loge_2.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"202010429_loge_2.txt"; 
            Depl.velocityfile = mydirectory+"21-04-29_123734.csv";%XLS read before
            Depl.dateStringCompStart = {'11:43:52'};
            Depl.dateStringCompEnd = {'11:44:32'};
            
            case 6
            Depl.filePathFiresting = mydirectory+"202010429_loge_2.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"202010429_loge_2.txt"; 
            Depl.velocityfile = mydirectory+"21-04-29_131118.csv";%XLS read before
            Depl.dateStringCompStart = {'13:05:52'};
            Depl.dateStringCompEnd = {'13:06:32'};
            
            case 7
            Depl.filePathFiresting = mydirectory+"202010429_loge_2.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"202010429_loge_2.txt"; 
            Depl.velocityfile = mydirectory+"21-04-29_133105.csv";%XLS read before
            Depl.dateStringCompStart = {'13:05:52'};
            Depl.dateStringCompEnd = {'13:06:32'};
            
            case 8
            Depl.filePathFiresting = mydirectory+"202010429_loge_2.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"202010429_loge_2.txt"; 
            Depl.velocityfile = mydirectory+"21-04-29_134853.csv";%XLS read before
            Depl.dateStringCompStart = {'13:05:52'};
            Depl.dateStringCompEnd = {'13:06:32'};

            
            
    end

