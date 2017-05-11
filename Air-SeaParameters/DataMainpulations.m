clear;clc

s=[cd];
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
            Tp=data(:,5); %   Wave Period, (seconds)
            hs=data(:,6);
            ur=data(:,10);
            us=data(:,15);
            Tair=data(:,13);
            Tsea=data(:,14);
            Dwater=41; %   Water Depth, (m)
            Hsensor=[3.2;2.9];
            zh=10; % (m), the height of 10m
            
            % algorithm of air-sea parameters
            [ustar, uz, Rib, Psta, Fws, Fstab, alpha, Lp, kr, sigma, z0, Cp ]...
                =airseaparameter(Tp, hs, ur, us, Tair, Tsea, Dwater, Hsensor, zh);
            
        end
    end
end
