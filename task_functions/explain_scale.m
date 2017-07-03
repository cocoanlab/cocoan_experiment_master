function explain_scale(exp_scale, rating_types, varargin)

% EXPLAIN SCALE
% explain_scale(exp_scale)

global theWindow W H; % window property
global white red orange bgcolor; % color
global window_rect lb rb scale_H promptW promptH joy_speed; % rating scale

use_joystick = false;
use_mouse = false;

for i = 1:length(varargin)
    if ischar(varargin{i})
        switch varargin{i}
            % functional commands
            case {'joystick'}
                use_joystick = true;
            case {'mouse', 'trackball'}
                use_mouse = true;
        end
    end
end

%% Prompt setup
prompt_ex = prompt_setup; 

%% Getting widths for prompts
prompt_ex_W = cell(numel(prompt_ex),1);
for i = 1:numel(prompt_ex)
    prompt_ex_W{i} = Screen(theWindow, 'DrawText', prompt_ex{i},0,0); 
end

%% parse the inputs
for i = 1:numel(exp_scale.inst)
    
    % first: START page
    if i == 1
        while (1) % space
            Screen('DrawText',theWindow, prompt_ex{4},W/2-prompt_ex_W{4}/2, 100, white);
            Screen('DrawText',theWindow, prompt_ex{5},W/2-prompt_ex_W{5}/2, 200, white);
            Screen('Flip', theWindow);
            
            if use_joystick
                [~, joy_button] = mat_joy(0);
            elseif use_mouse
                [~,~,button] = GetMouse(theWindow);
            end
            [~,~,keyCode] = KbCheck;
            
            if use_mouse
                if button(1), break, end
            elseif use_joystick
                if joy_button(1), break, end
            end
            
            if keyCode(KbName('q'))==1
                abort_man;
            end
        end
    end
    
    % EXPLAIN
    prompt_n = strcmp(rating_types.alltypes, exp_scale.inst{i});
    while (1) % space
        draw_scale(exp_scale.inst{i}); % draw scale
        Screen('DrawText',theWindow, prompt_ex{1},W/2-prompt_ex_W{1}/2,100,orange);
        Screen('DrawText',theWindow, rating_types.prompts{prompt_n}, W/2-promptW{prompt_n}/2,H/2-promptH/2-150,white);
        Screen('Flip', theWindow);
        
        [~,~,keyCode] = KbCheck;
        if keyCode(KbName('space'))==1
            break
        elseif keyCode(KbName('q'))==1
            abort_man;
        end
    end
    
    % PRACTICE
    % Screen(theWindow,'FillRect',bgcolor, window_rect);
    % Screen('Flip', theWindow);
    
    if use_mouse
        SetMouse(lb,H/2); % set mouse at the left
    elseif use_joystick
        SetMouse(0,0); % set mouse at the left
        
        [joy_pos, joy_button] = mat_joy(0);
        
        if joy_pos(1) < .1
            start_joy_pos = joy_pos(1);
        else
            start_joy_pos = 0;
        end
    end
    
    while (1) % button
        
        if use_mouse
            [x,~,button] = GetMouse(theWindow);
        elseif use_joystick
            [joy_pos, joy_button] = mat_joy(0);
            x = (joy_pos(1)-start_joy_pos) ./ joy_speed .* (rb-lb) + lb; % only right direction
        end
        
        if x < lb
            x = lb;
        elseif x > rb
            x = rb;
        end
        
        if use_joystick
            if joy_button(1), break, end
        elseif use_mouse
            if button(1), break, end
        end
        
        draw_scale(exp_scale.inst{i}); % draw scale
        
        Screen('DrawText',theWindow, prompt_ex{1},W/2-prompt_ex_W{1}/2,100,orange);
        Screen('DrawText',theWindow, rating_types.prompts{prompt_n}, W/2-promptW{prompt_n}/2,H/2-promptH/2-150,white);
        if strncmp(exp_scale.inst{i}, 'cont_', 5)
            Screen('DrawLine', theWindow, white, x, H/2, x, H/2+scale_H, 6);
        else
            Screen('DrawLine', theWindow, orange, x, H/2, x, H/2+scale_H, 6);
        end
        Screen('Flip', theWindow);
        
    end
    
    % freeze the screen 1 second with red line
    draw_scale(exp_scale.inst{i}); % draw scale
    Screen('DrawText',theWindow, prompt_ex{1},W/2-prompt_ex_W{1}/2,100,orange);
    Screen('DrawText',theWindow, rating_types.prompts{prompt_n}, W/2-promptW{prompt_n}/2,H/2-promptH/2-150,white);
    Screen('DrawLine', theWindow, red, x, H/2, x, H/2+scale_H, 6);
    Screen('Flip', theWindow);
    WaitSecs(1);
    
    Screen(theWindow,'FillRect',bgcolor, window_rect);
    
    % Move to next
    if i < numel(exp_scale.inst)
        while (1) % space
            Screen('DrawText',theWindow, prompt_ex{3},W/2-prompt_ex_W{3}/2,100,orange);
            if prompt_n == 1
                Screen('DrawText',theWindow, prompt_ex{6},W/2-prompt_ex_W{6}/2,150,orange);
            end
            Screen('Flip', theWindow);
            
            if use_joystick
                [~, joy_button] = mat_joy(0);
            elseif use_mouse
                [~,~,button] = GetMouse(theWindow);
            end
            [~,~,keyCode] = KbCheck;
            
            if use_mouse
                if button(1), break, end
            elseif use_joystick
                if joy_button(1), break, end
            end
            
            if keyCode(KbName('q'))==1
                abort_man;
            end
            
        end
    else
        while (1) % space
            Screen('DrawText',theWindow, prompt_ex{7},W/2-prompt_ex_W{7}/2,100,orange);
            Screen('DrawText',theWindow, prompt_ex{8},W/2-prompt_ex_W{8}/2,150,orange);
            
            if strncmp(exp_scale.inst{i}, 'cont_', 5)
                Screen('DrawText',theWindow, prompt_ex{6},W/2-prompt_ex_W{6}/2,300,orange);
            end
            
            Screen('Flip', theWindow);
            
            if use_joystick
                [~, joy_button] = mat_joy(0);
            elseif use_mouse
                [~,~,button] = GetMouse(theWindow);
            end
            [~,~,keyCode] = KbCheck;
            
            if use_mouse
                if button(1), break, end
            elseif use_joystick
                if joy_button(1), break, end
            end
            
            if keyCode(KbName('q'))==1
                abort_man;
            end
            
        end
    end
end

end


function prompt_ex = prompt_setup

% prompt = prompt_setup

%% Instructions
prompt_ex{1} = '척도 연습: 실험자가 어떻게 반응 척도를 사용할 지에 대해 설명할 것입니다 (실험자, 스페이스를 눌러주세요).';
prompt_ex{2} = '척도 연습: 반응 척도의 사용을 연습해 보세요 (좌우이동). 연습을 마치신 후에는 버튼을 누르시면 됩니다.';
prompt_ex{3} = '잘 하셨습니다! 다음 화면으로 가시려면 버튼을 눌러주세요.';

%% some additional instructions
prompt_ex{4} = '안녕하세요. 실험을 곧 시작하도록 하겠습니다. 먼저 반응 척도를 연습하는 것부터 해보겠습니다.';
prompt_ex{5} = '준비가 되셨으면 버튼을 눌러주세요.';
prompt_ex{6} = '연습을 할 때는 버튼을 누르셨지만 실제 실험에서 연속반응을 보고할 시에는 버튼을 누르실 필요가 없습니다.';
prompt_ex{7} = '잘 하셨습니다! 이제 연습을 마치고 실제 실험에 들어가도록 하겠습니다.';
prompt_ex{8} = '준비가 되셨으면 버튼을 눌러주세요.';

end