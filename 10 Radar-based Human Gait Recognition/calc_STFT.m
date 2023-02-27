function S = calc_STFT(x, w, Ts, K)

m = 0:length(w)-1;
Nt = ceil((length(x) - length(w))/Ts);
S = zeros(K,Nt);
for n = 0:Nt-1
    S(:,n+1) = fftshift(fft(w.*x(n*Ts+1:n*Ts+length(w))',K));
end

end
