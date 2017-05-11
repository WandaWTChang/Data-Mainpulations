%% create time list
%% written by Wanda (2016)
function [ timenum ]=createdatelist(Y1,M1,Y2,M2,Trate,Tgap)
% clear;clc
% Y1=2014;M1=1;
% Y2=2015;M2=10;
% Trate='hr';
% Tgap=1;

% matlabpool open 

% time gap -----------------------------------------------------------
if strcmp(Trate,'hr')==1 
    ho=0:Tgap:24-Tgap; mo=0;      
elseif strcmp(Trate,'min')==1
    mo=0:Tgap:60-Tgap;ho=linspace(0,23,24);
    gap=size(mo,2);
end
% time list ----------------------------------------------------------
if size(mo,2)==1
    for i=1:1:size(ho,2)
        if ho(i)<10
            time(i,1)={['0' num2str(ho(i)) '00' ]};
        elseif ho(i)>=10
            time(i,1)={[num2str(ho(i)) '00' ]};
        end
    end
elseif  size(mo,2)>1
    for i=1:1:size(ho,2)
        for ii=1:1:size(mo,2)
            if ho(i)<10 & mo(ii)<10 
                time((i-1)*gap+ii,1)={['0' num2str(ho(i)) '0' num2str(mo(ii)) ]};
            elseif ho(i)<10 & mo(ii)>=10 
                time((i-1)*gap+ii,1)={['0' num2str(ho(i))  num2str(mo(ii)) ]};
            elseif ho(i)>=10 & mo(ii)<10 
                time((i-1)*gap+ii,1)={[num2str(ho(i)) '0' num2str(mo(ii)) ]};
            elseif ho(i)>=10 & mo(ii)>=10 
                time((i-1)*gap+ii,1)={[num2str(ho(i))  num2str(mo(ii)) ]};
            end
        end
    end
end
clear i ii 
% date list ------------------------------------------------------------
 Yo=linspace(Y1,Y2,Y2-Y1+1);
 Mo=linspace(1,12,12);
 
 for loop=1:Y2-Y1+1
     MO(1+12*(loop-1):1+12*(loop-1)+11,1)=Mo;
     YO(1+12*(loop-1):1+12*(loop-1)+11,1)=Yo(loop);
 end
 clear loop

 % Feb. Days
Day29=[2002 2008 2012 2016];
     if Y1==Y2
         MMM(:,1)=linspace(M1,M2,M2-M1+1);
         YYY(:,1)=linspace(Y1,Y2,Y2-Y1+1);
 for i=1:1:size(MMM,1)
 if MMM(i)==1 | MMM(i)==3 | MMM(i)==5 | MMM(i)==7  | MMM(i)==8 | MMM(i)==10 | MMM(i)==12
 Do(i,1)=31;
 elseif MMM(i)==4 | MMM(i)==6 | MMM(i)==9  | MMM(i)==11  
 Do(i,1)=30;
 elseif isempty(find(YYY==Day29))==0 & MMM(i)==2
 Do(i,1)=29;
 elseif isempty(find(YYY==Day29))==1 & MMM(i)==2
 Do(i,1)=28;     
 end
 end
 clear i num
     
     elseif Y2>Y1
         MMM(:,1)=MO(M1:12*(Y2-Y1)+M2);
         YYY(:,1)=YO(M1:12*(Y2-Y1)+M2);
 for i=1:1:size(MMM,1)
 if MMM(i)==1 | MMM(i)==3 | MMM(i)==5 | MMM(i)==7  | MMM(i)==8 | MMM(i)==10 | MMM(i)==12
 Do(i,1)=31;
 elseif MMM(i)==4 | MMM(i)==6 | MMM(i)==9  | MMM(i)==11  
 Do(i,1)=30;
 elseif isempty(find(YYY(i)==Day29))==0 & MMM(i)==2
 Do(i,1)=29;
 elseif isempty(find(YYY(i)==Day29))==1 & MMM(i)==2
 Do(i,1)=28;     
 end
 end
 clear i num
     
     end
 
% date list ------------------------------------------------------------
     for b=1:1:size(MMM,1)
             DDD=linspace(1,Do(b),Do(b));
             for c=1:1:size(DDD,2)
                 if b==1  & DDD(c)<10
                 date(c,1)={[num2str(YYY(b))  '0' num2str(MMM(b))  '0' num2str(DDD(c)) ]};
                 elseif b==1 & DDD(c)>=10
                     date(c,1)={[num2str(YYY(b))  '0' num2str(MMM(b))   num2str(DDD(c)) ]};
% Y2>Y1 ------------------------------------------------------------                
                 elseif b>1 & Y2>Y1 & MMM(b)<10 & DDD(c)<10
                 date(L+c,1)={[num2str(YYY(1)) '0' num2str(MMM(b)) '0' num2str(DDD(c)) ]};
                 elseif b>1 & Y2>Y1 & MMM(b)<10 & DDD(c)>=10
                     date(L+c,1)={[num2str(YYY(1)) '0' num2str(MMM(b))  num2str(DDD(c)) ]};
                 elseif b>1 & Y2>Y1 & MMM(b)>=10 & DDD(c)<10
                     date(L+c,1)={[num2str(YYY(1)) num2str(MMM(b)) '0' num2str(DDD(c)) ]};
                 elseif b>1 & Y2>Y1 & MMM(b)>=10 & DDD(c)>=10
                     date(L+c,1)={[num2str(YYY(1)) num2str(MMM(b))  num2str(DDD(c)) ]};
% Y2==Y1 ------------------------------------------------------------                
                 elseif b>1 & Y2==Y1 & MMM(b)<10 & DDD(c)<10
                 date(L+c,1)={[num2str(YYY(1)) '0' num2str(MMM(b)) '0' num2str(DDD(c)) ]};
                 elseif b>1 & Y2==Y1 & MMM(b)<10 & DDD(c)>=10
                     date(L+c,1)={[num2str(YYY(1)) '0' num2str(MMM(b))  num2str(DDD(c)) ]};
                 elseif b>1 & Y2==Y1 & MMM(b)>=10 & DDD(c)<10
                     date(L+c,1)={[num2str(YYY(1)) num2str(MMM(b)) '0' num2str(DDD(c)) ]};
                 elseif b>1 & Y2==Y1 & MMM(b)>=10 & DDD(c)>=10
                     date(L+c,1)={[num2str(YYY(1)) num2str(MMM(b))  num2str(DDD(c)) ]};
                 end
             end
             L=size(date,1);
             clear c
     end
     clear L b
     
% time list ------------------------------------------------------------ 
%  tic
timeformat='yyyymmddHHMM';
 for i=1:1:size(date,1)
     for j=1:1:size(time,1)
         timenum((i-1)*size(time,1)+j,1)=datenum([cell2str(date(i,1))  cell2str(time(j,1))],timeformat);
%          timenum((i-1)*size(time,1)+j,1)=datenum(timelist((i-1)*size(time,1)+j,1));
     end
 end
 
% datestr(timenum,timeformat)

% toc
% matlabpool close
     
end