function data = get_overallratings_joystick(overall_types, data, rating_types, run_i, tr_i)

% data = get_overallratings(overall_types, data, rating_types, run_i, tr_i)

global theWindow W H; % window property
global white red orange bgcolor; % color
global window_rect prompt_ex lb rb scale_W anchor_y anchor_y2 anchor promptW promptH joy_speed; % rating scale

eval(['start_t = data.dat{run_i}{tr_i}.' overall_types '_timestamp;']);
Screen(theWindow,'FillRect',bgcolor, window_rect);
Screen('Flip', theWindow);

ornot = strcmp(overall_types, 'overall_aversive_ornot') || strcmp(overall_types, 'overall_pain_ornot');

[joy_pos, joy_button] = mat_joy(0);

if joy_pos(1) < .1
    start_joy_pos = joy_pos(1);
else
    start_joy_pos = 0;
end

rec_i = 0;
i = strcmp(rating_types.alltypes, overall_types);

while (1) % button
    rec_i = rec_i+1;
   
    %[x,~,button] = GetMouse(theWindow);
    [joy_pos, joy_button] = mat_joy(0);
    
    if ornot
        x = (joy_pos(1)-start_joy_pos) ./ joy_speed .* (rb2-lb2) + (rb2+lb2)/2; % both direction
    else
        x = (joy_pos(1)-start_joy_pos) ./ joy_speed .* (rb-lb) + lb; % only right direction
    end
        
    if ornot
        if x < lb2
            x = lb2;
        elseif x > rb2
            x = rb2;
        end
    else
        if x < lb
            x = lb;
        elseif x > rb
            x = rb;
        end
    end
    
    if joy_button(1), break, end
    
    Screen('DrawText', theWindow, rating_types.prompts{i}, W/2-promptW{i}/2,H/2-promptH/2-150,white);
    draw_scale(overall_types); % draw scale
    Screen('DrawLine', theWindow, orange, x, H/2, x, H/2+scale_W, 6);
    Screen('Flip', theWindow);
        
    cur_t = GetSecs;
    eval(['data.dat{run_i}{tr_i}.' overall_types '_time_fromstart(rec_i,1) = cur_t-start_t;']);
    eval(['data.dat{run_i}{tr_i}.' overall_types '_cont_rating(rec_i,1) = (x-lb)./(rb-lb);']);
    
    if cur_t-start_t >= 7
        break
    end
    
end

end_t = GetSecs;

% freeze the screen 0.5 second with red line
draw_scale(overall_types); % draw scale
Screen('DrawText', theWindow, rating_types.prompts{i}, W/2-promptW{i}/2,H/2-promptH/2-150,white);
Screen('DrawLine', theWindow, red, x, H/2, x, H/2+scale_W, 6);
Screen('Flip', theWindow);
WaitSecs(0.5);

eval(['data.dat{run_i}{tr_i}.' overall_types '_rating = (x-lb)./(rb-lb);']);
eval(['data.dat{run_i}{tr_i}.' overall_types '_RT = end_t-start_t;']);

end