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

%% parse the inputs
for i = 1:numel(exp_scale.inst)
    
    % first: START page
    if i == 1
        while (1) % space
            DrawFormattedText(theWindow, prompt_ex{4}, 'center', 100, white);
            DrawFormattedText(theWindow, prompt_ex{5}, 'center', 150, white);
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
        DrawFormattedText(theWindow, prompt_ex{1}, 'center', 100, orange, [], [], [], 1.2);
        DrawFormattedText(theWindow, rating_types.prompts{prompt_n}, 'center', 150, white, [], [], [], 1.2);
        Screen('Flip', theWindow);
        
        [~,~,keyCode] = KbCheck;
        if keyCode(KbName('space'))==1
            break
        elseif keyCode(KbName('q'))==1
            abort_man;
        end
    end
    
    if use_mouse
        get_overallratings(exp_scale.inst{i}, [], rating_types, [], [], 'explain_scale', prompt_ex{2}, 'mouse')
    elseif use_joystick
        get_overallratings(exp_scale.inst{i}, [], rating_types, [], [], 'explain_scale', prompt_ex{2}, 'joystick')
    end
    
    % Move to next
    if i < numel(exp_scale.inst)
        while (1) % space
            DrawFormattedText(theWindow, prompt_ex{3}, 'center', 100, orange, [], [], [], 1.2);
            if prompt_n == 1
                DrawFormattedText(theWindow, prompt_ex{6}, 'center', 150, orange, [], [], [], 1.2);
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
            DrawFormattedText(theWindow, prompt_ex{7}, 'center', 100, orange, [], [], [], 1.2);
            DrawFormattedText(theWindow, prompt_ex{8}, 'center', 150, orange, [], [], [], 1.2);
            
            if strncmp(exp_scale.inst{i}, 'cont_', 5)
                DrawFormattedText(theWindow, prompt_ex{6}, 'center', 300, orange, [], [], [], 1.2);
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
prompt_ex{1} = double('ô�� ����: �����ڰ� ��� ���� ô���� ����� ���� ���� ������ ���Դϴ� (������, �����̽��� �����ּ���).');
prompt_ex{2} = double('ô�� ����: ���� ô���� ����� ������ ������ (�¿��̵�). ������ ��ġ�� �Ŀ��� ��ư�� �����ø� �˴ϴ�.');
prompt_ex{3} = double('�� �ϼ̽��ϴ�! ���� ȭ������ ���÷��� ��ư�� �����ּ���.');

%% some additional instructions
prompt_ex{4} = double('�ȳ��ϼ���. ������ �� �����ϵ��� �ϰڽ��ϴ�. ���� ���� ô���� �����ϴ� �ͺ��� �غ��ڽ��ϴ�.');
prompt_ex{5} = double('�غ� �Ǽ����� ��ư�� �����ּ���.');
prompt_ex{6} = double('������ �� ���� ��ư�� ���������� ���� ���迡�� ���ӹ����� ������ �ÿ��� ��ư�� ������ �ʿ䰡 �����ϴ�.');
prompt_ex{7} = double('�� �ϼ̽��ϴ�! ���� ������ ��ġ�� ���� ���迡 ������ �ϰڽ��ϴ�.');
prompt_ex{8} = double('�غ� �Ǽ����� ��ư�� �����ּ���.');

end