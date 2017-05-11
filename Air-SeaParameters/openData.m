clear;clc

s=cd;
datapath=['E:\ResearchwithDrTsai\Buoydata\彰濱浮標記憶卡資料\'];
newfolder=[s '\xlsxFile\'];mkdir(newfolder);

for YY=12:1:13;
    for MM=1:1:12;
        if MM<10
            buoy=[datapath '1C20' num2str(YY) '0' num2str(MM) 'Qc.txt'];
            adcp=[datapath num2str(YY) '0' num2str(MM) '.mCc'];
            savename=[newfolder num2str(YY) '0' num2str(MM) '.xlsx'];
        elseif MM>=10
            buoy=[datapath '1C20' num2str(YY) num2str(MM) 'Qc.txt'];
            adcp=[datapath num2str(YY) num2str(MM) '.mCc'];
            savename=[newfolder num2str(YY) num2str(MM) '.xlsx'];
        end
        
        if exist(buoy) & exist(adcp) & YY==12
            % buoy data --------------------------------------------
            [time, hs_max, ts_max, tp, hs, ts_mean, hdir, u_gust, u_mean, udir, patm, tair, tsea]=textread(buoy,'%f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',',','headerlines',11);
            ts_max(find(hs_max<=0))=nan;
            hs_max(find(hs_max<=0))=nan;hs_max=hs_max*.01;
            tp(find(tp<=0))=nan;
            ts_mean(find(hs<=0))=nan;
            hdir(find(hs<=0))=nan;
            hs(find(hs<=0))=nan;hs=hs*.01;
            udir(find(u_mean<=0))=nan;
            u_mean(find(u_mean<=0))=nan;
            u_gust(find(u_gust<=0))=nan;
            patm(find(patm<=0))=nan;
            tair(find(tair<=0))=nan;
            tsea(find(tsea<=0))=nan;
            % ADCP data --------------------------------------------
            cdata=load(adcp);
            dx=1:10:size(cdata,1);
            for i=1:1:size(dx,2)
                us(i,1)=cdata(dx(i),2)*.01;
                usdir(i,1)=cdata(dx(i),3);
            end
            clear i dx cdata
            us(find(us<=0))=nan;
            usdir(find(us<=0))=nan;
            
            for i = 1:1:size(time,1)
                % add time (format :yyyy/mm/dd hh:mn) 
                str=num2str(time(i));
                time2(i,1)={[str(1:4) '/' str(5:6) '/' str(7:8) ' ' str(9:10) ':00']};
                clear str
%                 % assessment of U10
%                 zr=sum(3.2+2.9)/2; % The anemometers were installed at the height of 3.2 m and 2.9 m, respectively.
%                 a0=.1; % the power exponent αo=0.1
%                 u10(i,1)=(u_mean(i,1))*((10/zr)^a0);
%                 u10s(i,1)=abs(u_mean(i,1)-us(i,1))*((10/zr)^a0);
            end
            clear i zr a0 
            
            data(1:size(time,1),1:14)=[hs_max, ts_max, tp, hs, ts_mean, hdir, u_gust, u_mean, udir, patm, tair, tsea, us, usdir];
            list(1,1:16)={'time','yyyy/mm/dd hh:mn','hs_max', 'ts_max', 'tp', 'hs', 'ts_mean', 'hdir', 'u_gust', 'u_mean', 'udir', 'patm', 'tair', 'tsea', 'us', 'usdir'};
            list(2:size(time,1)+1,1)=num2cell(time);
            list(2:size(time,1)+1,2)=time2;
            list(2:size(time,1)+1,3:16)=num2cell(data);
            clear data time time2 hs_max ts_max tp hs ts_mean hdir u_gust u_mean udir patm tair tsea us usdir 
            % save file ---------------------------------------------------
            xlswrite(savename,list)
            clear savename list
            
        elseif exist(buoy) & exist(adcp) & YY==13
            [time, hs_max, ts_max, tp, hs, ts_mean, hdir, u_gust, u_mean, udir, patm, tair, tsea, c, cdir]=textread(buoy,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',',','headerlines',11);
            ts_max(find(hs_max<=0))=nan;
            hs_max(find(hs_max<=0))=nan;hs_max=hs_max*.01;
            tp(find(tp<=0))=nan;
            ts_mean(find(hs<=0))=nan;
            hdir(find(hs<=0))=nan;
            hs(find(hs<=0))=nan;hs=hs*.01;
            udir(find(u_mean<=0))=nan;
            u_mean(find(u_mean<=0))=nan;
            u_gust(find(u_gust<=0))=nan;
            patm(find(patm<=0))=nan;
            tair(find(tair<=0))=nan;
            tsea(find(tsea<=0))=nan;
            cdir(find(c<=0))=nan;
            c(find(c<=0))=nan;c=c*.01;
            % ADCP data --------------------------------------------
            cdata=load(adcp);
            dx=1:10:size(cdata,1);
            for i=1:1:size(dx,2)
                us(i,1)=cdata(dx(i),2)*.01;
                usdir(i,1)=cdata(dx(i),3);
            end
            clear i dx cdata
            us(find(us<=0))=nan;
            usdir(find(us<=0))=nan;
            
            for i = 1:1:size(time,1)
                % add time (format :yyyy/mm/dd hh:mn) 
                str=num2str(time(i));
                time2(i,1)={[str(1:4) '/' str(5:6) '/' str(7:8) ' ' str(9:10) ':00']};
                clear str
%                 % assessment of U10
%                 zr=sum(3.2+2.9)/2; % The anemometers were installed at the height of 3.2 m and 2.9 m, respectively.
%                 a0=.1; % the power exponent αo=0.1
%                 u10(i,1)=(u_mean(i,1))*((10/zr)^a0);
%                 u10s(i,1)=abs(u_mean(i,1)-us(i,1))*((10/zr)^a0);
            end
            clear i zr a0 
            
            data(1:size(time,1),1:16)=[hs_max, ts_max, tp, hs, ts_mean, hdir, u_gust, u_mean, udir, patm, tair, tsea, us, usdir, c, cdir];
            list(1,1:18)={'time','yyyy/mm/dd hh:mn','hs_max', 'ts_max', 'tp', 'hs', 'ts_mean', 'hdir', 'u_gust', 'u_mean', 'udir', 'patm', 'tair', 'tsea', 'us', 'usdir', 'c', 'cdir'};
            list(2:size(time,1)+1,1)=num2cell(time);
            list(2:size(time,1)+1,2)=time2;
            list(2:size(time,1)+1,3:18)=num2cell(data);
            clear data time time2 hs_max ts_max tp hs ts_mean hdir u_gust u_mean udir patm tair tsea us usdir c cdir
            % save file ---------------------------------------------------
            xlswrite(savename,list)
            clear savename list
            
        end 
        clear buoy adcp
    end
    clear MM
end
clear YY
