figure
surf(fk',t,X,'FaceAlpha',0.5,'FaceColor','flat','EdgeColor','none')
xlabel('Frequency (Hz)')
ylabel('Time (sec)')
zlabel('Amplitude of STFT(speechSignal)')

X_t_size = size(X,1);
figure
to1_start = floor( (0.587/time_size)*X_t_size );
to1_end = ceil( (0.700/time_size)*X_t_size );
surf(fk,t( to1_start : to1_end ),X(to1_start : to1_end,:),'FaceAlpha',0.5,'FaceColor','g','EdgeColor','none')
hold on;

to2_start = floor( (2.625/time_size)*X_t_size );
to2_end = ceil( (2.754/time_size)*X_t_size );
surf(fk,t( to2_start : to2_end ),X(to2_start : to2_end,:),'FaceAlpha',0.5,'FaceColor',[0 0.7 0],'EdgeColor','none')
hold on;

ta1_start = floor( (1.010/time_size)*X_t_size );
ta1_end = ceil( (1.154/time_size)*X_t_size );
surf(fk,t( ta1_start : ta1_end ),X(ta1_start : ta1_end,:),'FaceAlpha',0.5,'FaceColor','r','EdgeColor','none')
hold on;

ta2_start = floor( (1.550/time_size)*X_t_size );
ta2_end = ceil( (1.700/time_size)*X_t_size );
surf(fk,t( ta2_start : ta2_end ),X(ta2_start : ta2_end,:),'FaceAlpha',0.5,'FaceColor',[0.7 0 0],'EdgeColor','none')

legend('/o/','/o/','/a/','/a/')
xlabel('Frequency (Hz)')
ylabel('Time (sec)')
zlabel('Amplitude of STFT(speechSignal)')