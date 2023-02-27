function X = dft(x)
    
    N = length(x);
    dft_matrix = zeros(N);
    for k = 1:N
        for l = 1:N
            dft_matrix(k,l) = exp(-1j*2*pi*(k-1)*(l-1)/N);
        end
    end
    X = dft_matrix * x';
    
end