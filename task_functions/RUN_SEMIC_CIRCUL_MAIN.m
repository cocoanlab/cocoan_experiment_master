%% Semicircular session 1: ratings

close all;
clear;
exp = {'overall_avoidance_semicircular'};
%ts = generate_ts_cps;
ts = generate_ts_semic(1, 'semicircular');
cps_main(ts, 'fmri', 'explain_scale', exp, 'scriptdir', pwd, 'biopac');

%% Semicircular session 2: pain reference

close all;

%clear;
ts = generate_ts_semic(2, 'semicircular');
data = cps_main(ts, 'fmri', 'scriptdir', pwd, 'biopac');

%% Semicircular session 3: social + pain

close all;
%clear;
ts = generate_ts_semic(3, 'semicircular', 'data', data);
cps_main(ts, 'fmri', 'scriptdir', pwd, 'biopac');

% 
% %% START after an error
% 
% % % load subject's data from "task_functions/CPS_data"
% % data = cps_main(trial_sequence, 'fmri');
% close all;
% figure;
% i=13;
% a = data.dat{1}{i}.overall_avoidance_semicircular_time_fromstart./max(data.dat{1}{i}.overall_avoidance_semicircular_time_fromstart);
% plot(data.dat{1}{i}.overall_avoidance_semicircular_cont_rating_xy(:,1), data.dat{1}{i}.overall_avoidance_semicircular_cont_rating_xy(:,2));
% scatter(data.dat{1}{i}.overall_avoidance_semicircular_cont_rating_xy(:,1), data.dat{1}{i}.overall_avoidance_semicircular_cont_rating_xy(:,2), 50, [a flipud(a) zeros(size(a,1),1)], 'filled');
% set(gca, 'xlim', [-1 1], 'ylim', [-.5 1]);
