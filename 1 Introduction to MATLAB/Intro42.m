%Problem 4.2 Fibonacci Numbers
clc;clear;

n = input('Enter n:');
f = fibonacci(n)

phi = 0.5*(sqrt(5) + 1)*ones(1,n-1);%golden ratio
r = zeros(1,n-1);%sequence of ratios fn/fn-1
for i = 1:n-1
    r(i) = f(i+1)/f(i);
end

%plot sequence
t = 1:n-1;
figure;
plot(t,r,t,phi);grid on;
legend('f_{n}/f_{n-1}','golden ratio \phi')



function f=fibonacci(n)
f = zeros(1,n);
f(1) = 1;
f(2) = 1;
for i = 3:n
    f(i) = f(i-1) + f(i-2);
end
end