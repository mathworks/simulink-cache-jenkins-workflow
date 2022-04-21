function copySLXCFilesFromJenkins()
%copySLXCFilesFromJenkins
% This script accesses the SQLite build database and queries for the successful
% builds that match the current commit hash, and then copies the build artifacts
% from the corresponding archive
%
% Copyright 2021-2022 The MathWorks, Inc.

    dbName = getDBName();
    conn = sqlite(dbName);
    gitHash = getCurrentGitHash();
    fprintf('Querying successful jobs in database for git commit %s...\n', ...
        gitHash);
    sqlquery = sprintf("SELECT BUILD_NUMBER FROM jobResults WHERE GIT_COMMIT='%s' AND buildSuccess='1' AND testSuccess='1'", gitHash);
    results = fetch(conn, sqlquery);
    if isempty(results)
        fprintf('No jenkins build found corresponding to Git commit: %s\n', ...
            gitHash);
        return;
    end
    
    if height(results) == 1
        if istable(results)
            copyBuildArtifacts(results.(1));
        else
            copyBuildArtifacts(results{1});
        end
    else
        fprintf('Found multiple Jenkins builds for git commit:\n');
        selection = getBuildSelection(results);
        if (selection == 0)
            fprintf('Aborting sync on user request.\n');
            return;
        else
            if istable(results)
                copyBuildArtifacts(results(1,selection).(1));
            else
                copyBuildArtifacts(results{selection});
            end
        end
    end
end
