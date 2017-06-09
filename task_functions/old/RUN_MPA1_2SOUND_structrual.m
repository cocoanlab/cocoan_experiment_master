%% NEW START

clear all;
[ts, exp] = generate_ts_mpa1_soundtesting;
data = mpa1_main(ts, 'explain_scale', exp.instructions);

%% START after an error

% % load subject's data from "task_functions_v4/MPA1_data"
% data = mpa1_main(trial_sequence);
