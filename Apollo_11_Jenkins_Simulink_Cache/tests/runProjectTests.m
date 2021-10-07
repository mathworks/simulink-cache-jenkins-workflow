function results = runProjectTests()
%runProjectTests.m - Run project tests
% This file runs all the tests registered in the the project. To
% differentiate actual tests from helper files, the test file should have a
% "Test" classification in the project.
%
% Copyright 2013-2021 The MathWorks.Inc.

% Get current project directory
p = slproject.getCurrentProject;
% Allocate empty string array with max size
testList = repmat("",length(p.Files),1);
for k=1:length(p.Files)
    if ~isempty(p.Files(k).findLabel('Classification','Test'))
        testList(k) = p.Files(k).Path;
    end
end
% Trim array to non-empty strings
testList = testList(~strcmp(testList, ""));
results = runtests(testList);