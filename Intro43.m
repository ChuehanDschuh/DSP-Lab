%Problem 4.3 Statistical Measurements
clc;clear;

x = rand(1000,1);

x_min = min(x);
x_max = max(x);

x_mean = mean(x);
x_std = std(x);
x_var = var(x);

y = 4*x-2;
y_mean = mean(y);
y_std = std(y);

n = randn(1000,1);%data follow normal distribution
figure;
hist(n);

