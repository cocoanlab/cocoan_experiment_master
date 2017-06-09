%% NEW START

clear all;
ts = generate_ts_mpa1_prescan;
data = mpa1_main(ts);

%% When starting after an error

% % load subject's data from "task_functions_v4/MPA1_data"
% data = mpa1_main(trial_sequence);

