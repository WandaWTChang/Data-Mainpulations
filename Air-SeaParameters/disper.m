function [Lr,kr,sigma]=disper(h,T)
% ____________________________________________
% With this function, you can get the value of L (wavelength), k (wave number),
% sigma(angular frequency), using different solutions of the dispersion equation.
%
% Inputs:
%            h = deep water (m)
%            T = wave period (s)
%
% Outputs:
%            kr = wave number with Newton-Rhapson (1/m)
%            Lr = wavelength with Newton-Rhapson (m)
%            sigma = angular frequency (1/T)
%
% Syntax :
%             [Lr,kr,sigma]=disper(h,T)
%
% Example:    [Lr,kr,sigma]=disper(3.05,5)
%
% Notes: 
%            In the command window you can see the different
%            values which were computed, using different equations
% 
% Referents:
%              Darlymple, R.G. and Dean R.A. (1999). Water Wave Mechanics
%              for Engineers and Scientist. World Scientific.
%              Singapure.
%              Fenton,J.D and Mckee,W.D.(1990). On calculating the lengths
%              of water waves. Coastal Engineering 14, 499-513p.
%
% Programming: Gabriel Ruiz Martinez 2006.
% _______________________________________________________

% Test value
%T =8; 
%h = 10; 
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
    while abs( x(con+1) - x(con) ) > 0.00001
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
% ******************************************************

% *********** Solving dispersion equation, using Lo aproximation **********
Lo = (9.81*T^2)/(2*pi);
La = Lo * (tanh(((2*pi)*((sqrt(h/9.81))/T))^(3/2)))^(2/3);
ka = ( 2 * pi ) /La;
Ca = La/T;
na =0.5*(1+((2*ka*h)/sinh(2*ka*h)));
Cga = na * Ca;
ea = (abs(Lr-La)/abs(Lr))*100;
% ******************************************************

% *********** Solving dispersion equation, using Eckhart **********
ke = sigma_2/(9.81*sqrt(tanh(h*(sigma_2/9.81))));
Le = (2*pi)/ke;
Ce = Le/T;
ne =0.5*(1+((2*ke*h)/sinh(2*ke*h)));
Cge = ne * Ce;
ee = (abs(Lr-Le)/abs(Lr))*100;
% ****************************************************

% *********** Solving dispersion equation, using Hunt **********
yh = ((((2*pi)/T)^2)*h)/9.81;                                    
d1 = 0.6666666666*yh;
d2 = 0.3555555555*yh^2;
d3 = 0.1608465608*yh^3;
d4 = 0.0632098765*yh^4;
d5 = 0.0217540484*yh^5;
d6 = 0.0065407983*yh^6;
sumd = d1+d2+d3+d4+d5+d6;
dis = yh^2+(yh/(1+sumd));
kh = sqrt(dis)/h;
Lh = (2*pi)/kh;
Ch = Lh/T;
nh =0.5*(1+((2*ke*h)/sinh(2*ke*h)));
Cgh = nh * Ch;
eh = (abs(Lr-Lh)/abs(Lr))*100;
% ******************************************************

% ******************************************************
clc;
fprintf('    Method:         L(m):     k(1/m):   sigma(1/T):     C(m/s):   n:       Cg(m/s):   error*100\n');
fprintf('---------------------------------------------------------------------------------------------\n');
fprintf('Newton-Rhapson:     %6.3f   %6.3f      %6.3f        %6.3f    %6.3f   %6.3f      - \n', Lr,kr,sigma,Cr,nr,Cgr);
fprintf('Lo-aproximation:    %6.3f   %6.3f      %6.3f        %6.3f    %6.3f   %6.3f      %6.4f   \n', La,ka,sigma,Ca,na,Cga,ea);
fprintf('Eckart:             %6.3f   %6.3f      %6.3f        %6.3f    %6.3f   %6.3f      %6.4f   \n', Le,ke,sigma,Ce,ne,Cge,ee);
fprintf('Hunt:               %6.3f   %6.3f      %6.3f        %6.3f    %6.3f   %6.3f      %6.4f   \n', Lh,kh,sigma,Ch,nh,Cgh,eh);
fprintf('---------------------------------------------------------------------------------------------\n');
fprintf('\n');
fprintf('L = wave length, k = wave number, sigma = angular frequency,');
fprintf('C = wave celerity, Cg = wave celerity group\n');
fprintf('\n');
fprintf('Note: If we consider the value was obtained, using a Newthon-Raphson method, \n');
fprintf('as the L exact value, relative error of the others values is showed in the table\n');



