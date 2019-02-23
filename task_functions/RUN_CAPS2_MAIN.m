%% NEW START

clear;
exp = {'overall_avoidance'};
%ts = generate_ts_cps;
ts = generate_ts_cps_long;
data = cps_main(ts, 'fmri', 'explain_scale', exp, 'scriptdir', pwd);

%% START after an error

% % load subject's data from "task_functions/CPS_data"
% data = cps_main(trial_sequence, 'fmri');

