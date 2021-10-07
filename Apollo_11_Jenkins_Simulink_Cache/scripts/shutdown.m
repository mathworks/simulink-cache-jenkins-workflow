% shutdown
%
% Copyright 2021 The MathWorks, Inc.

% save csref if it has changed
if ~isequal(csCopy, CSRef)
    save('data/configset.mat', 'CSRef');
end
clear(initVars{:});
clear initVars;