clc;clear;close all;

load arunknown.mat;
N = length(X);
var = zeros(1,10);

% for m = 1:10
% ar_coeff = aryule(X,m);
% matrix_X = zeros(m+1,N-m);
% for k = 1:m
%     matrix_X(k,:) = ar_coeff(k+1) .* X(m-k+1:N-k);
% end
% matrix_X(m+1,:) = X(m+1:N);
% var(m) = sum(sum(matrix_X,1).^2)/(N-m);
% end


for m = 1:10
    ar_coeff = aryule(X,m);
    sum = 0;
    for l = m+1:N
        Y = X(l:-1:l-m);
        YK = ar_coeff * Y';
        sum = sum + YK^2;
    end
    var(m) = sum/(N-m);
end

order = 1:10;
AIC = log(var) + (order)*2/N;
MDL = log(var) + (order)*log(N)/N;
figure;
plot(order,AIC,order,MDL);grid on;ax = gca;ax.GridLineStyle = '--';
legend('AIC','MDL');