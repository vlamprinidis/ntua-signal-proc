wins=zeros(numWin,512);
for i=1:numWin
    wins(i,:)=sigs(i,:);
end
% Create filters
M=32;
L=2*M;
h=zeros(M,L);
g=zeros(M,L);
for k=0:M-1
    for n=0:L-1
       % We assume that h(k+1,n+1) is actually h_k(n) because indexing
       % starts at 1
       h(k+1,n+1)=sqrt(2/M)*sin( (n+1/2)*pi/(2*M) ) .*cos( (2*n+M+1)*(2*k+1)*pi/(4*M) );
       g(k+1,L-n)=h(k+1,n+1);
    end
end