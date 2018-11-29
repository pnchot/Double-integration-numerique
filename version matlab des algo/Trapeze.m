function [x, vc] = Trapeze(xkTs,Ts)
% Premiere integration
  v=zeros;
  N=length(xkTs);
  for i = 1:N-1
      v(i+1)= v(i)+(xkTs(i+1)+xkTs(i))*(Ts/2); 
  end
  
% Ajout de la condition initiale ou de l'offset 
  vc=zeros;
  for i= 1:N
      vc(i)=v(i)-mean(v);
  end
  
% Deuxieme integration
  x=zeros;
  for i=1:N-1
      x(i+1) = x(i)+ (vc(i+1)+vc(i))*(Ts/2);
  end

end 
