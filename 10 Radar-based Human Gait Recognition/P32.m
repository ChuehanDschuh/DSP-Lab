clc;clear;close all;

%% 2.1 normal walk
wa = read_radar_data('walk_away_Paco.dat')';
wb = read_radar_data('walk_back_Paco.dat')';
fs = 12.8e3/5;
t1 = (0:length(wa)-1)/fs;


figure;
subplot(2,1,1);plot(t1,real(wa));
subplot(2,1,2);plot(t1,imag(wa));
figure;
subplot(2,1,1);plot(t1,real(wb));
subplot(2,1,2);plot(t1,imag(wb));

%% 2.1 stft
dura = 6;%seconds
tStart_wa = 0.5;
tStart_wb = 3.5;
tn_wa = tStart_wa*fs:(tStart_wa+dura)*fs;
x_wa = wa(tn_wa);
tn_wb = tStart_wb*fs:(tStart_wb+dura)*fs;
x_wb = wb(tn_wb);

Ts = 10;
L = 256;
K = 2048;%K-1

S_wa = 10*log10(abs(calc_STFT(x_wa, hamming(L), Ts, K)).^2);
S_wb = 10*log10(abs(calc_STFT(x_wb, hamming(L), Ts, K)).^2);



%% 2.1 plot
ccmap = genMycmap;
t_plot = (0:(size(S_wb,2)-1)*Ts+L)/fs;

%%%%%walk away%%%%%
f_plot_wa = (-1)*linspace(0,1/2,K/2)*fs;
nf = get_noise_thr(S_wa);
clims = [nf+21 max(max(S_wa))];

% figure;
% f_plot = (-1)*linspace(-1/2,1/2,K)*fs;
% imagesc(t_plot,f_plot,S_wa);
% xlabel('Time (s)');ylabel('Frequency (Hz)');
% c = colorbar;c.Label.String = 'Power/frequency (dB/Hz)';
% set(gca,'YDir','normal');

figure;
imagesc(t_plot,f_plot_wa(1:1+ceil(499/2560*K)),S_wa(K/2:K/2+ceil(499/2560*K),:),clims);
xlabel('Time (s)');ylabel('Doppler frequency (Hz)');
c = colorbar;c.Label.String = 'Power/frequency (dB/Hz)';colormap(ccmap);
set(gca,'YDir','normal');


%%%%%walk back%%%%%
f_plot_wb = (-1)*linspace(-1/2,0,K/2)*fs;
nf = get_noise_thr(S_wb);
clims = [nf+21 max(max(S_wb))];

% figure;
% f_plot = (-1)*linspace(-1/2,1/2,K)*fs;
% imagesc(t_plot,f_plot,S_wb);
% xlabel('Time (s)');ylabel('Frequency (Hz)');
% c = colorbar;c.Label.String = 'Power/frequency (dB/Hz)';
% set(gca,'YDir','normal');

figure;
imagesc(t_plot,f_plot_wb(end-ceil(499/2560*K):end),S_wb(K/2-ceil(499/2560*K):K/2,:),clims);
xlabel('Time (s)');ylabel('Doppler frequency (Hz)');
c = colorbar;c.Label.String = 'Power/frequency (dB/Hz)';colormap(ccmap);
set(gca,'YDir','normal');


%% 2.2 abnormal walk
wa = read_radar_data('limb_walk_away_Paco.dat')';
wb = read_radar_data('limb_walk_back_Paco.dat')';
fs = 12.8e3/5;
t1 = (0:length(wa)-1)/fs;


figure;
subplot(2,1,1);plot(t1,real(wa));
subplot(2,1,2);plot(t1,imag(wa));
figure;
subplot(2,1,1);plot(t1,real(wb));
subplot(2,1,2);plot(t1,imag(wb));

%% 2.2 stft
dura = 6;%seconds
tStart_wa = 1;
tStart_wb = 3.9;
tn_wa = tStart_wa*fs:(tStart_wa+dura)*fs;
x_wa = wa(tn_wa);
tn_wb = tStart_wb*fs:(tStart_wb+dura)*fs;
x_wb = wb(tn_wb);

Ts = 10;
L = 256;
K = 2048;%K-1

S_wa = 10*log10(abs(calc_STFT(x_wa, hamming(L), Ts, K)).^2);
S_wb = 10*log10(abs(calc_STFT(x_wb, hamming(L), Ts, K)).^2);



%% 2.2 plot
ccmap = genMycmap;
t_plot = (0:(size(S_wb,2)-1)*Ts+L)/fs;

%%%%%walk away%%%%%
f_plot_wa = (-1)*linspace(0,1/2,K/2)*fs;
nf = get_noise_thr(S_wa);
clims = [nf+20 max(max(S_wa))];


figure;
imagesc(t_plot,f_plot_wa(1:1+ceil(499/2560*K)),S_wa(K/2:K/2+ceil(499/2560*K),:),clims);
xlabel('Time (s)');ylabel('Doppler frequency (Hz)');
c = colorbar;c.Label.String = 'Power/frequency (dB/Hz)';colormap(ccmap);
set(gca,'YDir','normal');


%%%%%walk back%%%%%
f_plot_wb = (-1)*linspace(-1/2,0,K/2)*fs;
nf = get_noise_thr(S_wb);
clims = [nf+19 max(max(S_wb))];



figure;
imagesc(t_plot,f_plot_wb(end-ceil(499/2560*K):end),S_wb(K/2-ceil(499/2560*K):K/2,:),clims);
xlabel('Time (s)');ylabel('Doppler frequency (Hz)');
c = colorbar;c.Label.String = 'Power/frequency (dB/Hz)';colormap(ccmap);
set(gca,'YDir','normal');

