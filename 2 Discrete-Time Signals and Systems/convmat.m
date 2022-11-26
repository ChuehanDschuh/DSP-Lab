function y = convmat(x,h)
Nx = length(x);
Nh = length(h);
H = zeros(Nx+Nh-1,Nx);

for i = 1:Nx

    H(i:i+Nh-1,i) = h';

end

y = H*x';
y = y';
end