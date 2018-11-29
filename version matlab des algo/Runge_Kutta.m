function [X,vc] = Runge_Kutta (vkTs,delta_t)
   %if delta_t == 0
   %   delta_t = 0.001;
   %end
   N = length(vkTs);
   V = zeros(1,N);
   X = zeros(1,N);
   %m = max(abs(vkTs));
   
   for i=1:N-1
       V(i+1) = V(i) + ((1/6)*vkTs(i)+(4/6)*(vkTs(i+1)-vkTs(i))/2+(1/6)*vkTs(i+1))*delta_t;
   end
   
   vc = zeros;
   for i= 1:N
      vc(i)=V(i)- mean(V);
   end
  
   %figure, plot(kTs,V)
   %title('Premiere integration')
   
   for i=1:N-1
       X(i+1) = X(i) + vc(i)*delta_t + (1/2)*((1/3)*vkTs(i)+(2/3)*(vkTs(i+1)-vkTs(i))/2)*delta_t^2;
   end
 
end

%figure, plot(kTs,X)
%title('Deuxieme integration')