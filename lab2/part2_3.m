clear result
result = zeros(1,512*numWin+639);
i=1;
L=512;
y_new=zeros(numWin,M,18);
for frame=1:numWin
   XX=zeros(1,639);
   for k=1:M
       % Decode received pulses using delta and first level
       delta=D(frame,k);
       xmin=firstLevel(frame,k);
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
method1=result;
audiowrite('PerceptualAudio.wav',result,Fs);