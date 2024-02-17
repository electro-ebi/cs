clc;
clear all;
close all;

fm=500;
t=25/fm;
ti=0:0.0001:t;
x=sin(2*pi*fm*ti);
figure
subplot(3,1,1);
plot(ti,x);
xlabel('time period(sec)');
ylabel('Amplitude (volts)');
title('Input signal');


fs=5000;
ts=1/fs;
t1=0:ts:t;
x1=sin(2*pi*fm*t1);
subplot(3,1,2);
stem(t1,x1);
xlabel('sampling period(n)');
ylabel('Amplitude (volts)');
title('sample signal');

xr=zeros(length(ti));
for i=1:length(ti)
    for j=1:length(x1)
        tr=10^-4;
        xr(i)=xr(i)+x1(j)*sinc(((i-1)*tr-(j-1)*ts)/ts);
    end
end
subplot(3,1,3);
plot(ti,xr);
xlabel('time period(sec)');
ylabel('Amplitude (volts)');
title('reconstructed signal');