clc;clear;close all;


fs = 8000;
N = 256;
M = 16*N;
s_7 = dtmfdial('7',fs);%signal for 7
S_7 = fft(s_7,M);%dtft

S_7 = 20*log10(abs(S_7(1:M/2+1)));
w_7 = 0:2/M:1;

peak = islocalmax(S_7);

figure;
plot(0:1/8:(length(s_7)-1)/8,s_7);
xlabel('Time/ms');ylabel('Amplitude');

figure;
plot(w_7*fs/2,S_7);
text(300,-10,'f_1 = 852 Hz');text(1300,-10,'f_2 = 1209 Hz');
xline(852,'--r');xline(1209,'--r');
xlabel('Frequency/Hz');ylabel('Magnitude in dB');


