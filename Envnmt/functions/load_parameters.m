function Param = load_parameters
    %functions origins
    %modifications made
    %author
    %Pass the mesured height above segt and mean oxygen sampling frequency
    %to Deployment_parameters
    %Parameters copied from main5.m at April 29th by Guilherme for AquaREA
    %project

    % switches (1 to perform the action)
    Param.PLOTRAWDATA = 0;                   % plot deployment raw data
    Param.COMPUTEFLUXES =1;                  % compute segment fluxes
    Param.COMPUTESEGMENTVELOCITYSTATS =1;    % turbulent paremeters on segments
    Param.COMPUTEDEPLOYMENTVELOCITYSTATS =0; % velocity autospectra and Baker's b for whole deployment

    % CONSTANTS
    Param.VONKARMAN         = 0.41;     % von Karman's constant (-)
    Param.GRAVITY           = 9.8;      % gravity acceleration (m s^-2)

    Param.DENSITY           = 999.2;    % water density kg.mâ?»Â³
    Param.HEATCAPACITY      = 4185.5;   % water heat capacity J.Kâ?»Â¹.kgâ?»Â¹
    Param.KINEMATICVISCOSITY  = 1e-6;   % water kinematic viscosity (m s-2) TO DO: COMPUTE FROM TEMPERATURE
    
    Param.DIOXYGENMOLARMASS = 32;       % dioxygen molar mass g/mol
    
    Param.CORRELATIONVELOCITIESXZ2DFLOW = -0.342;     % Nezu & Nakagawa, Turbulence in open-channel flows, 1993 eq 4.17

    % Particle concentration (Lake Constance calibration)
    % H., A. Lorke, and F. Peeters (2011), Wind and ship waveâ€?induced resuspension in the littoral zone of a large lake, Water Resour. Res., 47, W09505, doi:10.1029/2010WR010012. 
    % particleConcentration[mg/L] = 0.0048*exp(0.0674*S) where S ADV amplitude averaged over the 3 directions
    Param.PARTICLEPREFACTOR = 0.0048;
    Param.PARTICLEEXPONENT  = 0.0674;

    % MEASURING CONFIGURATION
    Param.ADVSAMPLINGFREQUENCY = 8;         % ADV sampling frequency (Hz) from .hdr (user setup)
                                            % name was changed from
                                            % SAMPLINGFREQUENCY to 
                                            % ADVSAMPLINGFREQUENCY
    Param.FIRESTINGSAMPLINGFREQUENCY = 4;
    % height above lake bottom
    Param.HEIGHT = 0.2;   % m
    
    % ANALYSIS PARAMETERS
    % Number of frequency points for velocity autospectra 
    % (set to maximum for ogives, cumulative spectra, for a better precision at low frequencies)
    Param.NFREQUENCYFFT = 1024;                   % 26/06, to lighten files
%    Param.NFREQUENCYFFT = 2*4096;                   % nFft/2+1 points on one-sided spectra (2*4096 in REA_main) can be longer than data set, verification after spectra
    
    Param.VELOCITYCORRELATION = 70                  % minimum correlation tolerated for ADV raw velocity
    Param.SNR = 15                                  % dB, minimum tolerated 
    % running average length for Havel data to filter lock operation (odd number required): 1 min as in Erni's work 
    Param.RUNNINGAVERAGEMIN = 1;                                % min
    Param.RUNNINGAVERAGE = Param.RUNNINGAVERAGEMIN*60*Param.ADVSAMPLINGFREQUENCY +1;   % odd number of points
    
    % duration of mean for running EC and REA fluxes and for segments (must be larger than Param.RUNNINGAVERAGEMIN)
    Param.FLUXRANGEMIN = 10;                                % min
%    Param.FLUXRANGEMIN = 71;                                % TEST for deployment 1
    Param.FLUXRANGE = Param.FLUXRANGEMIN*60*Param.ADVSAMPLINGFREQUENCY;        % points

    % timeshift search range (s) (4 s until 01/12/2015, 2 s until 13/01/2017)
    Param.TIMESHIFTSEARCHRANGESEC = 3; %value was 1 in main5.m changed to 10 in this case in order to enlarge scope 
    Param.PLOTTIMESHIFT = 1;        % to plot fluxes vs time shift

    % Coefficient b in REA flux formula
    Param.REABCOEF = 0;         % from velocities (Baker, 2000) b = std(w)/mean(abs(w)) 
    %Param.REABCOEF = 0.627;    % Gaussian joint distribution functions

    % parameters for b coefficient vs velocity threshold (22/06/2016)
    % velocityZThreshold = Param.VELOCITYZTHRESHOLDMAX*stdVelocityZPrime*(0:1/(Param.NVELOCITYZTHRESHOLD-1):1);
    Param.VELOCITYZTHRESHOLDMAX = 2; % max threshold velocity in std(velocityZPrime)
    Param.NVELOCITYZTHRESHOLD = 101; % nb of threshold points
    
    % Flag for figure and data file names
    if Param.REABCOEF == 0
        Param.REABCOEFFICIENTFLAG = 'bBaker';
    elseif Param.REABCOEF == 0.627
        Param.REABCOEFFICIENTFLAG = 'bGaussian';
    else Param.REABCOEFFICIENTFLAG = 'bfixed';
    end
    
%    Param.MATFILEDIRECTORY = '../../Output/Havel/REA/newTimeShift/';
    Param.FIGUREDIRECTORY = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab'; %insert figures in Guilherme's computer
%    Param.MATFILEDIRECTORY = '../../Output/Havel/REA/test/';
    Param.FIGUREDIRECTORY = '/Users/clement/Documents/Polytechnique/Cours/3A/Stage/Matlab'; 
    
    
    %10/03 minimum REA fluxes for b computation (from dispersion of b
    %values for small fluxes)
%    Param.MINREAFLUXHEAT = 5; % W m-2
%    Param.MINREAFLUXOXYGEN = 3; % mmol m-2 d-1
%    Param.MINREAFLUXPARTICLE = 10; % g m-2 d-1

end