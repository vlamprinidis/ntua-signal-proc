clear all; close all;
[speechSignal,Fs]=audioread('speech_utterance.wav');

% Window length = 40ms*16kH, R = 20ms*16kHz
F_sig = mySTFT(speechSignal,40*16,20*16); 

% Duration of speech signal
time_size = length(speechSignal)/Fs;

% Can analyze the signal for frequencies fk <= Fs/2
k = (1: ceil( 0.5* size(F_sig,2) ) );
fk = k*Fs/size(F_sig,2);

% Time vector for the plots
t =  ( (0:size(F_sig,1)-1)/size(F_sig,1) ) * time_size ;

% Amplitude of the STFT
X_ = abs(F_sig);

% We only need half of the samples, the other half is for the negative frequencies
X_size = ceil( size(X_,2)/2 );
X = X_( :, 1:X_size );