clear all; close all;

Fs = 1000;
t = [0:1/Fs:2];
u = randn(1,length(t));
x = 1.5*cos(2*pi*80*t) + 2.5*sin(2*pi*150*t) + 0.15*u;

figure
plot(t,x)
xlabel('t(sec)')
ylabel('x(t)')
title('1.5cos(2pi*80*t) + 2.5sin(2pi*150*t) + 0.15u')