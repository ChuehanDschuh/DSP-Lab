clc;clear;close all;

wp = 0.12*pi;
ws = 0.18*pi;
A = 30;% in dB
d_w = ws - wp;
[kaiserwin, N, ~] = kwin(d_w, A);

n = -(N-1)/2:(N-1)/2;
M = 32*N;

stem(0:N-1,kaiserwin);axis([0 N-1 0 1]);xlabel('n');ylabel('w_k(n)');

%% LP
lp = firlp(N, 0.15*pi);
lp_kwin = kaiserwin.*lp;%impulse response

LP_kwin = fft(lp_kwin,M);%frequency response
LP_kwin_plot = 20*log10(abs(LP_kwin(1:M/2+1)));

figure;
stem(0:N-1,lp_kwin);axis([0 N-1 -0.04 0.16]);xlabel('n');ylabel('h_{LP}(n)');title("Lowpass filter using Kaiser's Method with N=53 ");
figure;
w_lp = 0:2/M:1;
plot(w_lp,LP_kwin_plot);
grid on;ax = gca;ax.GridLineStyle = '--';%'--' for the dash line
axis([0 1 -100 20]);%axis limits
yline(-0.2,'--r');yline(-31.64,'--r');xline(0.12,'--r');xline(0.18,'--r');%lines 'r' for red
xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('Magnitude in dB');
text(0.33,-17,'A=31.44 dB');text(0.01,-90,'\omega_p=0.12\pi');text(0.19,-90,'\omega_s=0.18\pi');
%% HP
delta = +(n==0);
hp =  delta - firlp(N, 0.15*pi);

figure;
stem(0:N-1, hp);axis([0 N-1 -0.2 1]);xlabel('n');ylabel('h_{HP}(n)');title("Highpass filter using Kaiser's Method with N=53 ");

hp_kwin = kaiserwin.*hp;
HP_kwin = fft(hp_kwin,M);



HP_kwin_plot = 20*log10(abs(HP_kwin(1:M/2+1)));
figure;
w_hp = 0:2/M:1;
plot(w_hp,HP_kwin_plot);

%% BP
delta = +((-5:5)==0);
