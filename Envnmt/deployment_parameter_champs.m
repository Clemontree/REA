function Depl = deployment_parameter_champs( iDeployment, Param )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Depl.segNFft = 2^nextpow2(Param.FLUXRANGE); %test copied from main5
Depl.iDeployment = iDeployment;
Depl.velocityfileinitiationpath = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_150001.csv'
    switch Depl.iDeployment
        
           case 1
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_154906.csv';%XLS read before
            Depl.dateStringCompStart = {'15:00:30'};
            Depl.dateStringCompEnd = {'15:01:10'};
            
            case 2
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_161750.csv';%XLS read before
            Depl.dateStringCompStart = {'15:00:30'};
            Depl.dateStringCompEnd = {'15:01:10'};
            
            
            case 3
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_164327.csv';%XLS read before
            Depl.dateStringCompStart = {'15:00:30'};
            Depl.dateStringCompEnd = {'15:01:10'};
            
            case 4
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_170632.csv';%XLS read before
            Depl.dateStringCompStart = {'15:00:30'};
            Depl.dateStringCompEnd = {'15:01:10'};
            
            case 5
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_173455.csv';%XLS read before
            Depl.dateStringCompStart = {'15:00:30'};
            Depl.dateStringCompEnd = {'15:01:10'};
            
            case 6
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_180233.csv';%XLS read before
            Depl.dateStringCompStart = {'15:00:30'};
            Depl.dateStringCompEnd = {'15:01:10'};
            
            case 7
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_182418.csv';%XLS read before
            Depl.dateStringCompStart = {'15:00:30'};
            Depl.dateStringCompEnd = {'15:01:10'};
            
            case 8
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_184839.csv';%XLS read before
            Depl.dateStringCompStart = {'15:00:30'};
            Depl.dateStringCompEnd = {'15:01:10'};
            
            case 8
            Depl.filePathFiresting = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs3.txt'; % measurement at 4 Hz
            Depl.filePathFirestingCompensation = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/20210605/20210605-Champs2.txt'; 
            Depl.velocityfile = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab/wetransfer-342365-2/Champs/21-06-05_191306.csv';%XLS read before
            Depl.dateStringCompStart = {'15:00:30'};
            Depl.dateStringCompEnd = {'15:01:10'};

            
            
    end

