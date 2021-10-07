function copyBuildArtifacts(buildNum, force)
% This script copies all archived build artifacts from the specified 
% Jenkins build number to the current directory. 
%    
% copyBuildArtifacts('lastSuccessfulBuild', true) copies the files from
% the lastSuccessfulBuild directory of Jenkins build, and forces the copy
% even if the current git clone hash doesn't match the commit hash for 
% which the Jenkins build was performed. 
%
% copyBuildArtifacts('4', false) copies the files from the '4' directory
% of the Jenkins build that corresponds to build # 4 only if the 
% current git clone hash matches the commit hash for which the 
% Jenkins build was performed.
%
% Copyright 2021 The MathWorks, Inc.

    % initialize build path
    buildPath = fullfile(getJenkinsProjDir(), 'builds', buildNum);
    buildFile = fullfile(buildPath, 'build.xml');
    
    % exit if build file doesn't exist
    if ~isfile(buildFile)
        fprintf('Build "%s" doesn''t exist. No artifacts to copy to workspace.\n', buildNum);
        return;
    end
    
    gitBranchName = getCurrentGitBranch();
    % parse build xml file with MAXP Parser
    import matlab.io.xml.dom.*
    buildDoc = parseFile(Parser, buildFile);
    buildsBBN = getElementsByTagName(buildDoc, 'buildsByBranchName');
    branchEntries = getElementsByTagName(node(buildsBBN, 1), 'entry');
    % find matching branch entry
    for i = 1:branchEntries.Length
        if (contains(node(branchEntries, i).TextContent, gitBranchName))
            break;
        end
    end
    buildCommitHash = getElementsByTagName(node(branchEntries, i), 'sha1').TextContent;
    fprintf('Commit hash for build "%s": %s\n', buildNum, buildCommitHash);
    
    % get the commit hash for current git clone
    gitCloneHash = getCurrentGitHash();
    fprintf('Commit hash for current git clone: %s\n', gitCloneHash);
    
    % ensure current git clone commit hash and the one in the build are the same
    if ~strcmp(buildCommitHash, gitCloneHash)
        fprintf('Build %s commit hash and current git clone hash mismatch\n', buildNum);
        if ~force
            fprintf('Sync aborted\n');
            return;
        end
        fprintf('Continuing because force option specified\n');
    end
    
    % copy all files from build path's archive area
    archivePath = fullfile(buildPath, 'archive');
    fprintf('Syncing archived artifacts from build %s\n', buildNum);
    curProj = currentProject;
    copyfile(archivePath, curProj.RootFolder);
    fprintf('Sync complete: SUCCESS\n');
end