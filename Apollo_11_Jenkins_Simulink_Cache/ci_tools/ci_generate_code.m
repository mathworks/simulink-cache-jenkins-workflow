function ci_generate_code()
%ci_generate_code
%
% Simulates the model hierarchy in accelerator mode and generates code for
% the Reaction Jet Control system.
%
% Copyright 2021 The MathWorks, Inc.

    topModel = 'apollo50_dap3dof';

    if(~bdIsLoaded(topModel))
        open_system(topModel);
    end

    try
        startTime = tic;
        accelSim();
        generateReactionJetControllerCode();
        elapsedTime = toc(startTime);
        fprintf('\n***** Elapsed time for accelerator simulation and reaction jet controller code generation: %.3f seconds *****\n', elapsedTime);
    catch ME
        disp('Build failed. exiting.')
        rethrow(ME);
    end
end