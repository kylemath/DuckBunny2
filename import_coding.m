%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: M:\Data\DuckBunny2\OData\DuckBunny2_Cody_CodingData_done.xlsx
%    Worksheet: Sheet1
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2016/05/26 20:54:39

%% Import the data
[~, ~, raw] = xlsread('M:\Data\DuckBunny2\OData\DuckBunny2_Cody_CodingData_done.xlsx','Sheet1');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[2,3]);
raw = raw(:,[1,4]);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Allocate imported array to column variable names
stud_id = data(:,1);
Cond = cellVectors(:,1);
q2a = cellVectors(:,2);
Spont = data(:,2);

%% Clear temporary variables
clearvars data raw cellVectors R;