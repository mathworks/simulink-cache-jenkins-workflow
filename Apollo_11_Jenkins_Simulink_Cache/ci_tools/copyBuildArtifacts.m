function copyBuildArtifacts(buildNum)
% This script copies all archived build artifacts from the specified 
% Jenkins build number to the current directory. 
%
% copyBuildArtifacts('4') copies the files from the '4' directory
% of the Jenkins build that corresponds to build # 4.
%
% Copyright 2021-2022 The MathWorks, Inc.

    % create a temp dir
    tmpDirName = tempname();
    mkdir(tmpDirName);
    oc1 = onCleanup(@()rmdir(tmpDirName, 's'));

    % name of the zip file on path
    zipName = 'archive.zip';
    zipFile = fullfile(tmpDirName, zipName);

    % fetch zipped slxc files from jenkins build archive
    attrib = getJenkinsAttributes();
    job_url = getJenkinsJobURL(buildNum);  
    slxcUrl = sprintf("%s/%s/artifact/*zip*/archive.zip", job_url, buildNum);
    options = weboptions('HeaderFields',{'Authorization',...
    ['Basic ' matlab.net.base64encode([attrib.userid ':' attrib.token])]});

    fprintf('Syncing archived artifacts from build %s\n', buildNum);
    websave(zipFile, slxcUrl, options);

    curProj = currentProject;
    unzip(zipFile, tmpDirName);
    copyfile(fullfile(tmpDirName, 'archive', '*'), curProj.RootFolder);
    fprintf('Sync complete: SUCCESS\n');
end
