clc;clear;close all;

load ar7.mat;

input = X;

m1=1;
m2=2;
m3=10;

Cxx1 = spec2(m1,input);
Cxx2 = spec2(m2,input);
Cxx3 = spec2(m3,input);

Cxx1_plot = 10*log10(Cxx1(1:501));
Cxx2_plot = 10*log10(Cxx2(1:501));
Cxx3_plot = 10*log10(Cxx3(1:501));

omega = 0:1/500:1;

figure;
plot(omega,Cxx1_plot);hold on;grid on;ax = gca;ax.GridLineStyle = '--';
plot(omega,Cxx2_plot);
plot(omega,Cxx3_plot,'Color',"#77AC30");

xlabel('$\omega/\pi$','interpreter','latex');
ylabel('$\hat{C}^{s}_{XX}(e^(j\omega)$','interpreter','latex');
legend("m="+num2str(m1),"m="+num2str(m2),"m="+num2str(m3));