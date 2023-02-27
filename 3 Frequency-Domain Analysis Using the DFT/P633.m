clc;clear;close all;

load mynumber.mat;

fs = 8000;
N = 256;
M = 16*N;

threshold = N/4;
l = length(xx)/11;
symbol_signal = zeros(l,11);
symbol_dtft = zeros(M,11);
symbol = zeros(1,11);

for i = 1:11
    symbol_signal(:,i) = xx((i-1)*l+1:i*l);
    symbol_dtft(:,i) = fft(symbol_signal(:,i),M);
    symbol(i) = dtmfcoef(symbol_dtft(:,i),threshold);
end

char(symbol)