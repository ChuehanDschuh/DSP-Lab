function S = calc_STFT2(x, w, Ts, K)

m = 0:length(w)-1;
Nt = ceil((length(x) - length(w))/Ts);
S = zeros(K,Nt);
for n = 0:Nt-1
%     for k = 0:K-1
%         S(k+1,n+1) = sum(w.*x(n*Ts+1:n*Ts+length(w))'.*exp(-1j*2*pi*k/K*m'));
%     end

end
S_temp = S((K+1)/2:end,:);
S = cat(1,S_temp,S(1:(K-1)/2,:));
end
