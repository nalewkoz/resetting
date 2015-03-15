function y=mfat_anal_lambda_fast(r,D,lambda,alpha)
    x_max=50;
    k_max=50;
	dx=0.01;
    dk=0.002;
    Nx=ceil(x_max/dx);
    Nk=ceil(k_max/dk);
	% przeskalowanie x'ow:
    l=(D/r)^(1/alpha);
    x_max=x_max/l;
    dx=dx/l;

    x=linspace(0,x_max,Nx); % dobre tylko dla lambda=1, ale tylko takie potrzebujemy
	k=linspace(0,k_max,Nk);
    k=k';

    tab=f_to_int(k,x,alpha,Nx);
    size(tab)
	tab2=trapz(tab,1)*dk;
    size(tab2)
    calka=trapz(exp(-x/lambda)./tab2)*dx;
    
    y=(f0(alpha)*calka/lambda-1)/r;
end

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
    N1=10^3;    % Na tyle dzielimy okres cosinusa
    N2=20;      % Tyle okresow minimum musimy przejsc
    eps=10^(-4);% Oraz tyle razy przynajmniej musi spasc wartosc obwoluty
    
    T_cos=2*pi/x;
    k_max_pot=ceil((1/eps^(1/alpha))/T_cos);
    k_max=max(N2*T_cos,k_max_pot*T_cos);
    dk=min(T_cos/N1,1);
    
    k_ciag=gpuArray.linspace(0,k_max,ceil(k_max/dk));
 %   k_max
   % size(k_ciag)
    
    S=gather(trapz(f_to_int(k_ciag,x,alpha)))*dk;
end

function y=f_to_int(k,x,alpha,Nx)
    y=cos(k*x)./(repmat(abs(k).^alpha+1,1,Nx));
end
