function [vt_fft_val] = integre_FFT(V,Ts)
    % Elle travail avec N/2 echantillons
    % V etant le tableau fft d'un signal et Ts la periode d'echantillonnage
    N = length(V);
    delta_f = (1/Ts)/N; 

    C0 = 0;
    for k=2:N/2
        C0 = C0 - real(V(k))-real(V(1));
    end

    C3 = 0;
    for k=2:N/2
        C3 = C3 + imag(V(k))/(k*2*pi*delta_f);
    end
    
    C4 = 0;
    for k=2:N/2
        C4 = C4 - real(V(k))/(k*2*pi*delta_f)^2;
    end
    
    vt_fft = 0;
    vt_fft_val = zeros;
    k=0;
    
    for kTs = 0 : Ts : (N*Ts-Ts)
        k=k+1;
        for i=1:N/2-1
            vt_fft = vt_fft -(real(V(i+1))/((i+1)*2*pi*delta_f)^2)*cos((i+1)*2*pi*delta_f*kTs)-(imag(V(i+1))/((i+1)*2*pi*delta_f)^2)*sin((i+1)*2*pi*delta_f*kTs);
        end
        
        vt_fft_val(k) = vt_fft + ((real(V(1))+C0)/2)*(kTs^2) + C3*kTs + C4;
    end
    
