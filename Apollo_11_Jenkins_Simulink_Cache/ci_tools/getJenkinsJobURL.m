function result = getJenkinsJobURL(buildNum)
%getJenkinsJobURL
% This script returns the Jenkins Job url from the database for the given
% build number.
%
% Copyright 2022 The MathWorks, Inc.

    dbName = getDBName();
    conn = sqlite(dbName);    
    sqlquery = sprintf("SELECT JOB_URL FROM jobResults WHERE BUILD_NUMBER='%s'", buildNum);
    results = fetch(conn, sqlquery);
    if istable(results)
        result = results.(1);    
    else
        result = results{1};
    end
end
