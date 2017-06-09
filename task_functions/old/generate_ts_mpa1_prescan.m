function ts = generate_ts_mpa1_prescan

% [ts, exp] = generate_ts_mpa1

rng('shuffle');

%% RUN 1-4
S1{1} = repmat({'PP'}, 4, 1);
S1{2} = repmat({'LV1'; 'LV2'; 'LV3'; 'LV4'}, 1, 1);
S1{3} = repmat({'0010'}, 4, 1);
S1{4} = repmat({'overall_int'}, 4, 1);
S1{5} = repmat({'0'}, 4, 1);
S1{6} = repmat({'0.1', '7'}, 4, 1);

for k = 1:numel(S1)
    for i = 1:2
        if k ~= 4 && k ~= 6
            if i == 1
                temp = S1{k};
            else
                temp = S1{k}(randperm(4));
            end
            
            for j = 1:4
                ts{i}{j}(k) = temp(j);
            end
            
        elseif k == 4
            temp = S1{k}(randperm(4));
            for j = 1:4
                ts{i}{j}(k) = {temp(j)};
            end
        elseif k == 6
            temp = S1{k}(randperm(4),:);
            for j = 1:4
                ts{i}{j}(k) = temp(j,1);
                ts{i}{j}(k+1) = temp(j,2);
            end
        end
    end
end

end