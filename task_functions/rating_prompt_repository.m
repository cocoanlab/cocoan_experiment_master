function rating_types = rating_prompt_repository(rating_types)

% rating_types = rating_prompt_repository(rating_types)
%
% Repository for rating types and prompts for the rating types


% ********** IMPORTANT NOTE **********
% YOU CAN ADD TYPES AND PROMPTS HERE. "cont_" AND "overall_" ARE IMPORTANT.
% * CRUCIAL: THE ORDER BETWEEN alltypes AND prompts SHOULD BE THE SAME.*
rating_types.alltypes = ...
    {'cont_int', ...
    'cont_avoidance', ...
    'cont_avoidance_exp', ...
    'overall_int', ...
    'overall_avoidance', ...
    'overall_unpleasant', ...
    'overall_aversive_ornot', ...
    'overall_pain_ornot', ...
    'overall_boredness', ...
    'overall_alertness', ...
    'overall_relaxed',...
    'overall_attention',...
    'overall_resting_positive', ...
    'overall_resting_negative', ...
    'overall_resting_myself', ...
    'overall_resting_others', ...
    'overall_resting_imagery', ...
    'overall_resting_present', ...
    'overall_resting_past', ...
    'overall_resting_future', ...
    'overall_resting_bitter_int', ...
    'overall_resting_bitter_unp', ...
    'overall_resting_capsai_int', ...
    'overall_resting_capsai_unp', ...
    'overall_thermal_int', ...
    'overall_thermal_unp', ...
    'overall_pressure_int', ...
    'overall_pressure_unp', ...
    'overall_negvis_int', ...
    'overall_negvis_unp', ...
    'overall_negaud_int', ...
    'overall_negaud_unp', ...
    'overall_posvis_int', ...
    'overall_posvis_ple',...
    'overall_mood', ...
    'overall_comfortness', ...
    'overall_avoidance_semicircular'
    };
rating_types.prompts = ...
    {'���� �������� ������ ���⸦ ���������� ������ �ֽʽÿ�.', ...
    'Please rate HOW MUCH you want to avoid this stimuli in the future CONTINUOUSLY.', ...
    'Please rate HOW MUCH you want to avoid this stimuli in the future CONTINUOUSLY.', ...
    'HOW MUCH pressure was applied?', ...
    'Please rate HOW MUCH you want to avoid this experience in the future?', ...
    'Please rate the overall unpleasantness you experienced.', ...
    'Was it aversive?',...
    'Was it painful?', ...
    'During the last scan how bored were you?', ...
    'During the last scan how sleepy vs. alert were you?', ...
    'How relaxed are you feeling right now?',...
    'How well could you keep your attention on the task during the last scan?',...
    'The thoughts I experienced during the last scan were POSITIVE.', ...
    'The thoughts I experienced during the last scan were NEGATIVE.', ...
    {'The thoughts I experienced during the last scan', 'were related to myself.'}, ...
    {'The thoughts I experienced during the last scan', 'involved, or concerned, other people.'}, ...
    {'The thoughts I experienced during the last scan', 'were experienced with clear and vivid mental imagery.'},...
    {'The thoughts I experienced during the last scan', 'pertained to the immediate PRESENT (the here and now).'},...
    {'The thoughts I experienced during the last scan', 'pertained to the PAST.'},...
    {'The thoughts I experienced during the last scan', 'pertained to the FUTURE.'},...
    {'At its WORST,', 'HOW INTENSE was the bitter taste you experienced?'}, ...
    {'At its WORST,', 'HOW UNPLEASANT was the burning sensation you experienced?'}, ...
    {'At its WORST,', 'HOW INTENSE was the bitter taste you experienced?'}, ...
    {'At its WORST,', 'HOW UNPLEASANT was the burning sensation you experienced?'}, ...
    'HOW INTENSE was the WORST heat you experienced during the last scan?', ...
    'HOW UNPLEASANT was the WORST heat you experienced during the last scan?', ...
    'HOW INTENSE was the WORST pressure you experienced during the last scan?', ...
    'HOW UNPLEASANT was the WORST pressure you experienced during the last scan?', ...
    'HOW INTENSE was the WORST picture you experienced during the last scan?', ...
    'HOW UNPLEASANT was the WORST picture you experienced during the last scan?', ...
    'HOW INTENSE was the WORST sound you experienced during the last scan?', ...
    'HOW UNPLEASANT was the WORST sound you experienced during the last scan?', ...
    'HOW INTENSE was the BEST picture you viewed during the last scan?', ...
    'HOW PLEASANT was the BEST picture you viewed during the last scan?',...
    'During the last scan, how was your mood?', ...
    'How comfortable are you right now?',...
    '�󸶳� ���ϰ� ��������?'
    };

end