%Initialize Pressure, Vibration, Temperature as 2-D array
%X-axis is the trail, Y-axis is the measuremet for different object
Pressure = zeros(6,10);
Vibration = zeros(6,10);
Temperature = zeros(6,10);
Electrodes = zeros(6,10);

%Refer to all data files
data_files = dir('*.mat');

%Define time instance
time = 250;

%Iterate all data files to store values
for i = 1:length(data_files)
    filename = data_files(i).name;
    loadedData = load(filename);
    %Calculate row and column index to make sure the values are stored in
    %the 6*10 matrix
    row_index = fix((i-1)/10);
    column_index = mod(i-1,10);
    %Store Pressure Measurement
    Pressure(row_index+1,column_index+1) = loadedData.F0pdc(1,time);
    %Store Vibration Measurement
    Vibration(row_index+1,column_index+1) = loadedData.F0pac(2,time);
    %Store Temperature Measurement
    Temperature(row_index+1,column_index+1) = loadedData.F0tdc(1,time);
    %Store Electrodes Measurement
    Electrodes(row_index+1,column_index+1) = loadedData.F0Electrodes(1,time);
end

% Define the directory and filename
targetDirectory = 'Lab1'; % Change this to your desired path

% Check if the directory exists, and if not, create it
if ~exist(targetDirectory, 'dir')
    mkdir(targetDirectory);
end

% Define the full path to the file
PVT_file = fullfile(targetDirectory, 'F0_PVT.mat');
Electrodes_file = fullfile(targetDirectory, 'F0_Electrodes.mat');

% Save the data to the .mat file at the specified location
save(PVT_file, 'Pressure','Vibration','Temperature');
save(Electrodes_file,'Electrodes');

