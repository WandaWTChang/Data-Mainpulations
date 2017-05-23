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
            u=parameter.udir;
            h=parameter.hdir;
            % calculate a relative angle between the wind and wave
            % direction, dw
            for i=1:1:size(parameter.ur,1)
                if 0<=u(i,1) & u(i,1)<=180
                    if u(i,1)==h(i,1)
                        dw(i,1)=0;
                    elseif h(i,1)==180+u(i,1)
                        dw(i,1)=180;
                    elseif 0<=h(i,1) & h(i,1)<u(i,1)
                        dw(i,1)=u(i,1)-h(i,1);
                    elseif u(i,1)<h(i,1) & h(i,1)<(180+u(i,1))
                        dw(i,1)=h(i,1)-u(i,1);
                    elseif (180+u(i,1))<h(i,1) & h(i,1)<=360
                        dw(i,1)=360-h(i,1)+u(i,1);
                    elseif isnan(u(i,1)) | isnan(h(i,1))
                        dw(i,1)=nan;
                    end
                elseif 180<u(i,1) & u(i,1)<=360
                    if u(i,1)==h(i,1)
                        dw(i,1)=0;
                    elseif h(i,1)==u(i,1)-180
                        dw(i,1)=180;
                    elseif 0<=h(i,1) & h(i,1)<(u(i,1)-180)
                        dw(i,1)=360-u(i,1)+h(i,1);
                    elseif (u(i,1)-180)<h(i,1) & h(i,1)<u(i,1)
                        dw(i,1)=u(i,1)-h(i,1);
                    elseif u(i,1)<h(i,1) & h(i,1)<=360
                        dw(i,1)=h(i,1)-u(i,1);
                    elseif isnan(u(i,1)) | isnan(h(i,1))
                        dw(i,1)=nan;
                    end
                end
            end
             clear i u h
             
            % wind and wave spectrum
            spectrum=parameter.uz(:,end).*cos(dw);
            group(:,1)=parameter.uz(:,end).*cos(dw)./parameter.Cp;
            case1(:,1)=(find(group<.8));
            case2(:,1)=(find(group>.8 & group<1.2));
            case3(:,1)=(find(group>1.2 & group<1.6));
            
            % case 1 : U10*cos(dw)/Cp<0.8
            
            % case 2 : 0.8<U10*cos(dw)/Cp<1.2
            
            % case 3 : 1.2<U10*cos(dw)/Cp<1.6
            
        end
        
    end
end