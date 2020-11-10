clear all; close all;

figure
ola(40*16,20*16,3*40*16)
figure
ola(40*16,30*16,3*40*16)

[speechSignal,Fs]=audioread('speech_utterance.wav');

% Window length = 40ms*16kH, R = 30ms*16kHz
F_sig = mySTFT(speechSignal,40*16,30*16); 

% Amplitude of the STFT
X_ = abs(F_sig);

% We only need half of the samples, the other half is for the negative frequencies
X_size = ceil( size(X_,2)/2 );
X = X_( :, 1:X_size );

% Inverse STFT
signal_length = length(speechSignal);
result = zeros(signal_length,1);
L = 640; R = 30*16;
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
audiowrite('speech_utterance_R_30ms.wav',result,Fs)