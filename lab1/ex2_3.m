% Inverse STFT
signal_length = length(speechSignal);
result = zeros(signal_length,1);
L = 640; R = 20*16;
for i=1:size(F_sig,1)
    clear idft;
    % Compute the correct position of the frame, compute inverse fft and
    % simply add the results 
    A = min(R*(i-1)+1,signal_length);
    B = min(R*(i-1)+L,signal_length);
    if A>=B
        break;
    end
    idft = ifft(F_sig(i,:))';
    result( A:B ) = result( A:B ) + idft( 1 : min(B-A+1,length(idft)) );
end
sound(result,Fs)
audiowrite('speech_utterance_rec.wav',result,Fs)