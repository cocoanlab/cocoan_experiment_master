%% Linear session 1: ratings

close all;
clear;
exp = {'overall_avoidance'};
%ts = generate_ts_cps;
ts = generate_ts_semic(1, 'linear');
cps_main(ts, 'fmri', 'explain_scale', exp, 'scriptdir', pwd, 'biopac');

%% Linear session 2:  pain reference

close all;
exp = {'overall_avoidance'};
%ts = generate_ts_cps;
ts = generate_ts_semic(2, 'linear');
data = cps_main(ts, 'fmri', 'scriptdir', pwd, 'biopac');

%% Linear session 3: social + pain

close all;
exp = {'overall_avoidance'};
%ts = generate_ts_cps;
ts = generate_ts_semic(3, 'linear', 'data', data);
cps_main(ts, 'fmri', 'scriptdir', pwd, 'biopac');