function x = genFMsignal(A, alpha, beta, gamma, fc, fs, tStart, tStop)
    t = tStart:1/fs:tStop;
    phase = 2*pi*fc*t + alpha/beta*sin(2*pi*beta*t+gamma);
    x = A*cos(phase);
end