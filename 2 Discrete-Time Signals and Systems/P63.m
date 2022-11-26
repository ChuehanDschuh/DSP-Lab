%Problem 6.3 Discrete-Time Systems
clc;clear;close all;

n = 0:255;
delta = +(n==0);

%% Q1 
%filter coefficients
b = [0.16 0.48 0.48 0.16];
a = [1 0.13 0.5 0.3];

%impulse response
h = filter(b,a,delta);

%frequency reponse
[H,w] = freqz(b,a);
[phi,wp] = phasez(b,a,100);


%{
figure;
subplot(2,1,1);
stem(n(1:20),h(1:20));grid on;
xlabel('n');ylabel('h(n)');title('Impulse response');
subplot(2,1,2);
plot(w/pi,20*log10(abs(H)));grid on;
xlabel('\omega/\pi');ylabel('Magnitude in dB');title('Frequency response');
%subplot(3,1,3);
%plot(w/pi,phi);grid on;
%xlabel('\omega/\pi');ylabel('Phase');title('Frequency response');
ax = gca;ax.GridLineStyle = '--';
%}

figure;
stem(n(1:20),h(1:20));grid on;
xlabel('n');ylabel('h(n)');

figure;
plot(w/pi,20*log10(abs(H)));grid on;
xlabel('\omega/\pi');ylabel('Magnitude in dB');
%subplot(3,1,3);
%plot(w/pi,phi);grid on;
%xlabel('\omega/\pi');ylabel('Phase');title('Frequency response');
ax = gca;ax.GridLineStyle = '--';

%% Q2


k = 0:100;
wk = pi*k/100;
xk = zeros(length(n),101);
yk = zeros(length(n),101);
ym = zeros(length(n),101);

%generate test input signal
for i = 1:101
    xk(:,i) = cos(wk(i)*n);
    yk(:,i) = filter(b,a,xk(:,i));
    ym(31:end,i) = yk(31:end,i);%skip 30 samples
end

%{
Ym = fft(ym);
L = length(Ym);
Hm = max(abs(Ym)/L,[],1);
figure;
plot(Hm);
%}

xm = zeros(length(n),100);
for i = 1:100
    xm(:,i) = cos(wk(i)*n + phi(i));%phase-modified sinusoid
end

Hm_temp = ym(31:end,1:100)./xm(31:end,:);%quotient
Hm = sum(Hm_temp(31:end,:))/(length(n)-30);%mean of Hm_temp
figure;
plot(w/pi,20*log10(abs(H)),wp/pi,20*log10(Hm));grid on;
legend('Original','Measured');
xlabel('\omega/\pi');ylabel('Magnitude in dB');title('Frequency response');





