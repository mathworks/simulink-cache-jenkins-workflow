%% startup.m - Initialize variables and environment
% This script initializes variables and environment required for the model 
% to work.
%
% Copyright 2021-2022 The MathWorks, Inc.

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

% setup Microsoft Visual C++ 2017 (C) compiler
mexoptFile = fullfile(matlabroot, 'bin', 'win64','mexopts', 'msvc2017.xml');
mexopt = sprintf('-setup:%s', mexoptFile);
mex(mexopt,'C');