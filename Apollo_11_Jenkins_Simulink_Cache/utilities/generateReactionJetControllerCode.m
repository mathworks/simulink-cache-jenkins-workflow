function generateReactionJetControllerCode()
% GENERATEFLIGHTCODE generates code for Reaction Jet Controller. 
% It requires Simulink Coder (TM).

% Copyright 2021 The MathWorks, Inc.

model = 'ReactionJetControl';
open_system(model);
rtwbuild(model);