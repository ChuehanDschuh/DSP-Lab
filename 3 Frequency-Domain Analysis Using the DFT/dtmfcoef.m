function symbol = dtmfcoef(s_dtft,threshold)
    
dtmf_keys = ...
    [49, 50, 51, 65;
     52, 53, 54, 66;
     55, 56, 57, 67;
     42, 48, 35, 68];%ascii-code

    N = length(s_dtft);
    s_dtft = abs(s_dtft(1:N/2+1));%single-sided part
    
    freq = ...
    [round(0.1742*N/2)+1, round(0.30225*N/2)+1;
     round(0.1925*N/2)+1, round(0.334*N/2)+1;
     round(0.213*N/2)+1,  round(0.36925*N/2)+1;
     round(0.23525*N/2)+1,round(0.40825*N/2)+1;];%indices of 16 normalized frequencies in s_dtft
    
    for i = 1:4
        if s_dtft(freq(i,1)) > threshold
            row = i;
            for j = 1:4
                if s_dtft(freq(j,2)) > threshold
                    col = j;
                    break
                end
            end
            break
        end
    end

    symbol = dtmf_keys(row,col);

end