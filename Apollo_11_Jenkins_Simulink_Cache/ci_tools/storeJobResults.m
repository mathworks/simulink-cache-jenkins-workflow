function storeJobResults(buildSuccess, testSuccess)
%storeJobResults
% This script stores the build results and associated info in the build 
% database.
%
% Copyright 2021 The MathWorks, Inc.

    dbName = getDBName();
    tableName = 'jobResults';
    if isfile(dbName)
        mode = 'connect';
        conn = sqlite(dbName, mode);
    else
        mode = 'create';
        conn = sqlite(dbName, mode);
        createTable = ['create table ' tableName ' (' ...
                       strjoin(loc_getTableColumnNames(), ' VARCHAR, ') ...
                       ' VARCHAR)'];
        exec(conn, createTable);
    end
    cols = loc_getTableColumnNames();
    insert(conn, tableName, cols, loc_getValues(cols, buildSuccess, testSuccess));
    close(conn);
end

function cols = loc_getTableColumnNames()
    cols = {
        'BUILD_NUMBER' 
        'BUILD_ID' 
        'BUILD_DISPLAY_NAME'
        'JOB_NAME'
        'JOB_BASE_NAME'
        'BUILD_TAG'
        'EXECUTOR_NUMBER' 
        'NODE_NAME' 
        'NODE_LABELS'
        'WORKSPACE'
        'JENKINS_HOME'
        'JENKINS_URL'
        'BUILD_URL'
        'JOB_URL'
        'GIT_COMMIT'
        'GIT_PREVIOUS_COMMIT'
        'GIT_PREVIOUS_SUCCESSFUL_COMMIT'
        'GIT_BRANCH'
        'GIT_LOCAL_BRANCH' 
        'GIT_URL'
        'buildSuccess'
        'testSuccess'};
end

function vals = loc_getValues(cols, buildSuccess, testSuccess)
    vals = {};
    for i = 1:length(cols)-2
        vals{end+1} = getenv(cols{i}); %#ok<AGROW>
    end
    vals{end+1} = num2str(buildSuccess);
    vals{end+1} = num2str(testSuccess);
end