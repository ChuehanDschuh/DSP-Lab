clc;clear;close all;

load ar7.mat;
signal = X;
L = [1 2 5 10];%segment number
M = floor(length(signal))./L;%segment length

%% 2,3
for i = 1:4
    Cxx_rect = spec1(signal, L(i), rectwin(M(i)));
    Cxx_hamm = spec1(signal, L(i), hamming(M(i)));
    Cxx_rect_plot = Cxx_rect(1:M(i)/2+1);
    Cxx_hamm_plot = Cxx_hamm(1:M(i)/2+1);
    w = 0:2/M(i):1;
    figure;
    plot(w,10*log10(Cxx_rect_plot));hold on;grid on;ax = gca;ax.GridLineStyle = '--';
    plot(w,10*log10(Cxx_hamm_plot));legend('rectangular','hamming');
    xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Power/frequency (dB/(rad/sample))');
end


%% 4
Cxx_hamm = spec1(signal, L(3), hamming(M(3)));
Cxx_hamm_plot = Cxx_hamm(1:M(3)/2+1);
w = 0:2/M(3):1;

Cxx_hamm_l = 10*log10(Cxx_hamm_plot) - 10*log10(exp(1))*norminv(0.025)/sqrt(L(3));

Cxx_hamm_u = 10*log10(Cxx_hamm_plot) + 10*log10(exp(1))*norminv(0.025)/sqrt(L(3));



figure;
plot(w,10*log10(Cxx_hamm_plot));hold on;
plot(w,Cxx_hamm_l,'-.',w,Cxx_hamm_u,'-.');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Power/frequency (dB/(rad/sample))');
