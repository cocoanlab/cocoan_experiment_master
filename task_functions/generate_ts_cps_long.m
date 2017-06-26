function ts = generate_ts_cps_long

for i = 1:3
    
    for j = 1:20
        
        if i == 1
            ts{i}{j}(1) = {'REST'}; % randomize
        elseif i == 2
            ts{i}{j}(1) = {'CAPS'}; % 
        elseif i == 3
            ts{i}{j}(1) = {'QUIN'}; %
        end
        
        ts{i}{j}(2) = {'LV0'};
        
        if j == 1
            ts{i}{j}(3) = {'23'}; % first trial 30sec
        else
            ts{i}{j}(3) = {'53'}; % next trials 60sec
        end
        
        ts{i}{j}(4) = {{'overall_avoidance'}};
        ts{i}{j}(5) = {'0'}; % no cue time
        ts{i}{j}(6) = {'0'}; % no delay for rating
        
        if j == 20
            ts{i}{j}(7) = {'27'}; % 7 sec for ratings
        else
            ts{i}{j}(7) = {'7'}; % 7 sec for ratings
        end
    
    end

end