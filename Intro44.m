%Problem 4.4 An Optimization Example
clc;clear;

r = 0.5:0.01:10;

A = 2*pi*r.^2 + 660./r;

[M,I]=min(A);

figure;
plot(r,A,'-o','MarkerIndices',[I],...
    'MarkerFaceColor','red',...
    'MarkerSize',7);grid on;
text(3,325,'(3.74,264.3573)')
xlabel('Radius r/cm');ylabel('Surface area A/cm^{2}');

