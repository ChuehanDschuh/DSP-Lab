% Problem 6.4 Bandpass Filtering
clc;clear;close all;

%% Q1

load b3pulses.mat;



%% Q2
fs = 80000;%80kHz
L = length(x);
w0 = [0.1625*pi 0.325*pi 0.475*pi];
r = [0.8888 0.8221 0.9243];

b = [1 0 -1;
     1 0 -1;
     1 0 -1];
a = [1 -2*r(1)*cos(w0(1)) r(1)^2;
     1 -2*r(2)*cos(w0(2)) r(2)^2;
     1 -2*r(3)*cos(w0(3)) r(3)^2];


H = zeros(512,3);
w = zeros(512,3);
figure;


for i = 1:3

    [H(:,i), w(:,i)] = freqz(b(i,:),a(i,:));
    
    %plot
    subplot(3,1,i);
    plot(w(:,i)/pi,20*log10(abs(H(:,i))));grid on;ax = gca;ax.GridLineStyle = '--';
    xlabel('\omega/\pi');ylabel('Magnitude in dB');title('Frequency response');
    
end


%% Q3


X = fft(x);
lx = length(X);
m = (0:lx-1)/lx*fs;%frequency range
mz = (-lx/2:lx/2-1)/lx*fs; %zero-centered frequency range
y = zeros(lx,3);

%filtering
for i = 1:3
    y(:,i) = filter(b(i,:),a(i,:),x);
end

%spectrum
Y = fft(y);
Y_shift = fftshift(Y,1);
%{
%plot
for i = 1:3
    figure;

    subplot(3,1,1);
    plot(y(:,i));
    title("Filtered signal " + num2str(i) + " in the time domain" );xlabel('n');
    subplot(3,1,2);
    plot(mz/1000,abs(Y(:,i)/L));grid on;ax = gca;ax.GridLineStyle = '--';
    title("Filtered signal " + num2str(i) + " in the frequency domain" );xlabel('Frequency (kHz)');
    subplot(3,1,3);
    plot(mz/1000,abs(Y_shift(:,i)/L));grid on;ax = gca;ax.GridLineStyle = '--';
    title("Zero-centered spectrum of filtered signal " + num2str(i) );xlabel('Frequency (kHz)');

end
%}

    figure;

    subplot(3,1,1);
    plot(y(:,1));
    title("Filtered signal 1" );xlabel('n');
    subplot(3,1,2);
    plot(y(:,2));
    title("Filtered signal 2" );xlabel('n');
    subplot(3,1,3);
    plot(y(:,3));
    title("Filtered signal 3" );xlabel('n');



ms = (0:lx/2)/lx*fs;
Y_1side = abs(Y(1:lx/2+1,:)/lx);
Y_1side(2:end-1,:) = 2*Y_1side(2:end-1,:);
figure;

%{
for i = 1:3

    subplot(3,1,i);
    plot(ms/1000,abs(Y_1side(:,i)));grid on;ax = gca;ax.GridLineStyle = '--';
    title("Single-sided spectrum of filtered signal " + num2str(i) );xlabel('Frequency (kHz)');

end
%}

    plot(ms/1000,abs(Y_1side(:,1)));grid on;ax = gca;ax.GridLineStyle = '--';xline(5,'--r');xline(8,'--r');
    title("Filtered signal 1");xlabel('Frequency (kHz)');
figure;
    plot(ms/1000,abs(Y_1side(:,2)));grid on;ax = gca;ax.GridLineStyle = '--';xline(10.5,'--r');xline(15.5,'--r');
    title("Filtered signal 2");xlabel('Frequency (kHz)');
figure;
    plot(ms/1000,abs(Y_1side(:,3)));grid on;ax = gca;ax.GridLineStyle = '--';xline(18,'--r');xline(20,'--r');
    title("Filtered signal 3");xlabel('Frequency (kHz)');



