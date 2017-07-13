%% Semicircular session 1: pain reference

close all;
clear;
scriptdir = 'C:\Users\Cocoan Lab WD02\Documents\Experiments\cocoan_experiment_master\task_functions';
exp = {'overall_avoidance'};
ts = generate_ts_semic(2, 'linear');
data = cps_main(ts, 'fmri', 'explain_scale', exp, 'scriptdir', scriptdir, 'biopac');

%% Semicircular session 2: social + pain

close all;
ts = generate_ts_semic(3, 'linear', 'data', data);
cps_main(ts, 'fmri', 'scriptdir', scriptdir, 'biopac');