function Depl = deployment_parameter_planaqua( iDeployment, Param )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Depl.segNFft = 2^nextpow2(Param.FLUXRANGE); %test copied from main5
Depl.iDeployment = iDeployment;
    switch Depl.iDeployment
        
           case 1
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_105342.csv';%XLS read before
            Depl.dateStringCompStart = {'10:53:07'};
            Depl.dateStringCompEnd = {'10:53:47'};
            
            case 2
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_113239.csv';%XLS read before
            Depl.dateStringCompStart = {'10:53:07'};
            Depl.dateStringCompEnd = {'10:53:47'};
            
            case 3
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_114306.csv';%XLS read before
            Depl.dateStringCompStart = {'11:43:52'};
            Depl.dateStringCompEnd = {'11:44:32'};
            
            case 4
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_120126.csv';%XLS read before
            Depl.dateStringCompStart = {'11:43:52'};
            Depl.dateStringCompEnd = {'11:44:32'};
            
            case 5
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_122122.csv';%XLS read before
            Depl.dateStringCompStart = {'11:43:52'};
            Depl.dateStringCompEnd = {'11:44:32'};
            
            case 6
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_124829.csv';%XLS read before
            Depl.dateStringCompStart = {'13:05:52'};
            Depl.dateStringCompEnd = {'13:06:32'};
            
            case 7
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_143237.csv';%XLS read before
            Depl.dateStringCompStart = {'13:05:52'};
            Depl.dateStringCompEnd = {'13:06:32'};
            
            case 8
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_144228.csv';%XLS read before
            Depl.dateStringCompStart = {'13:05:52'};
            Depl.dateStringCompEnd = {'13:06:32'};
            
            case 9
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_150906.csv';%XLS read before
            Depl.dateStringCompStart = {'13:05:52'};
            Depl.dateStringCompEnd = {'13:06:32'};
            
            case 10
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_153512.csv';%XLS read before
            Depl.dateStringCompStart = {'13:05:52'};
            Depl.dateStringCompEnd = {'13:06:32'};
            
            case 11
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/20210521_planaqua2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Planaqua/20210521/21-05-21_160144.csv';%XLS read before
            Depl.dateStringCompStart = {'13:05:52'};
            Depl.dateStringCompEnd = {'13:06:32'};

            
            
    end

