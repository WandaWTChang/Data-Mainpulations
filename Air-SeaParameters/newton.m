% Newton Raphson Method
% http://personal.maths.surrey.ac.uk/st/S.Gourley/NewtonRaphson.pdf
% write by Wanda(2017/5/11)

function [Lr, kr, sigma]=newton(h,T)
%------------------------------------------------------------------
% input
% h : water depth (m)
% T : wave periods (s)
% output
% Lr : wavelength with Newton-Rhapson (m)
% kr : wave number with Newton-Rhapson (1/m)
% sigma : angular frequency (1/T)

x0 =0.0001;   

if sign(h) == -1 % 符號值，若h>0為+1；h=0為0；h<0為-1
       h = -h;
end
% *********** Solving dispersion equation, using Newton-Rapshon **********
sigma_2 = ((2*pi)/T).^2;
Gamma = (sigma_2*h)/9.81;

con = 1;

if x0 ~= 0
    x(con) = x0;
    x(con+1) = x(con) - ( ( Gamma - (x(con) * tanh(x(con)))) / ...
               ((-x(con)*(sech(x(con)))^ 2)-tanh(x(con))));
    while abs( x(con+1) - x(con) ) > 1.0e-6 & ( con<=100000000 )
            x(con+2) = x(con+1) - ( ( Gamma - (x(con+1) * tanh(x(con+1)))) / ...
                       ((-x(con+1)*(sech(x(con+1)))^ 2)-tanh(x(con+1))));
            con = con + 1;
    end
    kr = x(con)/h;
    Lr = (2*pi)/kr;
    sigma = sqrt(sigma_2);
    Cr = Lr/T;
    nr =0.5*(1+((2*kr*h)/sinh(2*kr*h)));
    Cgr = nr * Cr;
    
else
    disp('WARNING !!!! You cannot run the function with x0 = 0,Try with other value');
    kr = 0;
    Lr = 0;
end


