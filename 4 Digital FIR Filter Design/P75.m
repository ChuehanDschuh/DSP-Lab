clc;clear;close all;

load noise_5insx.mat;
load speech.mat;

fs = 8192;
N = length(x_speech);

signal_0 = x_speech + x_5insx;
signal_3 = 2.*x_speech + x_5insx;

soundsc(x_speech);
% soundsc(signal_0);


%% Frequency response/Periodogram
X_speech = fft(x_speech);
X_noise = fft(x_5insx);
Signal_0 = fft(signal_0);

w = 0:2/N:1;
X_speech_plot = 20*log10(abs(X_speech(1:(N-1)/2+1)));
X_noise_plot = 20*log10(abs(X_noise(1:(N-1)/2+1)));
Signal_0_plot = 20*log10(abs(Signal_0(1:(N-1)/2+1)));

figure;
plot(w,X_speech_plot);axis([0 1 -80 60]);xline(0.034,'--r');xline(0.136,'--r');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');
figure;
plot(w,X_noise_plot);axis([0 1 -80 60]);xline(0.63,'--r');xline(0.98,'--r');
xline(0.032,'--r');xline(0,'--r');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');
figure;
plot(w,Signal_0_plot);axis([0 1 -80 60]);xline(0.63,'--r');xline(0.98,'--r');
xline(0.032,'--r');xline(0,'--r');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');


%{
%zero-centered power
p = 0:2/N:1;
X_speech_plot = abs(X_speech(1:(N-1)/2+1)).^2/(fs*N);
X_noise_plot = abs(X_noise(1:(N-1)/2+1)).^2/(fs*N);

figure;
plot(p,pow2db(X_speech_plot));grid on;ax = gca;ax.GridLineStyle = '--';
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Power/Frequency (dB/(rad/sample))');title('Periodogram');
figure;
plot(p,pow2db(X_noise_plot));grid on;ax = gca;ax.GridLineStyle = '--';axis([0 1 -160 -40]);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Power/Frequency (dB/(rad/sample))');title('Periodogram');
%}
%{
figure;
pwelch(x_speech,'power');
figure;
pwelch(x_5insx,'power');
%}


%% Filter BP1  only lp part of vocal
%Kaiser window
d_w = 0.02*pi;
A = 30;
[kwin_lp, L, ~] = kwin(d_w, A);


%lowpass1
lp1 = firlp(L, 0.02*pi);
lp_kwin1 = kwin_lp.*lp1;

M1 = 32*L;
LP_kwin1 = fft(lp_kwin1,M1);
LP_kwin1_plot = 20*log10(abs(LP_kwin1(1:M1/2+1)));
figure;
w_hp = 0:2/M1:1;
plot(w_hp,LP_kwin1_plot);


%lowpass2
lp2 = firlp(L, 0.15*pi);
lp_kwin2 = kwin_lp.*lp2;

M2 = 32*L;
LP_kwin2 = fft(lp_kwin2,M2);
LP_kwin2_plot = 20*log10(abs(LP_kwin2(1:M2/2+1)));
figure;
w_lp = 0:2/M2:1;
plot(w_lp,LP_kwin2_plot);


%bandpass
bp = lp_kwin1 - lp_kwin2;

M3 = 32*length(bp);
BP = fft(bp,M3);
BP_plot = 20*log10(abs(BP(1:M3/2+1)));
figure;
w_bp = 0:2/M3:1;
plot(w_bp,BP_plot);


%recover
y = conv(bp,signal_0);

soundsc(y);

Y = fft(y);
py = 0:2/length(y):1-1/length(y);
Y_plot = 20*log10(abs(Y(1:(length(y)-1)/2+1)));

figure;
plot(py,Y_plot);grid on;ax = gca;ax.GridLineStyle = '--';
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');


%% Filter BP2 remain hf part of vocal
%Kaiser window
d_w = 0.02*pi;
A = 30;
[kwin_lp, L, ~] = kwin(d_w, A);

figure;
stem(0:L-1,kwin_lp);axis([0 L-1 0 1]);xlabel('n');ylabel('w_k(n)');


%lowpass1
lp1 = firlp(L, 0.02*pi);
lp_kwin1 = kwin_lp.*lp1;

M1 = 32*L;
LP_kwin1 = fft(lp_kwin1,M1);
LP_kwin1_plot = 20*log10(abs(LP_kwin1(1:M1/2+1)));
figure;
w_hp = 0:2/M1:1;
plot(w_hp,LP_kwin1_plot);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');


%lowpass2
lp2 = firlp(L, 0.6*pi);
lp_kwin2 = kwin_lp.*lp2;

M2 = 32*L;
LP_kwin2 = fft(lp_kwin2,M2);
LP_kwin2_plot = 20*log10(abs(LP_kwin2(1:M2/2+1)));
figure;
w_lp = 0:2/M2:1;
plot(w_lp,LP_kwin2_plot);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');


%bandpass
bp = lp_kwin1 - lp_kwin2;

M3 = 32*length(bp);
BP = fft(bp,M3);
BP_plot = 20*log10(abs(BP(1:M3/2+1)));
figure;
w_bp = 0:2/M3:1;
plot(w_bp,BP_plot);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');


%recover
y = conv(bp,signal_0);

soundsc(y);

Y = fft(y);
py = 0:2/length(y):1-1/length(y);
Y_plot = 20*log10(abs(Y(1:(length(y)-1)/2+1)));

figure;
plot(py,Y_plot);xline(0.02,'--r');xline(0.6,'--r');axis([0 1 -80 60]);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');




