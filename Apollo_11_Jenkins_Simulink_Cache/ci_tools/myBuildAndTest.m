function myBuildAndTest
%myBuildAndTest
% This script runs an accelerator simulation of the Apollo11 top
% model and a rtwbuild of the Reaction Jet Control system and then runs all
% tests. The results of this build and test are stored in the build
% database.
%
% Copyright 2021 The MathWorks, Inc.

    buildSuccess = false;
    testSuccess = false;
    exitLevel = 1;
    try
        buildSuccess = integrate_changes();
        if buildSuccess
            projectTestResult = runProjectTests();
            testSuccess = all([projectTestResult.Passed]);
            if testSuccess
                exitLevel = 0;
            end
        end
    catch ME
        disp(getReport(ME, 'extended'));
    end
    
    storeJobResults(buildSuccess, testSuccess);
    exit(exitLevel);
end