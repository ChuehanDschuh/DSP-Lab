%Problem6.1 Discrete-Time Signals
clc;clear;

n = -10:1:20;
delta = +(n==0);
u = +(n>=0);

x1 = sin(0.12*pi*n);
x2 = (+(n>=0)) - (+(n>=6));
x3 = 0.9.^n.*u;
x4 = 0.5*(n==1)+(n==2)+0.5*(n==3);
x5 = 0.9.^n.*cos(0.2*pi*n);
x6 = sin(0.2*pi*n)./(0.2*pi*n);x6(delta==1) = 1;

figure;
subplot(3,2,1);
stem(n,x1);xlabel('x_{1}(n)');
subplot(3,2,2);
stem(n,x2);xlabel('x_{2}(n)');
subplot(3,2,3);
stem(n,x3);xlabel('x_{3}(n)');
subplot(3,2,4);
stem(n,x4);xlabel('x_{4}(n)');
subplot(3,2,5);
stem(n,x5);xlabel('x_{5}(n)');
subplot(3,2,6);
stem(n,x6);xlabel('x_{6}(n)');

