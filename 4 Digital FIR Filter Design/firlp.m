function hd = firlp(N,wc)

if mod(N,2)
    alpha = (N-1)/2;
    n = -alpha:alpha;
    hd = sinc(wc*n/pi)*wc/pi;
else
    alpha = N/2;
    n = -alpha:alpha-1;
    hd = sinc(wc*n/pi)*wc/pi;
end

end