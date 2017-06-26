function trigger_biopac = biopac_setting_io64(io64dir)


io64dir = 'C:\Program Files\MATLAB\R2015a\toolbox\io64mex';
%[~, hn] = system('hostname'); hn=deblank(hn);
addpath(genpath(io64dir));

global BIOPAC_PORT;

%if strcmp(hn,'INC-DELL-002')
%BIOPAC_PORT = hex2dec('E010');
BIOPAC_PORT = 10;
trigger_biopac = str2func('TriggerBiopac3_io64');
%else
%     BIOPAC_PORT = digitalio('parallel','LPT2');
%     addline(BIOPAC_PORT,0:7,'out');
%     trigger_biopac = str2func('TriggerBiopac');
%end

end