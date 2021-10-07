%% startVars.m - Initialize variables
% This script initializes variables required for the model to
% work.
% Copyright 2021 The MathWorks, Inc.

% Register variables in the workspace before the project is loaded
initVars = who;

load configset.mat
% store a copy of the configset reference in the base workspace
csCopy = CSRef.copy();

apollo50_dap3dofdata

% Register variables after the project is loaded and store the variables in
% initVars so they can be cleared later on the project shutdown.
endVars = who;
initVars = setdiff(endVars,initVars);
clear endVars;