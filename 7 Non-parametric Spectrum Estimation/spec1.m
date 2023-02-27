function Cxx = spec1(xn, L, window)

N = length(xn);%length of signal
M = floor(N/L);%length of segments

xn_seg = zeros(M,L);
Ixx = zeros(M,L);

for l = 1:L %number of segments
    xn_seg(:,l) = xn(1 + (l-1) * M : l * M);
    Ixx(:,l) = 1/sum(abs(window).^2) * abs(fft(window.*xn_seg(:,l))).^2;
end

Cxx = sum(Ixx,2)/L;

end
