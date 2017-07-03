function data = get_overallratings(overall_types, data, rating_types, run_i, tr_i, varargin)

% data = get_overallratings(overall_types, data, rating_types, run_i, tr_i)

global theWindow W H; % window property
global white red orange bgcolor; % color
global window_rect prompt_ex tb bb lb rb scale_H anchor_y anchor_y2 anchor promptW promptH joy_speed; % rating scale

use_joystick = false;
use_mouse = false;
time_for_rating = 7;

for i = 1:length(varargin)
    if ischar(varargin{i})
        switch varargin{i}
            % functional commands
            case {'joystick'}
                use_joystick = true;
            case {'mouse', 'trackball'}
                use_mouse = true;
            case {'time_for_rating'}
                time_for_rating = varargin{i+1};
        end
    end
end

eval(['start_t = data.dat{run_i}{tr_i}.' overall_types '_timestamp;']);
Screen(theWindow,'FillRect',bgcolor, window_rect);
Screen('Flip', theWindow);

start_center = strcmp(overall_types, 'overall_aversive_ornot') || ...
    strcmp(overall_types, 'overall_pain_ornot') || ...
    strcmp(overall_types, 'overall_alertness') || ...
    strcmp(overall_types, 'overall_resting_positive') || ...
    strcmp(overall_types, 'overall_resting_negative') || ...
    strcmp(overall_types, 'overall_resting_myself') || ...
    strcmp(overall_types, 'overall_resting_others') || ...
    strcmp(overall_types, 'overall_resting_imagery') || ...
    strcmp(overall_types, 'overall_resting_present') || ...
    strcmp(overall_types, 'overall_resting_past') || ...
    strcmp(overall_types, 'overall_resting_future');

semicircular = strcmp(overall_types, 'overall_avoidance_semicircular');
cir_center = [(rb+lb)/2, bb];

if semicircular
    time_for_rating = 12;
end

if start_center || semicircular
    SetMouse(cir_center(1), cir_center(2)); % set mouse at the center
    lb2 = W/3; rb2 = (W*2)/3; % new bound for or not
else
    SetMouse(lb,H/2); % set mouse at the left
end

if use_joystick
    
    SetMouse(0,0); % send the mouse to (0,0)
    
    [joy_pos, joy_button] = mat_joy(0);
    
    if joy_pos(1) < .1 % make the starting point as 0,0
        start_joy_pos = joy_pos(1);
        start_joy_pos_y = joy_pos(2);
    else
        start_joy_pos = 0;
        start_joy_pos_y = 0;
    end
end

rec_i = 0;
i = strcmp(rating_types.alltypes, overall_types);

while (1) % button
    rec_i = rec_i+1;
   
    if use_joystick
        [joy_pos, joy_button] = mat_joy(0);
        
        if ornot
            x = (joy_pos(1)-start_joy_pos) ./ joy_speed .* (rb2-lb2) + (rb2+lb2)/2; % both direction
        elseif circular
            x = (joy_pos(1)-start_joy_pos) ./ joy_speed .* (rb-lb) + (rb+lb)/2; % only right direction
            y = (joy_pos(2)-start_joy_pos_y) ./ joy_speed .* (bb-tb) + tb; % only right direction
        else
            x = (joy_pos(1)-start_joy_pos) ./ joy_speed .* (rb-lb) + lb; % only right direction
        end
    elseif use_mouse
        [x,y,button] = GetMouse(theWindow);
    end
        
    
    if ornot
        
        if x < lb2
            x = lb2;
        elseif x > rb2
            x = rb2;
        end
        
    elseif circular
        % if the point goes further than the semi-circle, move the point to
        % the closest point
        cir_center = [(rb+lb)/2, bb];
        radius = (rb-lb)/2; % radius
        theta = atan2(y,x);
        
        % send to diameter of semi-circle
        if y < bb
            y = bb;
        end
        
        % send to arc of semi-circle
        if sqrt((x-cir_center(1))^2+ (y-cir_center(2))^2) < radius
            x = radius*cos(theta)+cir_center(1);
            y = radius*sin(theta)+cir_center(2);
        end
        
        % current euclidean distance
        curr_r = sqrt((x-cir_center(1))^2+ (y-cir_center(2))^2);
        
        % current angle (0 - 180 deg)
        curr_theta = rad2deg(-theta+pi);
        
    else
        if x < lb
            x = lb;
        elseif x > rb
            x = rb;
        end
    end
    
    % button press, then break
    
    if use_joystick
        if joy_button(1), break, end
    elseif use_mouse
        if button(1), break, end
    end 
    
    % show instruction and the current position
    
    Screen('DrawText', theWindow, rating_types.prompts{i}, W/2-promptW{i}/2,H/2-promptH/2-150,white);
    draw_scale(overall_types); % draw scale
    if circular
        Screen('DrawDots', theWindow, [x y], 7, orange, [0 0], 1);
    else
        Screen('DrawLine', theWindow, orange, x, H/2, x, H/2+scale_H, 6);
    end
    Screen('Flip', theWindow);
    
    % collect the rating data and RT (x, y, r, theta) for time t
    cur_t = GetSecs;
    eval(['data.dat{run_i}{tr_i}.' overall_types '_time_fromstart(rec_i,1) = cur_t-start_t;']);
    
    if circular
        eval(['data.dat{run_i}{tr_i}.' overall_types '_cont_rating_xy(rec_i,:) = [x y];']);
        eval(['data.dat{run_i}{tr_i}.' overall_types '_cont_rating_r_theta(rec_i,:) = [curr_r curr_theta];']);
    else
        eval(['data.dat{run_i}{tr_i}.' overall_types '_cont_rating(rec_i,1) = (x-lb)./(rb-lb);']);
    end
    
    if cur_t-start_t >= time_for_rating
        break
    end
    
end

end_t = GetSecs;

% Freeze the screen 0.5 second with red line

draw_scale(overall_types); % draw scale
Screen('DrawText', theWindow, rating_types.prompts{i}, W/2-promptW{i}/2,H/2-promptH/2-150,white);

if circular
    Screen('DrawDots', theWindow, [x y], 7, red, [0 0], 1);
else
    Screen('DrawLine', theWindow, red, x, H/2, x, H/2+scale_H, 6);
end

Screen('Flip', theWindow);
WaitSecs(0.5);

% Collect the final rating data and RT (x, y, r, theta)

if circular
    eval(['data.dat{run_i}{tr_i}.' overall_types '_rating_xy = [x y];']);
    eval(['data.dat{run_i}{tr_i}.' overall_types '_rating_r_theta = [curr_r curr_theta];']);
else
    eval(['data.dat{run_i}{tr_i}.' overall_types '_rating = (x-lb)./(rb-lb);']);
end
eval(['data.dat{run_i}{tr_i}.' overall_types '_RT = end_t-start_t;']);

end