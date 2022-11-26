clc;clear;



n = 0:1:35;

h = 0.2*((n==0)+(n==1)+(n==2)+(n==3)+(n==4));
x1 = (n==0)+(n==1)+(n==2)+(n==3)+(n==4)...
    +(n==5)+(n==6)+(n==7)+(n==8)+(n==9);
x2 = sin(0.2*pi*n);
x3 = sin(0.4*pi*n);

y1 = convmat(x1,h);
y2 = convmat(x2,h);
y3 = convmat(x3,h);


figure;
subplot(3,2,1);
stem(n,x1);
subplot(3,2,3);
stem(n,x2);
subplot(3,2,5);
stem(n,x3);

subplot(3,2,2);
stem(n,y1);xlabel('y1');
subplot(3,2,4);
stem(n,y2);xlabel('y2');
subplot(3,2,6);
stem(n,y3);xlabel('y3');





