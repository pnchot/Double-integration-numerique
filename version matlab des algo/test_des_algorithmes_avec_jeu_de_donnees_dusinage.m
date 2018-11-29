clear 
close all
%%
F = Mesure_1;%(135986:136990);%vibre 504 points(138626:139129)
                            %tres vibre 435 points(77686:78120)
                            %pas vibre 1005 points(135986:136990)
                          
f = 19200;                  %frequence d'acquisition 19200 points/s
Ts = 1/f;
N = length(F);
kTs = 0 : Ts : (length(F)*Ts-Ts);


figure, plot(kTs,F);
title('Signal d acceleration')
xlabel('t(s)')
ylabel('m/s²')
%%
[X,V] = Runge_Kutta(F,0.001);

figure(1),  
subplot(1,2,1), plot(kTs,V);
title('Premiere integration  Runge Kutta')
xlabel('t(s)');
ylabel('mm');
subplot(1,2,2),plot(kTs,X)
title('Deuxieme integration Runge Kutta')

xlabel('t(s)');
ylabel('mm');



% figure, plot(kTs,F)
% title('Signal d acceleration')
% 
% figure, plot(kTs,V)
% title('Premiere integration')
% 
% figure, plot(kTs,X)
% title('Deuxieme integration')
%%

[X,V] = Trapeze(F,Ts);

figure(2),

subplot(1,2,1),plot(kTs,V);
title('Première integration')
xlabel('t(s)');
ylabel('m/s');

subplot(1,2,2),plot(kTs,X)
title(' Deuxième integration du signal')
xlabel('t(s)');
ylabel('m');

%% Affichage 

A = zeros();
B = zeros();
r = 0;
n=435;
for i=1:n
    A(i) = (30000*X(i)+0.25)*sin(2*pi*r);
    B(i) = (30000*X(i)+0.25)*cos(2*pi*r);
    r = r + 1/n;
end
figure,plot(A,B);

%% FFT du deplacement 

X_fft = fft(X);
figure, stem((0:(N-1))/N/Ts,(2/N)*abs(X_fft));