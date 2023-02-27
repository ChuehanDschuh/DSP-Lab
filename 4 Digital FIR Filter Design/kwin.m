function [kw, N, beta] = kwin(dlt_w, A)

N = ceil((A-8)/(2.2858*dlt_w)+1);

if A < 21
    beta = 0;
elseif A < 50
    beta = 0.5842*(A-21)^(0.4) + 0.07866*(A-21);
else
    beta = 0.1102*(A-8.7);
end

n = 0:N-1;
kw = besseli(0,beta*sqrt(1-(2*n/(N-1)-1).^2))/besseli(0,beta);

end