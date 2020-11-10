f=2000;
w=2*pi*f;
c=340;
N= 8;
d=4*10^(-2);
Stheta_=[0 45 90];
theta=[-180:180];
figure
for i=1:3
   Stheta=Stheta_(i);
   B=zeros(1,361);
   for j=1:361
        B(j)=(1/N)*( sin( (N/2)*(w/c)*d*(cosd(theta(j))-cosd(Stheta)) ) / sin( (1/2)*(w/c)*d*(cosd(theta(j))-cosd(Stheta)) ) );
   end
   semilogr_polar(degtorad(theta),abs(B))
   hold on
end
legend('ThetaS=0','ThetaS=45','ThetaS=90')
title('Polar diagram of delay-and-sum beam pattern, Amplitude (dB), Theta(Degrees), N=8, d=4cm, f=2kHz')