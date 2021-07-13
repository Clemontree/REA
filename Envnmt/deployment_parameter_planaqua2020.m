function Depl = deployment_parameter_planaqua2020( iDeployment, Param )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


Depl.segNFft = 2^nextpow2(Param.FLUXRANGE); %test copied from main5
Depl.location = 'Planaqua'; %place of the camapign
Depl.date = '15-Oct-2020'; %date of the campaign
Depl.iDeployment = iDeployment;
Depl.temperature = [9.8,12 ]; %temperature at the beginning and at the end of the campaign for later interpolation
Depl.ecRow =20; % row corresponding to the EC oxymeter in the .txt file from the firesting
Depl.upRow = 21; % row corresponding to the Up REA oxymeter in the .txt file from the firesting
Depl.dwRow = 19; % row corresponding to the Down REA oxymeter in the .txt file from the firesting
Depl.ave = 800; % number of points used to calculate the angles for the planar fit 
Depl.segmentDuration = 15; %min, duration of the segments for EC alone
Depl.nbSegments = 13; %number of segments for EC to compare sepcifically with the segments from REA
Depl.figTitle = string(Depl.location) + ' '+string(Depl.date);
Depl.figName =  ' '+string(Depl.location) + ' '+string(Depl.date);
mydirectory = '../Campagnes/Planaqua2020/';%


    switch Depl.iDeployment
        
        
           case 1
            Depl.filePathFiresting = mydirectory+"20201013-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201013-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-13_152915.csv";%XLS read before
            Depl.dateStringCompStart = {'15:14:09'};
            Depl.dateStringCompEnd = {'15:14:49'};
            Depl.date = "13-Oct-2020";
            
            
           case 2
            Depl.filePathFiresting = mydirectory+"20201013-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201013-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-13_164946.csv";%XLS read before
            Depl.dateStringCompStart = {'15:14:09'};
            Depl.dateStringCompEnd = {'15:14:49'};
            Depl.date = "13-Oct-2020";
           
        
           case 3
            Depl.filePathFiresting = mydirectory+"20201013-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201013-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-13_171120.csv";%XLS read before
            Depl.dateStringCompStart = {'15:14:09'};
            Depl.dateStringCompEnd = {'15:14:49'};
            Depl.date = "13-Oct-2020";
            
            
            case 4
            Depl.filePathFiresting = mydirectory+"20201014-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201014-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-14_091915.csv";%XLS read before
            Depl.dateStringCompStart = {'10:35:14'};
            Depl.dateStringCompEnd = {'10:35:43'};
            Depl.date = "14-Oct-2020";
            
            case 5
            Depl.filePathFiresting = mydirectory+"20201014-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201014-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-14_100439.csv";%XLS read before
            Depl.dateStringCompStart = {'10:35:14'};
            Depl.dateStringCompEnd = {'10:35:43'};
            Depl.date = "14-Oct-2020";
            
            case 6
            Depl.filePathFiresting = mydirectory+"20201014-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201014-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-14_105944.csv";%XLS read before
            Depl.dateStringCompStart = {'11:22:45'};
            Depl.dateStringCompEnd = {'11:23:15'};
            Depl.date = "14-Oct-2020";
            
            case 7
            Depl.filePathFiresting = mydirectory+"20201014-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201014-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-14_113946.csv";%XLS read before
            Depl.dateStringCompStart = {'11:22:45'};
            Depl.dateStringCompEnd = {'11:23:15'};
            Depl.date = "14-Oct-2020";
            
            case 7
            Depl.filePathFiresting = mydirectory+"20201014-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201014-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-14_121959.csv";%XLS read before
            Depl.dateStringCompStart = {'11:22:45'};
            Depl.dateStringCompEnd = {'11:23:15'};
            Depl.date = "14-Oct-2020";
            
            case 8
            Depl.filePathFiresting = mydirectory+"20201014-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201014-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-14_141225.csv";%XLS read before
            Depl.dateStringCompStart = {'14:40:53'};
            Depl.dateStringCompEnd = {'14:41:20'};
            Depl.date = "14-Oct-2020";
            
            
            case 9
            Depl.filePathFiresting = mydirectory+"20201014-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201014-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-14_145834.csv";%XLS read before
            Depl.dateStringCompStart = {'14:40:53'};
            Depl.dateStringCompEnd = {'14:41:20'};
            Depl.date = "14-Oct-2020";
            
            case 10
            Depl.filePathFiresting = mydirectory+"20201014-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201014-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-14_153828.csv";%XLS read before
            Depl.dateStringCompStart = {'14:40:53'};
            Depl.dateStringCompEnd = {'14:41:20'};
            Depl.date = "14-Oct-2020";
            
            case 11
            Depl.filePathFiresting = mydirectory+"20201014-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201014-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-14_170414.csv";%XLS read before
            Depl.dateStringCompStart = {'14:40:53'};
            Depl.dateStringCompEnd = {'14:41:20'};
            Depl.date = "14-Oct-2020";
            
            case 12
            Depl.filePathFiresting = mydirectory+"20201015-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201015-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-15_092944.csv";%XLS read before
            Depl.dateStringCompStart = {'09:55:15'};
            Depl.dateStringCompEnd = {'09:55:31'};
            Depl.date = "15-Oct-2020";
            
            case 13
            Depl.filePathFiresting = mydirectory+"20201015-planaqua.txt"; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = mydirectory+"20201015-planaqua.txt"; 
            Depl.velocityfile = mydirectory+"20-10-15_101819.csv";%XLS read before
            Depl.dateStringCompStart = {'09:55:11'};
            Depl.dateStringCompEnd = {'09:55:41'};
            Depl.date = "15-Oct-2020";
            
            

            
            
    end

