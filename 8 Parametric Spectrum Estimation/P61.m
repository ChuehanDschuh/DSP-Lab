clc;clear;close all;

a = [1 0.5 0.7 0.2];
x = filter(1,a,randn(1,1024));

%yule-walker
ar_coeff = aryule(x,3);
[h, w] = freqz(1,ar_coeff);

%ar-psd estimate
[Pxx, omega] = pyulear(x,3);

%true spectrum
[H, W] = freqz(1,a);

%plot
figure;
plot(W/pi, abs(H).^2);hold on;grid on;ax = gca;ax.GridLineStyle = '--';
plot(w/pi, abs(h).^2);
plot(omega/pi, Pxx);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude');
legend('True Spectrum','Yule-Walker Method','AR PSD Estimate');

