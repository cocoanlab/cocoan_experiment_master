function ts = generate_ts_mpa1_postscan

% [ts, exp] = generate_ts_mpa1

rng('shuffle');

%% SOUND 2 REPITITIONS
S0{1} = repmat({'AU'}, 8, 1);
S0{2} = repmat({'LV1'; 'LV2'; 'LV3'; 'LV4'}, 2, 1);
S0{3} = repmat({'0010'}, 8, 1);
S0{4} = repmat({'cont_avoidance', 'overall_aversive_ornot'}, 8, 1);
S0{5} = repmat({'0'}, 8, 1);
S0{6} = repmat({'0.1', '7'}, 8, 1);

for k = 1:numel(S0)
    for i = 1
        if k ~= 4 && k ~= 6
            temp = S0{k}(randperm(8));
            for j = 1:8
                ts{i}{j}(k) = temp(j);
            end
        elseif k == 4
            temp = S0{k}(randperm(8),:);
            for j = 1:8
                ts{i}{j}(k) = {temp(j,:)};
            end
        elseif k == 6
            temp = S0{k}(randperm(8),:);
            for j = 1:8
                ts{i}{j}(k) = temp(j,1);
                ts{i}{j}(k+1) = temp(j,2);
            end
        end
    end
end

%% PAIN 3 REPETITIONS

S1{1} = repmat({'PP'}, 12, 1);
S1{2} = repmat({'LV1'; 'LV2'; 'LV3'; 'LV4'}, 3, 1);
S1{3} = repmat({'0010'}, 12, 1);
S1{4} = repmat({'cont_avoidance', 'overall_pain_ornot'}, 12, 1);
S1{5} = repmat({'0'}, 12, 1);
S1{6} = repmat({'0.1', '7'}, 12, 1);

for k = 1:numel(S1)
    for i = 2
        if k ~= 4 && k ~= 6
            temp = S1{k}(randperm(12));
            for j = 1:12
                ts{i}{j}(k) = temp(j);
            end
        elseif k == 4
            temp = S1{k}(randperm(12),:);
            for j = 1:12
                ts{i}{j}(k) = {temp(j,:)};
            end
        elseif k == 6
            temp = S1{k}(randperm(12),:);
            for j = 1:12
                ts{i}{j}(k) = temp(j,1);
                ts{i}{j}(k+1) = temp(j,2);
            end
        end
    end
end

ts = ts([2 1]);

end