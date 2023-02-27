function B = maparam(x,q)

cxx = xcorr(x,q);
R = roots(cxx);
b = 1;
for i = 1:length(R)
    if abs(R(i)) <= 1
        b = cat(2,b,R(i));
    end
end
B_temp = poly(b(2:end));
B = B_temp(end:-1:1);

end