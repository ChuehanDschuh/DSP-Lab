function [x,fs,T] = read_radar_data(filename)   
% reads radar data given the filename, e.g. [x,fs,T] = read_radar_data('14exp48.dat');   
% OUTPUT:
%   x : time domain signal 
%   fs: sampling frequency
%   T : measurement duration

    fid = fopen(filename,'r');
    dataArray = textscan(fid, '%f');
    fclose(fid);
    
    radarData = dataArray{1};
    clearvars fileID dataArray ans;
    fc = radarData(1);          % Center frequency
    Tsweep = radarData(2);      % Sweep time in ms
    NTS = radarData(3);         % Number of time samples per sweep
    Bw = radarData(4);          % FMCW Bandwidth. For FSK, it is frequency step;
                                % For CW, it is 0.
    Data = radarData(5:end);    % raw data in I+j*Q format
    
    % Sampling rate
    samp_rate = 1/Tsweep*NTS*1000;
    fs = samp_rate;

    % DC Subtraction
    Data = Data - mean(Data);   % Doppler data

    % Subsampling applying lowpass filtering   
    dsf = 5;
    x = decimate(Data,dsf);    
    fs = fs/dsf;
    
    dt = 1/fs;
    T  = length(x)/fs;          % measurement duration
    t  = 0:dt:T-dt;             % define time vector
end