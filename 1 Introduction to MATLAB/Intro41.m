%Problem 4.1 Magic Matrices
clc;clear;

M = magic(5)

sum(M)

sum = sum(M')

M(1,:)

M(:,3)

M(2:end,1:3)

I_1 = find(M > 10);
I_1'
I_2 = find(M < 4);
I_2'
