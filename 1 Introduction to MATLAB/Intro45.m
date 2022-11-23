%Problem4.5 The Moving Average
clc;clear;

load glob_warm.mat

m = 7;%can be different
N = length(year);
x = zeros(1,N);

for n=1:N
    if n < m +1
        x(n) = sum(Ta(1:2*n-1))/(2*n-1);
    elseif n > N - m
        x(n) = sum(Ta(2*n-158:158))/(2*(158-n)+1);
    else
        x(n) = sum(Ta(n-m:n+m))/(2*m+1);
    end
end

figure;
plot(year,x);grid on;
legend('m=7');xlabel('Years');ylabel('Temperature');
xlim([1850 2007]);
ylim([-0.6 0.65]);
