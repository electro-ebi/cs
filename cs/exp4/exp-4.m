clc;
clear all;
close all
f=600;
t=0:1e-4:25/f;
w=2*pi*f;
sig1=sin(w*t);
figure,
subplot(321);
plot(sig1);
xlabel('time');
title('original signal');
ylabel('Amplitude');

fs=6500;
Ts=1/fs;
t2=0:Ts:25/f;
sig=sin(w*t2);
subplot(323);
stem(t2,sig);
xlabel('time');
title('sampled signal');
ylabel('amplitude');

Vh=max(sig);
Vl=min(sig);
N=4;
M=2^N;
S=(Vh-Vl)/M;
partition=[Vl+S:S:Vh-S];
codebook=[Vl+S/2:S:Vh-S/2];
[index,quantizes_sig,distor]=quantiz(sig,partition,codebook);
subplot(325);
stem(t2,quantizes_sig);
xlabel('time');
title('quantized signal');
ylabel('Amplitude');

codesig=de2bi(index,'left-msb');
codesig=codesig';
txbits=codesig(:);
tt=[0:N*length(t2)-1];
subplot(322);
stairs(tt,txbits);
axis([0 30 -2 3 ]);
xlabel('time');
title('PCM waveform');
rxbits=reshape(txbits,N,length(sig));
rxbits=rxbits';
index1=bi2de(rxbits,'left-msb');
index2=S*index1+Vl+(S/2);
reconstructedsig=index2;
subplot(324);
plot(t2,reconstructedsig);
xlabel('time');
title('received signal');

