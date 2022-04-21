function selection = getBuildSelection(builds)
%getBuildSelection
% This script prompts the user to select a build out of multiple choices
% and returns the selected build.
%
% Copyright 2021-2022 The MathWorks, Inc.

    prompt = '';
    options = '0';
    prompt = sprintf('%s0. Cancel selection\n', prompt); 
    for i = 1:height(builds)
        if istable(builds)
            build = builds(i, 1);
            buildSel = build.(1);
        else
            buildSel = builds{i};
        end
        prompt = sprintf('%s%d. Build number %s\n', prompt, i, buildSel);
        options = sprintf('%s/%d', options, i);
    end
    prompt = sprintf('%sPlease select from the above options[%s]: ', prompt, options);
    
    x = -1;
    while loc_isSelectionInvalid(x, builds)
        x = input(prompt);
        if loc_isSelectionInvalid(x, builds)
            fprintf('\nInvalid selection.\n\n');
        end
    end
    selection = x;
end

function result = loc_isSelectionInvalid(x, builds)
    result = (x < 0 || x > height(builds));
end
