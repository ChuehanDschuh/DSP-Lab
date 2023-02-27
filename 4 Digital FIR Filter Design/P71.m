clc;clear;close all;

N = [17 51];
M = 64*N;
wc = 0.5*pi;



%% N=17
lp1 = firlp(N(1),wc);
w1 = 0:2/M(1):1;

win1 = rectwin(N(1));%rectangular
H1 = fft(lp1.*win1',M(1));
win2 = bartlett(N(1));%bartlett
H2 = fft(lp1.*win2',M(1));
win3 = hamming(N(1));%hamming
H3 = fft(lp1.*win3',M(1));

figure;
plot(w1,20*log10(abs(H1(1:M(1)/2+1))));grid on;ax = gca;ax.GridLineStyle = '--';
xline(0.472,'--r');yline(-3,'--r');yline(-20.7,'--r');text(0.35,-55,'\omega_c=0.472\pi');text(0.75,-12,'A=17.71 dB');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');title('Rectangular window, N=17');


figure;
plot(w1,20*log10(abs(H2(1:M(1)/2+1))));grid on;ax = gca;ax.GridLineStyle = '--';
xline(0.445,'--r');yline(-3,'--r');yline(-25.3,'--r');text(0.32,-27,'\omega_c=0.445\pi');text(0.75,-14,'A=22.33 dB');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');title('Bartlett window, N=17');


figure;
plot(w1,20*log10(abs(H3(1:M(1)/2+1))));grid on;ax = gca;ax.GridLineStyle = '--';
xline(0.449,'--r');yline(-3,'--r');yline(-55.2,'--r');text(0.32,-75,'\omega_c=0.449\pi');text(0.75,-25,'A=52.20 dB');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');title('Hamming window, N=17');


%% N=51
lp2 = firlp(N(2),wc);
w2 = 0:2/M(2):1;

win1 = rectwin(N(2));%rectangular
H1 = fft(lp2.*win1',M(2));
win2 = bartlett(N(2));%bartlett
H2 = fft(lp2.*win2',M(2));
win3 = hamming(N(2));%hamming
H3 = fft(lp2.*win3',M(2));

figure;
plot(w2,20*log10(abs(H1(1:M(2)/2+1))));grid on;ax = gca;ax.GridLineStyle = '--';axis([0 1 -80 20]);
xline(0.492,'--r');yline(-3,'--r');yline(-20.95,'--r');text(0.35,-65,'\omega_c=0.492\pi');text(0.75,-12,'A=17.95 dB');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');title('Rectangular window, N=51');


figure;
plot(w2,20*log10(abs(H2(1:M(2)/2+1))));grid on;ax = gca;ax.GridLineStyle = '--';
xline(0.482,'--r');yline(-3,'--r');yline(-26.16,'--r');text(0.32,-32,'\omega_c=0.482\pi');text(0.75,-14,'A=23.16 dB');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');title('Bartlett window, N=51');


figure;
plot(w2,20*log10(abs(H3(1:M(2)/2+1))));grid on;ax = gca;ax.GridLineStyle = '--';axis([0 1 -80 20]);
xline(0.484,'--r');yline(-3,'--r');yline(-53.12,'--r');text(0.32,-75,'\omega_c=0.484\pi');text(0.75,-25,'A=50.12 dB');
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');title('Hamming window, N=51');
