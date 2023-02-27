clc;clear;close all;

%% 1
N = [64 256];

n = 0:N(1)-1;
X = sin(0.2*pi*n) + 2*sin(0.4*pi*n) + sin(0.45*pi*n) + sqrt(0.5)*randn(1,N(1));
X = cat(2,X,zeros(1,192));

Ixx = abs(fft(X)).^2;
Ixx_plot = Ixx(1:129);
w = 0:1/128:1;
figure;
plot(w,10*log10(Ixx_plot));grid on;ax = gca;ax.GridLineStyle = '--';axis([0 1 -10 40]);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Power/frequency (dB/(rad/sample))');



n = 0:N(2)-1;
X = sin(0.2*pi*n) + 2*sin(0.4*pi*n) + sin(0.45*pi*n) + sqrt(0.5)*randn(1,N(2));

Ixx = abs(fft(X)).^2;
Ixx_plot = Ixx(1:129);
w = 0:1/128:1;
figure;
plot(w,10*log10(Ixx_plot));grid on;ax = gca;ax.GridLineStyle = '--';axis([0 1 -10 40]);
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Power/frequency (dB/(rad/sample))');


%% 2
N = 256;
L = [2 4];
n = 0:N-1;
X = sin(0.2*pi*n) + 2*sin(0.4*pi*n) + sin(0.45*pi*n) + sqrt(0.5)*randn(1,N);


%%%%%L = 2%%%%%
M = N/L(1);
window = rectwin(N);
Ixx = zeros(N,L(1));

for l = 1:L(1) %number of segments
    x_seg = X(1 + (l-1) * M : l * M);
    x_pad = cat(2,x_seg,zeros(1,N-M));
    sum_window = sum(abs(window).^2);
    Ixx(:,l) = 1/sum_window * abs(fft(window.*x_pad')).^2;

end

Cxx = sum(Ixx,2)/L(1);
Cxx_plot = 10*log10(Cxx(1:129));
w = 0:1/128:1;
figure;
plot(w,Cxx_plot);grid on;ax = gca;ax.GridLineStyle = '--';
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Power/frequency (dB/(rad/sample))');


%%%%%L = 4%%%%%
M = N/L(2);
window = rectwin(N);
Ixx = zeros(N,L(2));

for l = 1:L(1) %number of segments
    x_seg = X(1 + (l-1) * M : l * M);
    x_pad = cat(2,x_seg,zeros(1,N-M));
    sum_window = sum(abs(window).^2);
    Ixx(:,l) = 1/sum_window * abs(fft(window.*x_pad')).^2;

end

Cxx = sum(Ixx,2)/L(2);
Cxx_plot = 10*log10(Cxx(1:129));
w = 0:1/128:1;
figure;
plot(w,Cxx_plot);grid on;ax = gca;ax.GridLineStyle = '--';
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Power/frequency (dB/(rad/sample))');


%%%%%true spectrum%%%%%
N = 3000;
n = 0:N-1;
X = sin(0.2*pi*n) + 2*sin(0.4*pi*n) + sin(0.45*pi*n) + sqrt(0.5)*randn(1,N);

spec = fft(X,N);
spec_plot = spec(1:N/2+1);
w = 0:2/N:1;
plot(w,abs(spec_plot)/4,'color',"#D95319");hold on;grid on;ax = gca;ax.GridLineStyle = '--';
plot(w(300:302),abs(spec_plot(300:302))/4,'color',"#0072BD");
plot(w(600:602),abs(spec_plot(600:602))/4,'color',"#0072BD");
plot(w(675:677),abs(spec_plot(675:677))/4,'color',"#0072BD");
legend('Noise','Spectrum component');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Amplitude');