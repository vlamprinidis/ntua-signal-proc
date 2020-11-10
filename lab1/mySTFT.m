function stft = mySTFT(signal,L,R)
    hammW=hamming(L);
    
    for i=1:ceil(length(signal)/R)
        clear frame;
        % In case A or B exceeds the limits of the signal
        A = min(R*(i-1)+1,length(signal));
        B = min(R*(i-1)+L,length(signal));
        if A >= B % If A==B there is nothing left to do, A > B in case something went wrong
            break;
        end
        % Take a part from the signal, starting from sample A and ending at sample B
        frame = signal( A : B );
        % If B reached the end of the signal, which means the frame is smaller than L, add
        % zeros at the end of the frame to make it of size L
        if length(frame) < length(hammW)
            frame( length(frame) + 1 : length(hammW) ) = 0;
        end
        % Apply hamming window of size L to the frame
        frameWin = hammW.*frame ;
        % Compute the fft for each frame and place it at the i-th row of
        % the resulting matrix
        frameDFT(i,:) = fft(frameWin,length(signal));
    end

    stft = frameDFT;
end