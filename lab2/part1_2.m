clear Ptm Pnm
for window=1:numWin 
    clear D
    for k=3:62 
        D(k)={2};
    end
    for k=63:126
        D(k)={2:3};
    end
    for k=127:256
        D(k)={2:6};
    end
    
    clear ST
    ST(1:3)=false;
    for k=4:256
        clear a b
        if ( k+1>256 ) || ( k+1 < 1 )
            a=0;
        else
            a=P(window,k+1);
        end
        if ( k-1>256 ) || ( k-1 < 1 )
            b=0;
        else
            b=P(window,k-1);            
        end
        ST(k)= ( P(window,k)> a ) && ( P(window,k)> b );
        clear d
        d = D{1,k};
        for i=1:length(d)
            clear a b
            if ( k+d(i)>256 ) || ( k+d(i)<1 )
                a=0;
            else
                a=P(window,k+d(i));
            end
            if ( k-d(i)>256 ) || ( k-d(i)<1 )
                b=0;
            else
                b=P(window,k-d(i));                
            end
            ST(k) = ST(k) && ( P(window,k) > ( a + 7 ) ) && ( P(window,k) > ( b + 7 ) );
        end
    end

    for k=1:256
        if ST(k)==false
            Ptm(window,k)=0;
        else
            
            clear a b
            if ( k+1>256 ) || ( k+1 < 1 )
                a=0;
            else
                a=P(window,k+1);
            end
            if ( k-1>256 ) || ( k-1 < 1 )
                b=0;
            else
                b=P(window,k-1);            
            end
            
            Ptm(window,k) = 10*log10( 10^(0.1*b) + 10^(0.1*P(window,k)) + 10^(0.1*a) ) ;
        end
    end
    Pnm(window,:)=findNoiseMaskers(P(window,:),Ptm(window,:),bark);
end
clear a b d D