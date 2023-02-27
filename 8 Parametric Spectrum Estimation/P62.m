clc;clear;close all;

load ma3.mat;

q = 3;
B = maparam(x,q);

[H, W] = freqz([1 0.4 -0.2 0.15],1);
[h, w] = freqz(B,1);

%plot
figure;
plot(W/pi, abs(H));hold on;grid on;ax = gca;ax.GridLineStyle = '--';
plot(w/pi, abs(h));
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude');
legend('True Spectrum','Spectrum Estimate');
