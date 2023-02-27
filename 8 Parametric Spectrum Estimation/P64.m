clc;clear;close all;

load s5.mat;
SH=s5(15600:16300);
AA=s5(16800:17500);

figure;plot((0:length(SH)-1)/8,SH);xlabel('Time [ms]');ylabel('Amplitude');
figure;plot((0:length(AA)-1)/8,AA);xlabel('Time [ms]');ylabel('Amplitude');

%% AA
ar_para = aryule(AA,10);
[h, w] = freqz(1,ar_para);
[Ixx, W] = pwelch(AA);

figure;
yyaxis left;
plot(W/pi, 10*log10(Ixx),'-.');grid on;ax = gca;ax.GridLineStyle = '--';ax.GridColor = "#888888";ylabel('PSD (dB/(rad/sample))');
yyaxis right;
plot(w/pi, 10*log10(abs(h).^2));xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude (dB)');
legend('Periodogram','AR(10) model');

X = AA;
N = length(X);
var = zeros(1,35);
for m = 1:35
    ar_coeff = aryule(X,m);
    sum = 0;
    for l = m+1:N
        Y = X(l:-1:l-m);
        YK = ar_coeff * Y;
        sum = sum + YK^2;
    end
    var(m) = sum/(N-m);
end

order = 1:35;
AIC = log(var) + (order)*2/N;
MDL = log(var) + (order)*log(N)/N;

[Maic, Iaic] = min(AIC);
[Mmdl, Imdl] = min(MDL);


ar_para_aic = aryule(AA,Iaic);
[haic, waic] = freqz(1,ar_para_aic);
ar_para_mdl = aryule(AA,Imdl);
[hmdl, wmdl] = freqz(1,ar_para_mdl);

figure;
yyaxis left;
plot(W/pi, 10*log10(Ixx),'-.');grid on;ax = gca;ax.GridLineStyle = '--';ax.GridColor = "#888888";ylabel('PSD (dB/(rad/sample))');
yyaxis right;
plot(waic/pi, 10*log10(abs(haic).^2));xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude (dB)');
legend('Periodogram','AIC method');

figure;
yyaxis left;
plot(W/pi, 10*log10(Ixx),'-.');grid on;ax = gca;ax.GridLineStyle = '--';ax.GridColor = "#888888";
yyaxis right;
plot(wmdl/pi, 10*log10(abs(hmdl).^2));
legend('Periodogram','MDL method');


%% SH
ar_para = aryule(SH,10);
[h, w] = freqz(1,ar_para);
[Ixx, W] = pwelch(SH);

figure;
yyaxis left;
plot(W/pi, 10*log10(Ixx),'-.');grid on;ax = gca;ax.GridLineStyle = '--';ax.GridColor = "#888888";ylabel('PSD (dB/(rad/sample))');
yyaxis right;
plot(w/pi, 10*log10(abs(h).^2));xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude (dB)');
legend('Periodogram','AR(10) model');

X = SH;
N = length(X);
var = zeros(1,35);
for m = 1:35
    ar_coeff = aryule(X,m);
    sum = 0;
    for l = m+1:N
        Y = X(l:-1:l-m);
        YK = ar_coeff * Y;
        sum = sum + YK^2;
    end
    var(m) = sum/(N-m);
end

order = 1:35;
AIC = log(var) + (order)*2/N;
MDL = log(var) + (order)*log(N)/N;

[Maic, Iaic] = min(AIC);
[Mmdl, Imdl] = min(MDL);


ar_para_aic = aryule(SH,Iaic);
[haic, waic] = freqz(1,ar_para_aic);
ar_para_mdl = aryule(SH,Imdl);
[hmdl, wmdl] = freqz(1,ar_para_mdl);

figure;
yyaxis left;
plot(W/pi, 10*log10(Ixx),'-.');grid on;ax = gca;ax.GridLineStyle = '--';ax.GridColor = "#888888";ylabel('PSD (dB/(rad/sample))');
yyaxis right;
plot(waic/pi, 10*log10(abs(haic).^2));xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude (dB)');
legend('Periodogram','AIC method');

figure;
yyaxis left;
plot(W/pi, 10*log10(Ixx),'-.');grid on;ax = gca;ax.GridLineStyle = '--';ax.GridColor = "#888888";
yyaxis right;
plot(wmdl/pi, 10*log10(abs(hmdl).^2));
legend('Periodogram','MDL method');


