[signal,Fs]=audioread('music_dsp18.wav');
signal=mean(signal,2); % Since this is a 2-channel signal
signal=signal/max(abs(signal));
N=512;
sigs=( buffer(signal,N) )' ;
numWin=size(sigs,1);
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

clear y
y=zeros(numWin,M,18);
% Convolute with window for every frame
for frame=1:numWin
    for k=0:M-1
        u=conv( h(k+1,:),wins(frame,:));
        y(frame,k+1,:)=downsample( u , M );
        clear u
    end
end

% Quantizer
clear yQ y_new B L delta xmin xmax
y_new=zeros(numWin,M,18);
yQ=zeros(numWin,M,18);
B=8;
L=2^8;
% Send delta to decoder
delta=2/L;
% Send first level to decoder
xmin=-1;
for frame=1:numWin
    for k=1:M
        % Send coded pulses to decoder
        yQ(frame,k,:)=floor( (y(frame,k,:)-xmin)./delta );
    end
end

% Decoder
clear result
result = zeros(1,512*numWin+639);
i=1;
L=512;
for frame=1:numWin
   XX=zeros(1,639);
   for k=1:M
       % Receive signal, delta and first level (xmin), then decode
       y_new(frame,k,:)=yQ(frame,k,:)*delta+xmin+delta/2;
       wo=upsample(y_new(frame,k,:),M);
       recon=conv( wo(:),g(k,:) );
       XX=XX+recon';
   end
   % Synthesis
    result( i:i+639-1 ) = result( i:i+639-1 ) + XX ;
    i=i+L;
end
result=result/max(abs(result));
method2=result;
audiowrite('NonPerceptualAudio.wav',result,Fs);