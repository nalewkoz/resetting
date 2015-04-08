function y=mfat_anal_final(r,D,x,alpha)
%     tic
    l=(D/r)^(1/alpha);
    y=(f0(alpha)/f(x/l,alpha)-1)/r;
%     toc
end
function y=f0(alpha)
    a1=1/alpha;
    y=a1*gamma(a1)*gamma(1-a1);
end
function S=f(x,alpha)
    N1=10^4;    % Na tyle dzielimy okres cosinusa
    N2=200;      % Tyle okresow minimum musimy przejsc
    eps=10^(-4);% Oraz tyle razy przynajmniej musi spasc wartosc obwoluty
   
    T_cos=2*pi/x;
    k_max_pot=ceil((1/eps^(1/alpha))/T_cos);
    k_max=max(N2*T_cos,k_max_pot*T_cos);
    dk=min(T_cos/N1,1);
    
    k_ciag=0:dk:k_max;
    S=trapz(f_to_int(k_ciag,x,alpha) )*dk;
end

function y=f_to_int(k,x,alpha)
    y=cos(k*x)./(abs(k).^alpha+1);
end
