%%
%       =========================
%               BIOPAC test
%       =========================
%
%
% * 'labjack' application must installed depend on your computer OS


%% BIOPAC: Starttime trigger (2 secs)
% send 'on' signal
if USE_BIOPAC
    bio_t = GetSecs;
    biopac_triggertime = bio_t; %BIOPAC timestamp
    BIOPAC_trigger(ljHandle, biopac_channel, 'on');
    Screen(theWindow,'FillRect',bgcolor, window_rect);
    Screen('Flip', theWindow);
    waitsec_fromstarttime(bio_t, 2); % ADJUST THIS
end

% send 'off' signal
if USE_BIOPAC
    BIOPAC_trigger(ljHandle, biopac_channel, 'off');
end
%% ====================================================================== %
%                                                                         %
%                               MAIN                                      %
%                                                                         %
% ======================================================================= %


%% BIOPAC: Endtime trigger (0.1 secs)
if USE_BIOPAC %end BIOPAC
    bio_t = GetSecs;
    biopac_endtime = bio_t;% biopac end timestamp
    BIOPAC_trigger(ljHandle, biopac_channel, 'on');
    waitsec_fromstarttime(bio_t, 0.1);
    BIOPAC_trigger(ljHandle, biopac_channel, 'off');
end
