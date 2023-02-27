clc;clear;close all;

%% Q1
N = 32;
n = 0:N-1;
x = 0.8*sin(0.2*pi*n);
w = 2*pi*(0:1/N:1-1/N);

X_dft = dft(x);
X_fft = fft(x);

figure;%dft
stem(w,abs(X_dft));xlabel('\omega');ylabel('|X(e^{j\omega})|');axis([0 w(end) 0 13]);
figure;%fft
stem(w,abs(X_fft));xlabel('\omega');ylabel('|X(e^{j\omega})|');axis([0 w(end) 0 13]);


%% Q2
k = 4:8;
repeat_times = 100;
T_dft = zeros(1,repeat_times);
T_fft = zeros(1,repeat_times);
avg_T = zeros(length(k),2);%1:dft, 2:fft

for p = 1:length(k)
    lx = 0:2^k(p)-1;%signal length
    x = 0.8*sin(0.2*pi*lx);
    for i = 1:repeat_times
        tic
        X_dft = dft(x);
        T_dft(i) = toc;
    
        tic
        X_fft = fft(x);
        T_fft(i) = toc;
    end
    avg_T(p,1) = mean(T_dft);
    avg_T(p,2) = mean(T_fft);
end


figure;
semilogy(2.^(k),avg_T(:,1),2.^(k),avg_T(:,2));axis([16 256 10^-6 10^-2]);
legend('DFT','FFT');xlabel('N');ylabel('Time/s');grid on;

