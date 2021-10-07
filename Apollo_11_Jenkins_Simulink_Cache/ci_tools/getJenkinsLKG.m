function lkgBuild = getJenkinsLKG()
%getJenkinsLKG
%
% Copyright 2021 The MathWorks, Inc.

    lkgBuild = -1;
    dbName = getDBName();
    conn = sqlite(dbName);
    fprintf('Querying LKG in database...\n');
    sqlquery = ['SELECT BUILD_NUMBER ' ...
                'FROM jobResults ' ...
                'WHERE buildSuccess=''1'' AND testSuccess=''1'''];
    results = fetch(conn, sqlquery);
    if isempty(results)
        fprintf('No jenkins LKG found.\n');
        return;
    end
    
    lkgBuild = max(str2double(results));
end