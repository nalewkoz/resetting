function Y=rand_alpha2(M,N,alpha,sigma)
    
%     if alpha==1
% %         'a'
% %        mi=mi-beta*sigma^alpha*tan(alpha*pi/2);       
%         B=mi+(2/pi)*beta*sigma*log(sigma);
%     else
% %         'b'
%         B=mi-beta*sigma^alpha*tan(alpha*pi/2);
%     end
%     
    % Wa�ne: generujemy S z falka. Gdy chcemy generowac zwykle S,
    % odkomentuj ponizsza formulke.

    if(alpha==1)
%         'A'
            k1=rand(M,N);
            k2=rand(M,N);
            V=pi*( k1-0.5);
            W=-log(k2);
            
            Y=sigma*tan(V);
        
    else
%         'B'
        
            k1=rand(M,N);
            k2=rand(M,N);
            V=pi*( k1-0.5);
            W=-log(k2);
            
            Y=sigma*(sin(alpha*(V))./(cos(V)).^(1/alpha)).*(cos(V-alpha*(V))./W).^((1-alpha)/alpha);
       
    end
end