function result = getCurrentGitHash()
%getCurrentGitHash
% Returns the current Git commit hash as a string
%
% Copyright 2021 The MathWorks, Inc.

    gitCloneHash = evalc('!git show --format="%H" --no-patch');
    result = regexprep(gitCloneHash, '\s*', '');
end