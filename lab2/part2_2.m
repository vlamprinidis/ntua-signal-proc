% Adjustable quantizer
D=zeros(numWin,M);
Bk=zeros(numWin,M);
firstLevel=zeros(numWin,M);

yQ=zeros(numWin,M,18);
R=2^16; % 16 bits per sample for the original signal s(n)
for frame=1:numWin
    for k=1:M
        iMinTg=(8*(k-1)+1):8*k;
        minTg=min(Tg(frame,iMinTg));
        B=ceil( log2( R/minTg-1) );
        Bk(frame,k)=B;
        
        L=2^B;
        xmin=min(y(frame,k,:));
        xmax=max(y(frame,k,:));
        
        delta=(xmax-xmin)/L;
        
        % Send delta to decoder
        D(frame,k)=delta;
        % Send firstLevel to decoder
        firstLevel(frame,k)=xmin;
        
        % Send coded pulses to decoder
        yQ(frame,k,:)=floor( (y(frame,k,:)-xmin)./delta );
    end
end
