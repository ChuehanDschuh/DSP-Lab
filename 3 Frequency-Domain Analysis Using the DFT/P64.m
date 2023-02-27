clc;clear;close all;

fs = 44100;
mic = [19 18 1.6];
n = 12;
r = 0.3;
rm = [20 19 21];
src = [5 2 1];

h = rir(fs,mic,n,r,rm,src);

% stem(h);

[speech, fs_speech]= audioread("speech.wav");

Lh = length(h);
Ls = length(speech);
Lm = Lh + Ls -1;

%use conv function
y = conv(speech,h);
% soundsc(y);

H = fft(h,Lm);%frequency response
Hi = 1./H;%inverse frequency response
hi = ifft(Hi);%inverse impulse response

%use fast convolution
y_recov = ifft(fft(y).*fft(hi));

% soundsc(y_recov);


figure;
plot(0:1/fs_speech:(Ls-1)/fs_speech,speech);xlabel('Time/s');ylabel('Amplitude');title('Speech Signal');
figure;
stem(h);axis([0 Lh-1 0 0.05]);title('Impulse Response');xlabel('Time lag');ylabel('Sound level');
figure;
plot(0:2/Lm:1,20*log10(abs(H(1:Lm/2+1))));title('Frequency Response');xlabel('Normalized frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');
figure;
plot(0:2/Lm:1,20*log10(abs(Hi(1:Lm/2+1))));title('Frequency Response');xlabel('Normalized frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');
figure;
plot(0:1/fs_speech:(Lm-1)/fs_speech,y);xlabel('Time/s');ylabel('Amplitude');title('Distorted Speech Signal');
figure;
plot(0:1/fs_speech:(Ls-1)/fs_speech,y_recov(1:Ls));xlabel('Time/s');ylabel('Amplitude');title('Restored Speech Signal');



