function h = half(x)
    if mod(x,2)==1
        h = (x+1)/2;
    else
        h = x/2+1;
    end
end