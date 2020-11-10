clear winsF winsFamp P
PN=90.302;
for i=1:numWin;
   winsF(i,:)=fft( wins(i,:), N);
   winsFamp(i,:)=abs( winsF(i,:) );
   P(i,:)= PN + 20*log10( winsFamp(i,1:(N/2)) ) ;
end
clear bark
bark = 13*atan(0.00076*f) + 3.5*atan( (f/7500).^2 );