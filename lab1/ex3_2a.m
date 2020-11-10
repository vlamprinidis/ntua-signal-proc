clear all; close all;

Fs = 1000;
t = [0:1/Fs:2];
u = randn(1,length(t));
x = 1.5*cos(2*pi*40*t) + 1.5*cos(2*pi*100*t) + 0.15*u ;
% Delta function for discrete signal
x(0.625*Fs) = x(0.625*Fs) + 5; % Because x[n] = x(nTs)
x(0.650*Fs) = x(0.650*Fs) + 5;

figure
plot(t,x)
xlabel('t(sec)')
ylabel('x(t)')
title('1.5cos(2pi*40*t) + 1.5cos(2pi*100*t) + 0.15u + 5 * ( delta(t-0.625) + delta(t-0.650) ), Fs=1000Hz')