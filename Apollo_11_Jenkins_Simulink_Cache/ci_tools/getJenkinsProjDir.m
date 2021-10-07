function projDir = getJenkinsProjDir()
%getJenkinsProjDir
% Return full file path to the Jenkins project directory
%
% Copyright 2021 The MathWorks, Inc.

    projDir = fullfile(getJenkinsDir(), 'Apollo11_JenkinsWorkflow');
end
