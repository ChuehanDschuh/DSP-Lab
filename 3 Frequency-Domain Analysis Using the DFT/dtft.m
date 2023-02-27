function [X, w_norm] = dtft(x,M)
    N = length(x);
    pad = zeros(1,M-N);
    x_pad = cat(2,x,pad);
    dft_matrix = zeros(N);
    for k = 1:M
        for l = 1:M
            dft_matrix(k,l) = exp(-1j*2*pi*(k-1)*(l-1)/M);
        end
    end
    X = dft_matrix * x_pad';
    w_norm = 0:2/M:1;
end