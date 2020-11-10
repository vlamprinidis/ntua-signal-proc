clear Ttm Tnm
Ttm=cell(numWin,1);
Tnm=cell(numWin,1);
for window=1:numWin
    % Find all j: Ptm(j)>0 and j:Pnm(j)>0
    % Then save them in a list
    jPtm=[];
    jPnm=[];
    for k=1:256
        if Ptm(window,k)>0
            jPtm(length(jPtm)+1)=k;
        end
    end
    for k=1:256
        if Pnm(window,k)>0
            jPnm(length(jPnm)+1)=k;
        end
    end
    TtmArr=zeros(256,length(jPtm));
    for i=1:256
        for k=1:length(jPtm)
            j=jPtm(k);
            Db=bark(i)-bark(j);
            if Db<-3 || Db>=8
                continue
            end
            if Db>=-3 && Db<-1
                SFtm = 17*Db-0.4*Ptm(window,j)+11;
            end
            if Db>=-1 && Db<0
                SFtm = Db*(0.4*Ptm(window,j)+6);                
            end
            if Db>=0 && Db<1 
                SFtm = -17*Db;
            end
            if Db>=1 && Db<8
                SFtm = (0.15*Ptm(window,j)-17)*Db-0.15*Ptm(window,j);
            end
            TtmArr(i,k) = Ptm(window,j)-0.275*bark(j)+SFtm-6.025;
        end
    end
    Ttm(window)={TtmArr};
    TnmArr=zeros(256,length(jPnm));
    for i=1:256
        for k=1:length(jPnm)
            j=jPnm(k);
            Db=bark(i)-bark(j);
            if Db<-3 || Db>=8
                continue
            end
            if Db>=-3 && Db<-1
                SFnm = 17*Db-0.4*Pnm(window,j)+11;
            end
            if Db>=-1 && Db<0
                SFnm = Db*(0.4*Pnm(window,j)+6);                
            end
            if Db>=0 && Db<1 
                SFnm = -17*Db;
            end
            if Db>=1 && Db<8
                SFnm = (0.15*Pnm(window,j)-17)*Db-0.15*Pnm(window,j);
            end
            TnmArr(i,k) = Pnm(window,j)-0.175*bark(j)+SFnm-2.025;
        end
    end
    Tnm(window)={TnmArr};
    clear jPtm jPnm SFtm SFnm TtmArr TnmArr
end