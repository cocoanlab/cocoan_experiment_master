function ts = generate_ts_cps

% [ts, exp] = generate_ts_mpa1

rng('shuffle');

%% RUN 1-4
S1{1} = repmat({'PP'; 'AU'}, 8, 1);
S1{2} = repmat({'LV1'; 'LV2'; 'LV3'; 'LV4'}, 4, 1);
S1{3} = repmat({'0010'}, 16, 1);
S1{4} = repmat({'overall_avoidance'}, 16, 1);
S1{5} = repmat({'0'}, 16, 1);
S1{6} = repmat({'3', '11'; '5', '9'; '7', '7'}, 6, 1);

trial_n = 16;

for k = 1:numel(S1)
    for i = 1:4
        temp = S1{k}(randperm(trial_n),:);
        switch k
            case {1, 2, 3, 5}
                for j = 1:trial_n
                    ts{i}{j}(k) = temp(j);
                end
            case 4
                for j = 1:trial_n
                    ts{i}{j}(4) = {temp(j)};
                end
            case 6
                for j = 1:trial_n
                    ts{i}{j}(6) = temp(j,1);
                    ts{i}{j}(7) = temp(j,2);
                end
        end
    end
end

end