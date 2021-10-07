function dbName = getDBName()
%getDBName
% Return the full file path to the build database
%
% Copyright 2021 The MathWorks, Inc.

    dbFolder = fullfile(getJenkinsDir(), 'buildDB');
    dbName = fullfile(dbFolder, 'job_resultsApollo11.db');
end