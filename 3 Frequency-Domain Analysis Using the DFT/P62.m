clc;clear;close all;

%% Q1

N = 32;
M = 32*N;
n = 0:N-1;
x = 0.8*sin(0.2*pi*n);


[X_dtft, w] = dtft(x,M);
X_dtft = X_dtft(1:M/2+1);

X_dfft = fft(x,M);
X_dfft = X_dfft(1:M/2+1);

figure;%dft
plot(w,20*log10(abs(X_dtft)));xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');
figure;%fft
plot(w,20*log10(abs(X_dfft)));xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');


%% Q2

L = 36;
R = 16*L;
win1 = rectwin(L)';
win2 = bartlett(L)';
win3 = hamming(L)';

[win1_dtft, w1] = dtft(win1,R);
[win2_dtft, w2] = dtft(win2,R);
[win3_dtft, w3] = dtft(win3,R);

win1_dtft = 20*log10(abs(win1_dtft(1:R/2+1)));
win2_dtft = 20*log10(abs(win2_dtft(1:R/2+1)));
win3_dtft = 20*log10(abs(win3_dtft(1:R/2+1)));

%{
figure;
subplot(1,2,1);
plot(win1);grid on;axis([1 L 0 1.1]);
xlabel('Samples');ylabel('Amplitude');axis square;
subplot(1,2,2);
plot(w1,20*log10(abs(win1_dtft)));grid on;axis([w1(1) w1(end) -30 40]);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');axis square;

figure;
subplot(1,2,1);
plot(win2);grid on;axis([1 L 0 1.1]);
xlabel('Samples');ylabel('Amplitude');axis square;
subplot(1,2,2);
plot(w2,20*log10(abs(win2_dtft)));grid on;axis([w1(1) w1(end) -30 40]);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');axis square;

figure;
subplot(1,2,1);
plot(win3);grid on;axis([1 L 0 1.1]);
xlabel('Samples');ylabel('Amplitude');axis square;
subplot(1,2,2);
plot(w3,20*log10(abs(win3_dtft)));grid on;axis([w1(1) w1(end) -30 40]);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');axis square;
%}

figure;
% subplot(1,3,1);
plot(w1,win1_dtft);grid on;axis([w1(1) w1(end) -30 40]);title('Rectangular Window');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');axis square;
figure;
% subplot(1,3,2);
plot(w2,win2_dtft);grid on;axis([w1(1) w1(end) -40 30]);title('Bartlett Window');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');axis square;
figure;
% subplot(1,3,3);
plot(w3,win3_dtft);grid on;axis([w1(1) w1(end) -40 30]);title('Hamming Window');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');axis square;


%% Q3

N = 32;
M = 16*N;
n = 0:N-1;
s = cos(0.2*pi*n);
win = bartlett(N)';

y = s.*win;

[y_dtft, w_y] = dtft(y,M);
y_dtft = y_dtft(1:M/2+1);


win_modn = win.*exp(1j*0.2*pi*n);
WIN_modn = fft(win_modn,M);
WIN_modn = WIN_modn(1:M/2+1);

win_modp = win.*exp(-1j*0.2*pi*n);
WIN_modp = fft(win_modp,M);
WIN_modp = WIN_modp(1:M/2+1);

WIN_mod = (WIN_modp+WIN_modn)/2;

figure;
plot(w_y,20*log10(abs(y_dtft)));xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');
figure;
plot(w_y,20*log10(abs(WIN_mod)));xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');

%% Q4
N = 64;
M = 16*N;
n = 0:N-1;
alpha = 0.65;
x = cos(0.2*pi*n) + cos((0.2*pi+2*pi*alpha/N)*n);

window1 = rectwin(N);
window2 = hamming(N);
x1 = x.*window1';
x2 = x.*window2';
[X1, w_x1] = dtft(x1,M);
[X2, w_x2] = dtft(x2,M);

X1 = X1(1:M/2+1);
X2 = X2(1:M/2+1);


figure;
s1 = plot(w_x1,20*log10(abs(X1)));hold on;s1.Color = "#501d8a";
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');title('Rectangular window');

alpha = 0.75;
x = cos(0.2*pi*n) + cos((0.2*pi+2*pi*alpha/N)*n);
x1 = x.*window1';
[X1, w_x1] = dtft(x1,M);
X1 = X1(1:M/2+1);
s2 = plot(w_x1,20*log10(abs(X1)));s2.Color = "#1c8041";

alpha = 0.85;
x = cos(0.2*pi*n) + cos((0.2*pi+2*pi*alpha/N)*n);
x1 = x.*window1';
[X1, w_x1] = dtft(x1,M);
X1 = X1(1:M/2+1);
s3 = plot(w_x1,20*log10(abs(X1)));s3.Color = "#e55709";
legend('\alpha=0.65','\alpha=0.75','\alpha=0.85');

%{
figure;
s1 = plot(w_x2,20*log10(abs(X2)));hold on;s1.Color = "#501d8a";
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');title('Hamming window');

alpha = 0.85;
x = cos(0.2*pi*n) + cos((0.2*pi+2*pi*alpha/N)*n);
x2 = x.*window2';
[X2, w_x2] = dtft(x2,M);
X2 = X2(1:M/2+1);
s2 = plot(w_x2,20*log10(abs(X2)));s2.Color = "#1c8041";

alpha = 0.95;
x = cos(0.2*pi*n) + cos((0.2*pi+2*pi*alpha/N)*n);
x2 = x.*window2';
[X2, w_x2] = dtft(x2,M);
X2 = X2(1:M/2+1);
s3 = plot(w_x2,20*log10(abs(X2)));s3.Color = "#e55709";
legend('\alpha=0.75','\alpha=0.85','\alpha=0.95');
%}


