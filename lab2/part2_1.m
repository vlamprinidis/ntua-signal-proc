clear y
y=zeros(numWin,M,18);
% Convolute with windows for every frame
for frame=1:numWin
    for k=0:M-1
        u=conv( h(k+1,:),wins(frame,:));
        y(frame,k+1,:)=downsample( u , M );
        clear u
    end
end