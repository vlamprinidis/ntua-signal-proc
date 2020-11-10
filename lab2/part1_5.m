clear Tg
Tg=zeros(numWin,256); % Preallocation
for window=1:numWin
   TtmArr=Ttm{window};
   TnmArr=Tnm{window};
   for i=1:256
      sumTm=0;
      sumNm=0;
      for l=1:size(TtmArr,2)
           sumTm = sumTm + 10^( 0.1*TtmArr(i,l) ) ;
      end
      for m=1:size(TnmArr,2)
           sumNm = sumNm + 10^( 0.1*TnmArr(i,m) ) ;
      end
      Tg(window,i) = 10*log10( 10^( 0.1*Tq(i) ) + sumTm + sumNm );
   end
end
clear sumTm sumNm