% calculate a relative angle between the wind and wave direction
% write by Wanda, 2017.5.19
clear;clc
s=[cd];
datapath=[s '\Air-SeaParameter\'];

for YY=12%:1:13
    for MM=8%:1:12
        if MM<10
            file=[datapath num2str(YY) '0' num2str(MM) '.mat'];
%             savename=[newfolder num2str(YY) '0' num2str(MM) '.mat'];
        elseif MM>=10
            file=[datapath num2str(YY) num2str(MM) '.mat'];
%             savename=[newfolder num2str(YY) num2str(MM) '.mat'];
        end
        
        if exist(file)
            load(file)
            for i=1:1:size(parameter.ur,1)
                u=parameter.ur(i,1);
                
            end
        end
        
    end
end