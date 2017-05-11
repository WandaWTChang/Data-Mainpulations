clear;clc

s=[cd];
% path1=addpath([s(1:30) '\彰濱浮標記憶卡資料\']);
datapath=[s '\xlsxFile\'];

for YY=12%:1:13
    for MM=8%1:1:12
        if MM<10
            file=[datapath num2str(YY) '0' num2str(MM) '.xlsx'];
        elseif MM>=10
            file=[datapath num2str(YY) num2str(MM) '.xlsx'];
        end
        
        if exist(file)
            [data,txt,raw]=xlsread(file);
            
            % assessment of U10 -------------------------------
            depth=[3.2;2.9];
            zr=sum(depth)/2; % The anemometers were installed at the height of 3.2 m and 2.9 m, respectively.
            a(1:size(data,1),1)=.1; % the power exponent αo=0.1
            n=1;
            
            for n=1:1:5
                
            for i=1:1:size(data,1)
            u10(i,n)=(data(i,10))*((10/zr).^a(i,n));
            u10s(i,n)=abs(data(i,10)-data(i,15))*((10/zr).^a(i,n));
            end
            clear i 

            % bulk Richardson number (Rib) -------------------------------
            dt=data(:,13)-data(:,14); % tair - tsea
            g=9.81;
            z10=10;
            Rib(:,n)=(g*z10*dt)./((data(:,13)+273.15).*(u10(:,n).^2));
            % stability parameter (z/L) ----------------------------------
            for i=1:1:size(Rib,1)
                if Rib(i,n)<0
                    Satm(i,n)=7.6*Rib(i,n);
                elseif Rib(i,n)>0
                    Satm(i,n)=6.0*Rib(i,n);
                else
                    Satm(i,n)=0;
                end
            end
            clear i
            % the dimensionless wind shear function, Fws ----------------------------------
            % & the stability function, Fstab ----------------------------------
            for j=1:1:size(Satm,1)
                if Satm(j,n)<0 % for unstable (z/L<0)
                    Fws(j,n)=(1-16.*Satm(j,n)).^(-1/4); 
                    Fstab(j,n)=1.0496*(-Satm(j,n)).^(.4591);
                elseif Satm(j,n)>0 % for stable (z/L>0)
                    Fws(j,n)=(1+5.*Satm(j,n)); 
                    Fstab(j,n)=-5*Satm(j,n);
                else
                    Fws(j,n)=0;
                    Fstab(j,n)=0;
                end
            end
            clear j
            a(:,n+1)=.1.*Fws(:,n); % the relationship between the power exponent and the dimensionless wind shear function
            
            n=n+1;
            
            end
            clear n
            % the wave length at the peak frequency, Lp ----------------------------------
            for i=1:1:size(data,1)
                T=data(i,5); %   T = Wave Period, (seconds)
                if ~isnan(T)
                h=41; %   d = Water Depth, (m)
                [Lp(i,1),kr(i,1),sigma(i,1)]=disper(h,T);
%            k = wave number with Newton-Rhapson (1/m)
%            Lp = wavelength with Newton-Rhapson (m)
%            sigma = angular frequency (1/T)
                else
                    Lp(i,1)=nan;kr(i,1)=nan;sigma(i,1)=nan;
                end
            end
            clear i T h 
            
            

            
        end
    end
end
