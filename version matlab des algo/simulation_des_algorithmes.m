%% 
clear 
close all;
%% Generation du signale de sortie 

T1 = 1/50;       % Frequence du sinus 
Ts1 = 0.005;    % la frequence doit respecter le critere de shannon
tfinal1 = 0.02; % Il faut que tfinal = N*Ts

% Signal 1 :

A = 0.02 ; % mm 
t1 = 0 : 0.0001 : tfinal1 ;
D1 = A*sin(2*pi*(1/T1)*t1);

figure, plot(t1,D1)

% Signal 2 :

T2 = 1/800 ;
Ts2 = 3.1250e-04 ;
tfinal2 = 16*0.02 ;
t2 = 0 : 0.000001 : tfinal2 ;

B1 = 0.1 ;
D2 = B1*sin(2*pi*(1/T2)*t2);
figure,  plot(t2,D2);

%B2 = 0.3 ;

% if sin(2*pi*(1/T2)*t2) > 0
%     D2 = B1*sin(2*pi*(1/T2)*t2);
%     plot(t2,D2)
%     hold on
% else
%     %sin(2*pi*(1/T2)*t) < 0
%     D2 = B2*sin(2*pi*(1/T2)*t2);
%     plot(t2,D2);
% end

%% Siganl Etudie

Ts = 1/24000;
tfinal = 1;%0.0853;%0.0427;

kTs = 0:Ts:(tfinal-Ts);
N = length(kTs);

% Echantillonnage du signal 

D =  A*sin(2*pi*(1/T1)*kTs)+B1*sin(2*pi*(1/T2)*kTs);
figure, stem(kTs,D);

% Echantillonnage du Signal derive :

D_2_prim = -4*((pi*(1/T1))^2)*A*sin(2*pi*(1/T1)*kTs)-4*((pi*(1/T2))^2)*B1*sin(2*pi*(1/T2)*kTs);
figure, stem(kTs,D_2_prim);


% Transformee de Fourier Discret ( FFT )

X = fft(D_2_prim);

figure, stem((0:(N-1))/N/Ts,(2/N)*abs(X)) %2*(Ts/tfinal) = 2/N 

     %%%%%%%%%%%%%%%%%%%%%%  
     % Double Integration %
     %%%%%%%%%%%%%%%%%%%%%%
     
     
%% Methode Runge Kutta :

[d1,v1] = Runge_Kutta(D_2_prim,0.001);

figure(1), plot(kTs,v1)
title('Premiere integration')

figure(2), %plot(kTs,d1,kTs,D)
subplot(1,2,1),plot(kTs,d1)
title('Deuxieme integration Runge Kutta')
xlabel('t(s)');
ylabel('mm');
subplot(1,2,2),plot(kTs,D);
title('Signal initial')
xlabel('t(s)');
ylabel('mm');
%% Methode des Trapezes :

[d2,v2] = Trapeze(D_2_prim,Ts);

figure(3),plot(kTs,v2);
title('Première integration')
xlabel('t(s)');
ylabel('mm/s');
figure(4),
subplot(1,2,1),plot(kTs,d2);
title('Deuxieme integration')
xlabel('t(s)');
ylabel('mm');
subplot(1,2,2),plot(kTs,D);
title('signal initial')
xlabel('t(s)');
ylabel('mm');
% 
% 
% subplot(121),plot(kTs,d2)
% title('Deuxieme integration Trapeze')
% xlabel('t(s)');
% ylabel('mm');
% subplot(122),plot(kTs,D);
% title('Signal initial ')
% xlabel('t(s)');
% ylabel('mm');

%% Integration par la FFT 

G = integre_FFT(X,Ts);

figure(5),stem((0:(N/2-1))/N/Ts,(2/N)*abs(X(1:N/2)),'b.');
title('FFT du signal')

figure(6), 
subplot(121),plot(kTs,G);
title('Deuxieme integration avec FFT')
xlabel('t(s)');
ylabel('mm');
subplot(122),plot(kTs,D);
title('Signal initial')
xlabel('t(s)');
ylabel('mm');