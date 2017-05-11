% algorithm for air-sea parameters
% write by Wanda, 2017/5/11

function [ustar, uz, Rib, Psta, Fws, Fstab, alpha, Lp, kr, sigma, z0, Cp ]...
    =airseaparameter(Tp, hs, ur, us, Tair, Tsea, Dwater, Hsensor, zh)
%____________________________________________________________
% Input 
% Tp : wave period, sec.
% hs : The significant wave height, m
% Hsensor : the measurement height, m
% ur : the measured wind speed, m/s
% zh : the height of uz, m
% us : the surface current, m/s
% Tair : air temperature, degreedC
% Tsea : sea temperature, degreedC
% Dwater : water depth, m

% Output
% ustar : friction velocity, u*
% uz : the equivalent wind speed at the height of (zh)m, m
% Rib : bulk Richardson number (Rib)
% Psta : the stability parameter, z/L
% Fws : the dimensionless wind shear function, ?_m
% Fstab : the stability function,£Z_m
% alpha : the relationship between the power exponent and the dimensionless wind shear function
% Lp : wavelength with Newton-Rhapson, m
% kr : wave number with Newton-Rhapson, 1/m
% sigma : angular frequency, 1/Tp
% z0 : the roughness length (Taylor and Yelland (2001))
% Cp : the phase velocity, m/s
%____________________________________________________________

            Ldata=size(ur,1);
            % assessment of uz -------------------------------
            zr=nanmean(Hsensor); 
            alpha(1:Ldata,1)=.1; % the power exponent £\o=0.1
            n=1;
            
            for n=1:1:5
                
            for i=1:1:Ldata
            uz(i,n)=(ur(i,1))*((zh/zr).^alpha(i,n));
            uzs(i,n)=abs(ur(i,1)-us(i,1))*((zh/zr).^alpha(i,n)); % add -us
            end
            clear i 

            % bulk Richardson number (Rib) -------------------------------
            dt=Tair(:,1)-Tsea(:,1); % tair - tsea
            g=9.81;
            Rib(:,n)=(g*zh*dt)./((Tair(:,1)+273.15).*(uz(:,n).^2));
            % stability parameter (z/L), Psta ----------------------------------
            for i=1:1:size(Rib,1)
                if Rib(i,n)<0
                    Psta(i,n)=7.6*Rib(i,n);
                elseif Rib(i,n)>0
                    Psta(i,n)=6.0*Rib(i,n);
                else
                    Psta(i,n)=0;
                end
            end
            clear i
            % the dimensionless wind shear function, Fws ----------------------------------
            % & the stability function, Fstab ----------------------------------
            for j=1:1:size(Psta,1)
                if Psta(j,n)<0 % for unstable (z/L<0)
                    Fws(j,n)=(1-15.*Psta(j,n)).^(-1/4); 
                    Fstab(j,n)=1.0496*(-Psta(j,n)).^(.4591);
                elseif Psta(j,n)>0 % for stable (z/L>0)
                    Fws(j,n)=(1+(4.7).*Psta(j,n)); 
                    Fstab(j,n)=-5*Psta(j,n);
                else
                    Fws(j,n)=0;
                    Fstab(j,n)=0;
                end
            end
            clear j
            alpha(:,n+1)=.1.*Fws(:,n); % the relationship between the power exponent and the dimensionless wind shear function
            
            n=n+1;
            
            end
            clear n
            
            % the wave length at the peak frequency, Lp ----------------------------------
            for i=1:1:Ldata
                T=Tp(i,1); 
                if ~isnan(T)
                [Lp(i,1),kr(i,1),sigma(i,1)]=newton(Dwater,T);
                else
                    Lp(i,1)=nan;kr(i,1)=nan;sigma(i,1)=nan;
                end
            end
            clear i T
            
            % the roughness length, z0 (Taylor and Yelland (2001))-----------------------
            z0(:,1)=hs(:,1).*1200.*(hs(:,1)./Lp(:,1)).^(4.5);
            
            % the roughness length, u* ------------------------------------
            ustar(:,1)=.4.*(uz(:,end)-us(:,1)).*(log(zh./z0(:,1)))-(Fstab(:,end)).^(-1);
            
            % the phase velocity, Cp ------------------------------------
            Cp(:,1)=Lp./Tp;

