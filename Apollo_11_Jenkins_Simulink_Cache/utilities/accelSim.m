function accelSim()
%accelSim
%
% Simulate the model in Accelerator mode
%
% Copyright 2021 The MathWorks, Inc.

    topModel = 'apollo50_dap3dof';

    if(~bdIsLoaded(topModel))
        open_system(topModel);
    end
    
    id = 'Simulink:engine:UINotUpdatedDuringRapidAccelSim';
    warning('off',id);
    oc1 = onCleanup(@()warning('on', id));
    sim(topModel, 'SimulationMode', "accel");
end