function cleanupWorkFolder()
%cleanupWorkFolder
% Delete all files from Work folder
%
% Copyright 2021 The MathWorks, Inc.

    cfg = Simulink.fileGenControl('getConfig');
    clear mex; %#ok<*CLMEX>
    pause(1);
    loc_DeleteFromFolder(cfg.CacheFolder);
    loc_DeleteFromFolder(cfg.CodeGenFolder);
end

function loc_DeleteFromFolder(aFolder)
    filesToSearch = fullfile(aFolder, '*');
    files = dir(filesToSearch);
    for index = 1:length(files)
        aFile = files(index);
        if ~any(strcmp(aFile.name, {'..', '.'}))
            fullName = fullfile(aFile.folder, aFile.name);
            if aFile.isdir
                rmdir(fullName, 's');
            else
                delete(fullName);
            end
        end
    end
end