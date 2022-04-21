function dbName = getDBName()
%getDBName
% Return the full file path to the build database
%
% Copyright 2021-2022 The MathWorks, Inc.

    dbFolder = fullfile('L:', 'JenkinsProj', 'buildDB');
    dbName = fullfile(dbFolder, 'job_resultsApollo11.db');
end