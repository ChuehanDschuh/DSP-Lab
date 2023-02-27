function hd = firbp(N,w0,dlt_w)

if mod(N,2)
    alpha = (N-1)/2;
    n = -alpha:alpha;
    hd = 2*sinc(dlt_w*n/pi)*wc/pi*cos(w_0*n);
else
    alpha = N/2;
    n = -alpha:alpha;
    hd = 2*sinc(dlt_w*n/pi)*wc/pi*cos(w_0*n);
end

end