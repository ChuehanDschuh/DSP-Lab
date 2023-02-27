clc;clear;close all;

%opensignals_98D351FD8E66_2021-09-19_00-36-18.txt %slow
%opensignals_98D351FD8E66_2021-09-19_00-37-07.txt %fast
%opensignals_98D351FD8E66_2021-09-19_00-43-41.txt %slow
%opensignals_98D351FD8E66_2021-09-19_00-44-28.txt %fast

% A = importdata("opensignals_98D351FD8E66_2021-09-19_00-36-18.txt");
% B = importdata("opensignals_98D351FD8E66_2021-09-19_00-37-07.txt");

A = importdata("opensignals_98D351FD8E66_2021-09-19_00-43-41.txt");
B = importdata("opensignals_98D351FD8E66_2021-09-19_00-44-28.txt");

slow = A.data;
fast = B.data;


%% pre-process

sdata = slow(:,6:7);
fdata = fast(:,6:7);

% figure;
% subplot(2,1,1);
% plot(0:1999,bs);
% subplot(2,1,2);
% plot(0:1999,bf);

%remove mean
sdata = sdata - sum(sdata)/length(sdata);
fdata = fdata - sum(fdata)/length(fdata);

%remove trend
sdata = detrend(sdata);
fdata = detrend(fdata);

%filtering
[b, a] = butter(26, 0.8);

cards = filter(b,a,sdata(:,1));
cardf = filter(b,a,fdata(:,1));

%% cardiac signal

% cards_plot = cards(2001:3000,1);
% cardf_plot = cardf(2001:3000,1);
% 
% figure;
% plot(0:1/100:10-1/100,cards_plot);hold on;
% rectangle('Position',[3.15 -251 0.65 692],'EdgeColor',"#D95319");
% xlabel('Time (s)');ylabel('Amplitude (mV)');
% 
% figure;
% plot(0:1/100:10-1/100,cardf_plot);hold on;
% rectangle('Position',[3.36 -286 0.53 728],'EdgeColor',"#D95319");
% xlabel('Time (s)');ylabel('Amplitude (mV)');

%periodogram
ls = length(cards);
if mod(ls,2)==1
    hls = (ls+1)/2;
else
    hls = ls/2+1;
end
Ixx_cards = abs(fft(cards)).^2/ls;
Ixx_cards_plot = 10*log10(Ixx_cards(1:hls));
[M, I] = max(Ixx_cards_plot);
fk = 100*(0:1/ls:1/2);
figure;
plot(fk,Ixx_cards_plot,"Marker","o","MarkerIndices",I,"MarkerEdgeColor","#D95319","MarkerFaceColor","#D95319");
grid on;ax = gca;ax.GridLineStyle = '--';axis([0 40 -10 80]);
xlabel('Frequency (Hz)');ylabel('Power/frequency (dB/Hz)');
text(fk(I)+0.5,M,num2str(fk(I))+" Hz");

lf = length(cardf);
if mod(lf,2)==1
    hlf = (lf+1)/2;
else
    hlf = lf/2+1;
end
Ixx_cardf = abs(fft(cardf)).^2/lf;
Ixx_cardf_plot = 10*log10(Ixx_cardf(1:hlf));
[M, I] = max(Ixx_cardf_plot);
fk = 100*(0:1/lf:1/2);
figure;
plot(fk,Ixx_cardf_plot,"Marker","o","MarkerIndices",I,"MarkerEdgeColor","#D95319","MarkerFaceColor","#D95319");
grid on;ax = gca;ax.GridLineStyle = '--';axis([0 40 -10 80]);
xlabel('Frequency (Hz)');ylabel('Power/frequency (dB/Hz)');
text(fk(I)+0.5,M,num2str(fk(I))+" Hz");

%averaged periodogram
L = 6;
Ms = floor(ls/L);
if mod(Ms,2)==1
    hMs = (Ms+1)/2;
else
    hMs = Ms/2+1;
end
Mf = floor(lf/L);
if mod(Mf,2)==1
    hMf = (Mf+1)/2;
else
    hMf = Mf/2+1;
end

Cxx_cards = spec1(cards,L,rectwin(Ms));
Cxx_cards_plot = 10*log10(Cxx_cards(1:hMs));
[M, I] = max(Cxx_cards_plot);
fk = 100*(0:1/Ms:1/2);
figure;
plot(fk,Cxx_cards_plot,"Marker","o","MarkerIndices",I,"MarkerEdgeColor","#D95319","MarkerFaceColor","#D95319");
grid on;ax = gca;ax.GridLineStyle = '--';axis([0 40 0 80]);
xlabel('Frequency (Hz)');ylabel('Power/frequency (dB/Hz)');
text(fk(I)+0.5,M,num2str(fk(I))+" Hz");

Cxx_cardf = spec1(cardf,L,rectwin(Mf));
Cxx_cardf_plot = 10*log10(Cxx_cardf(1:hMf));
[M, I] = max(Cxx_cardf_plot);
fk = 100*(0:1/Mf:1/2);
figure;
plot(fk,Cxx_cardf_plot,"Marker","o","MarkerIndices",I,"MarkerEdgeColor","#D95319","MarkerFaceColor","#D95319");
grid on;ax = gca;ax.GridLineStyle = '--';axis([0 40 0 80]);
xlabel('Frequency (Hz)');ylabel('Power/frequency (dB/Hz)');
text(fk(I)+0.5,M,num2str(fk(I))+" Hz");


%% repiration signal
resps = sdata(:,2);
respf = fdata(:,2);
resps_plot = sdata(501:2500,2);
respf_plot = fdata(501:2500,2);

figure;
plot(0:1/100:20-1/100,resps_plot);
xlabel('Time (s)');ylabel('Amplitude (mV)');

figure;
plot(0:1/100:20-1/100,respf_plot);
xlabel('Time (s)');ylabel('Amplitude (mV)');

%periodogram
ls = length(sdata(:,2));
if mod(ls,2)==1
    hls = (ls+1)/2;
else
    hls = ls/2+1;
end
Ixx_resps = abs(fft(resps)).^2/ls;
Ixx_resps_plot = 10*log10(Ixx_resps(1:hls));
[M, I] = max(Ixx_resps_plot);
fk = 100*(0:1/ls:1/2);
figure;
plot(fk,Ixx_resps_plot,"Marker","o","MarkerIndices",I,"MarkerEdgeColor","#D95319","MarkerFaceColor","#D95319");
grid on;ax = gca;ax.GridLineStyle = '--';axis([0 10 -10 80]);
xlabel('Frequency (Hz)');ylabel('Power/frequency (dB/Hz)');
text(fk(I)+0.13,M,num2str(fk(I))+" Hz");


lf = length(respf);
if mod(lf,2)==1
    hlf = (lf+1)/2;
else
    hlf = lf/2+1;
end
Ixx_respf = abs(fft(respf)).^2/lf;
Ixx_respf_plot = 10*log10(Ixx_respf(1:hlf));
[M, I] = max(Ixx_respf_plot);
fk = 100*(0:1/lf:1/2);
figure;
plot(fk,Ixx_respf_plot,"Marker","o","MarkerIndices",I,"MarkerEdgeColor","#D95319","MarkerFaceColor","#D95319");
grid on;ax = gca;ax.GridLineStyle = '--';axis([0 10 -10 80]);
xlabel('Frequency (Hz)');ylabel('Power/frequency (dB/Hz)');
text(fk(I)+0.13,M,num2str(fk(I))+" Hz");


%averaged periodogram
L = 5;
Ms = floor(ls/L);
if mod(Ms,2)==1
    hMs = (Ms+1)/2;
else
    hMs = Ms/2+1;
end
Mf = floor(lf/L);
if mod(Mf,2)==1
    hMf = (Mf+1)/2;
else
    hMf = Mf/2+1;
end

Cxx_resps = spec1(resps,L,rectwin(Ms));
Cxx_resps_plot = 10*log10(Cxx_resps(1:hMs));
[M, I] = max(Cxx_resps_plot);
fk = 100*(0:1/Ms:1/2);
figure;
plot(fk,Cxx_resps_plot,"Marker","o","MarkerIndices",I,"MarkerEdgeColor","#D95319","MarkerFaceColor","#D95319");
grid on;ax = gca;ax.GridLineStyle = '--';axis([0 10 0 80]);
xlabel('Frequency (Hz)');ylabel('Power/frequency (dB/Hz)');
text(fk(I)+0.14,M,num2str(fk(I))+" Hz");

Cxx_respf = spec1(respf,L,rectwin(Mf));
Cxx_respf_plot = 10*log10(Cxx_respf(1:hMf));
[M, I] = max(Cxx_respf_plot);
fk = 100*(0:1/Mf:1/2);
figure;
plot(fk,Cxx_respf_plot,"Marker","o","MarkerIndices",I,"MarkerEdgeColor","#D95319","MarkerFaceColor","#D95319");
grid on;ax = gca;ax.GridLineStyle = '--';axis([0 10 0 80]);
xlabel('Frequency (Hz)');ylabel('Power/frequency (dB/Hz)');
text(fk(I)+0.14,M,num2str(fk(I))+" Hz");
