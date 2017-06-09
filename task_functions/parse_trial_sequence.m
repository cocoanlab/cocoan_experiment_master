function [run_num, trial_num, runstart, trial_start, rating_types] = parse_trial_sequence(trial_sequence, start_line)

% PARSING TRIAL SEQUENCE: each trial info
% [run_num, trial_num, runstart, trial_start, rating_types] = parse_trial_sequence(trial_sequence, start_line)
%
% e.g.) trial_sequence{1}{1} = {'PP' (stimulus type), 'LV1' (levels), '0010' (duration), ...
%                               {'cont_avoidance', 'overall_avoidance', 'overall_aversive_ornot'}(rating types), ...
%                               '0'(cue duration), '3' (pre-rating jitter), '7' (ITI jitter)};
%       
%         'cont_int': continuous intensity rating
%         'cont_avoidance': continuous rating
%         'overall_int': overall intensity rating 
%         'overall_pleasant': overall intensity rating 
%         'overall_avoidance': overall avoidance rating 
%         'overall_aversive_ornot'
%         'overall_pain_ornot'

run_num = numel(trial_sequence);
idx = zeros(run_num+1,1); % index to calculate trial_start
trial_num = zeros(run_num,1);
trial_start = ones(run_num,1);

% ********** IMPORTANT NOTE **********
% YOU CAN ADD TYPES AND PROMPTS HERE. "cont_" AND "overall_" ARE IMPORTANT.
% * CRUCIAL: THE ORDER BETWEEN alltypes AND prompts SHOULD BE THE SAME.*
rating_types.alltypes = ...
    {'cont_int', ...
    'cont_avoidance', ...
    'overall_int', ...
    'overall_avoidance', ...
    'overall_unpleasant', ...
    'overall_aversive_ornot', ...
    'overall_pain_ornot'};
rating_types.prompts = ...
    {'Please rate pain intensity CONTINUOUSLY.', ...
    'Please rate HOW MUCH you want to avoid this stimuli in the future CONTINUOUSLY.', ...
    'HOW MUCH pressure was applied?', ...
    'Please rate HOW MUCH you want to avoid this experience in the future?', ...
    'Please rate the overall unpleasantness you experienced.', ...
    'Was it aversive?',...
    'Was it painful?'};

for i = 1:run_num
    trial_num(i,1) = numel(trial_sequence{i});
    idx(i+1) = idx(i) + trial_num(i);
    
    if idx(i) < start_line && idx(i+1) >= start_line
        runstart = i;
        trial_start(i,1) = start_line - idx(i);
    end
    
    for j = 1:trial_num(i)
        % (4) rating type1, continuous, overall_int, overall_pleasant, or all
        for ii = 1:numel(rating_types.alltypes)
            rating_types.docont{i}{j} = trial_sequence{i}{j}{4}(strncmp(trial_sequence{i}{j}{4}, 'cont_', 5)); % first, need to know continuous or not? 
            rating_types.dooverall{i}{j} = trial_sequence{i}{j}{4}(strncmp(trial_sequence{i}{j}{4}, 'overall_', 8));
        end
    end
end

end