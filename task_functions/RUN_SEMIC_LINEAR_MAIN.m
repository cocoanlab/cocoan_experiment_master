%% Linear session 1: ratings

close all;
clear;
exp = {'overall_avoidance'};
scriptdir = 'C:\Users\Cocoan Lab WD02\Documents\Experiments\cocoan_experiment_master\task_functions';
ts = generate_ts_semic(1, 'linear');
cps_main(ts, 'fmri', 'explain_scale', exp, 'scriptdir', scriptdir, 'biopac'); %data = ?

%% Linear session 2:  pain reference

close all;
ts = generate_ts_semic(2, 'linear');
data = cps_main(ts, 'fmri', 'scriptdir', scriptdir, 'biopac');

%% Linear session 3: social + pain

close all;
ts = generate_ts_semic(3, 'linear', 'data', data);
ts(2:3) = []; % delete run 2 and 3
cps_main(ts, 'fmri', 'scriptdir', scriptdir, 'biopac');