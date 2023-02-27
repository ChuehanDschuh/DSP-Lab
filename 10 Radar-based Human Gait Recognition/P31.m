clc;clear;close all;

tStart = 0;
tStop = 3.04;
fs = 1000;
fc = 100;
alpha = 50;
beta = 1.5;
gamma = pi/3;
A = 1;

x = genFMsignal(A, alpha, beta, gamma, fc, fs, tStart, tStop);

figure;
plot(tStart:1/fs:tStop, x);axis([0 3.041 -1 1]);
xlabel('Time (s)');ylabel('Amplitude');

Ts = 24;
K = 256;
L = 128;
S = 10*log10(abs(calc_STFT(x,hamming(L),Ts,K)).^2);

t_plot = (0:(size(S,2)-1)*Ts+L)/fs;
f_plot = (-1)*linspace(-1/2,0,K/2)*fs;


figure;
imagesc(t_plot, f_plot, S(1:K/2,:));
xlabel('Time (s)');ylabel('Frequency (Hz)');c = colorbar;c.Label.String = 'Power/frequency (dB/Hz)';
set(gca,'YDir','normal');




