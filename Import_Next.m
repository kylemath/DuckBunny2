function tableout = importfile(workbookFile,sheetName,startRow,endRow)
%IMPORTFILE Import data from a spreadsheet
%   DATA = IMPORTFILE(FILE) reads data from the first worksheet in the
%   Microsoft Excel spreadsheet file named FILE and returns the data as a
%   table.
%
%   DATA = IMPORTFILE(FILE,SHEET) reads from the specified worksheet.
%
%   DATA = IMPORTFILE(FILE,SHEET,STARTROW,ENDROW) reads from the specified
%   worksheet for the specified row interval(s). Specify STARTROW and
%   ENDROW as a pair of scalars or vectors of matching size for
%   dis-contiguous row intervals. To read to the end of the file specify an
%   ENDROW of inf.
%
%	Non-numeric cells are replaced with: NaN
%
% Example:
%   DuckBunny2Winter2016Next = importfile('DuckBunny2_Winter2016_Next.xlsx','Sheet1',2,1653);
%
%   See also XLSREAD.

% Auto-generated by MATLAB on 2016/05/26 20:05:09

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 3
    startRow = 2;
    endRow = 1653;
end

%% Import the data, extracting spreadsheet dates in Excel serial date format
[~, ~, raw, dates] = xlsread(workbookFile, sheetName, sprintf('A%d:AF%d',startRow(1),endRow(1)),'' , @convertSpreadsheetExcelDates);
for block=2:length(startRow)
    [~, ~, tmpRawBlock,tmpDateNumBlock] = xlsread(workbookFile, sheetName, sprintf('A%d:AF%d',startRow(block),endRow(block)),'' , @convertSpreadsheetExcelDates);
    raw = [raw;tmpRawBlock]; %#ok<AGROW>
    dates = [dates;tmpDateNumBlock]; %#ok<AGROW>
end
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2,13,14,17,21,23,27,29]);
raw = raw(:,[3,4,6,7,8,9,10,11,12,15,16,18,19,20,22,24,25,26,28,30,31,32]);
dates = dates(:,5);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),dates); % Find non-numeric cells
dates(R) = {NaN}; % Replace non-numeric Excel dates with NaN

%% Create output variable
I = cellfun(@(x) ischar(x), raw);
raw(I) = {NaN};
data = reshape([raw{:}],size(raw));

%% Create table
tableout = table;

%% Allocate imported array to column variable names
tableout.stud_id = cellVectors(:,1);
tableout.course = cellVectors(:,2);
tableout.gender = data(:,1);
tableout.age = data(:,2);
dates(~cellfun(@(x) isnumeric(x) || islogical(x), dates)) = {NaN};
tableout.birth = datetime([dates{:,1}].', 'ConvertFrom', 'Excel', 'Format', 'dd/MM/yyyy');
tableout.inches = data(:,3);
tableout.cm = data(:,4);
tableout.pounds = data(:,5);
tableout.kg = data(:,6);
tableout.edu = data(:,7);
tableout.ethnic = data(:,8);
tableout.english = data(:,9);
tableout.eng_other = cellVectors(:,3);
tableout.eng_lang_other = cellVectors(:,4);
tableout.lang_after_english = data(:,10);
tableout.born_canada = data(:,11);
tableout.born_country = cellVectors(:,5);
tableout.arrive_can = data(:,12);
tableout.years_can = data(:,13);
tableout.status = data(:,14);
tableout.status_other = cellVectors(:,6);
tableout.colour = data(:,15);
tableout.colour_other = cellVectors(:,7);
tableout.glasses = data(:,16);
tableout.mobility = data(:,17);
tableout.faculty = data(:,18);
tableout.faculty_other = cellVectors(:,8);
tableout.q1a = data(:,19);
tableout.q2a = cellVectors(:,9);
tableout.q2b = data(:,20);
tableout.q2c = data(:,21);
tableout.q3a = data(:,22);

% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% tableout.birth=datenum(tableout.birth);

