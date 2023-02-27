function ccmap = genMycmap
    ccmap = cat(1,cat(2,ones(11,2),(1:-0.1:0)'),cat(2,cat(2,ones(10,1),(0.9:-0.1:0)'),zeros(10,1)));

    m1 = cat(2,cat(2,ones(10,1),zeros(10,1)),(0.1:0.1:1)');
    
    m2 = cat(2,cat(2,(0.9:-0.1:0)',zeros(10,1)),ones(10,1));
    
    m3 = cat(2,cat(2,zeros(10,1),(0.1:0.1:1)'),ones(10,1));
    
    m4 = cat(2,cat(2,zeros(10,1),ones(10,1)),(0.9:-0.1:0)');
    
    ccmap = cat(1,ccmap,m1);
    ccmap = cat(1,ccmap,m2);
    ccmap = cat(1,ccmap,m3);
    ccmap = cat(1,ccmap,m4);
end