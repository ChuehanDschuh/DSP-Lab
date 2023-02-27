function S = dft(s);
%DFT
% computes the discrete fourier transform
% using the dft matrix notation
%
%   usage: S = DFT(s);
%
%  s - input signal
%  S - discrete fourier transform
  
s = s(:);
N = length(s);
n = 0:N-1;
k = n';
D = exp(-j*2*pi/N*k*n);
S = D*s;
  