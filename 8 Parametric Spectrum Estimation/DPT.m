function [a0, bi] = DPT(X, M, fs)
    N = length(X);
    nDelta = (0:N-1)/fs;
    bi = zeros(1,M+1);
    Y = X;
    NFFT = 512;
    w = 0:2/NFFT:1;
    for m = M:-1:1
        DPTM = fft(DPM(Y,m),NFFT);
        [~, Imax] = max(DPTM(1:NFFT/2+1));
        bi(m+1) = w(Imax)*pi/factorial(m)/(floor(N/m)/fs)^(m-1);
        mult = exp(-1j * bi(m+1) * nDelta.^m);
        Y = Y.*mult;
    end
    bi(1) = angle(sum(Y));
    a0 = abs(sum(Y))/N;
end