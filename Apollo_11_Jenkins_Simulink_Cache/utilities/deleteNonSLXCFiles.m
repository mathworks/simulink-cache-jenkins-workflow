function deleteNonSLXCFiles
%deleteNonSLXCFiles
% Delete all non-SLXC (Simulink Cache) files from Work folder
%
% Copyright 2021 The MathWorks, Inc.

    cfg = Simulink.fileGenControl('getConfig');
    clear mex;
    pause(1);
    loc_DeleteNonSLXCFromFolder(cfg.CacheFolder);
    loc_DeleteNonSLXCFromFolder(cfg.CodeGenFolder);
end

function loc_DeleteNonSLXCFromFolder(aFolder)
    filesToSearch = fullfile(aFolder, '*');
    files = dir(filesToSearch);
    for index = 1:length(files)
        aFile = files(index);
        if ~any(strcmp(aFile.name, {'..', '.'}))
            fullName = fullfile(aFile.folder, aFile.name);
            if aFile.isdir
                rmdir(fullName, 's');
            elseif ~endsWith(aFile.name, '.slxc')
                delete(fullName);
            end
        end
    end
end