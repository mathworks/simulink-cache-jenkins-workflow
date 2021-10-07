function result = getCurrentGitBranch()
%getCurrentGitBranch
% Returns the current Git commit branch as a string
%
% Copyright 2021 The MathWorks, Inc.

    gitBranchName = evalc('!git branch --show-current');
    result = regexprep(gitBranchName, '\s*', '');
end