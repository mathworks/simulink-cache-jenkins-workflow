function selection = getBuildSelection(builds)
%getBuildSelection
% This script prompts the user to select a build out of multiple choices
% and returns the selected build.
%
% Copyright 2021 The MathWorks, Inc.

    prompt = '';
    options = '0';
    prompt = sprintf('%s0. Cancel selection\n', prompt); 
    for i = 1:length(builds)
        prompt = sprintf('%s%d. Build number %s\n', prompt, i, builds{i});
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
    result = (x < 0 || x > length(builds));
end