clear;clc

s=[cd];
datapath=[s '\xlsxFile\'];
newfolder=[s '\Air-SeaParameter\'];mkdir(newfolder);

for YY=12:1:13
    for MM=1:1:12
        if MM<10
            file=[datapath num2str(YY) '0' num2str(MM) '.xlsx'];
            savename=[newfolder num2str(YY) '0' num2str(MM) '.mat'];
        elseif MM>=10
            file=[datapath num2str(YY) num2str(MM) '.xlsx'];
            savename=[newfolder num2str(YY) num2str(MM) '.mat'];
        end
        
        if exist(file) 
            [data,txt,raw]=xlsread(file);
            Tp=data(:,5); %   Wave Period, (seconds)
            hs=data(:,6);
            hdir=data(:,8);
            ur=data(:,10);
            udir=data(:,11);
            us=data(:,15);
            Tair=data(:,13);
            Tsea=data(:,14);
            Dwater=41; %   Water Depth, (m)
            Hsensor=[3.2;2.9];
            zh=10; % (m), the height of 10m
            
            % algorithm of air-sea parameters --------------------------------------------------
            [ustar, uz, Rib, Psta, Fws, Fstab, alpha, Lp, kr, sigma, z0, Cp, zr ]...
                =airseaparameter(Tp, hs, ur, us, Tair, Tsea, Dwater, Hsensor, zh);
            
            % save file --------------------------------------------------
            parameter.ustar=ustar;
            parameter.uz=uz;
            parameter.ur=ur;
            parameter.udir=udir;
            parameter.us=us;
            parameter.zh=zh;
            parameter.zr=zr;
            parameter.z0=z0;
            parameter.Rib=Rib;
            parameter.Psta=Psta;
            parameter.Fws=Fws;
            parameter.Fstab=Fstab;
            parameter.alpha=alpha;
            parameter.Lp=Lp;
            parameter.Tp=Tp;
            parameter.Cp=Cp;
            parameter.kr=kr;
            parameter.sigma=sigma;
            parameter.hs=hs;
            parameter.hdir=hdir;
            parameter.Dwater=Dwater;
            parameter.Tair=Tair;
            parameter.Tsea=Tsea;
            
            save(savename, 'parameter')

        end
    end
end
