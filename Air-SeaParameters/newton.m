% Newton Raphson Method
% http://personal.maths.surrey.ac.uk/st/S.Gourley/NewtonRaphson.pdf

function [L, k, sigma]=newton(h,T);
%------------------------------------------------------------------
% input
% h : water depth (m)
% T : wave periods (s)
% output
% L : wavelength with Newton-Rhapson (m)
% k : wave number with Newton-Rhapson (1/m)
% sigma : angular frequency (1/T)

x1=x0-fs(x0)/df(x0);
n=1;

while( abs(x1-x0)>=1.0e-6 ) & ( n<=100000000 )
    x0=x1;
    x1=x0-fs(x0)/df(x0); n=n+1;
end
x1
n

