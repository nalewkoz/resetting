function y=mfat_anal_lambda_fast2(r,D,lambda,alpha)

	dx=0.01;
	x=dx:dx:100; % dobre tylko dla lambda=1, ale tylko takie potrzebujemy
	T=zeros(size(x));
	%display('! mfat_anal_lambda');

  %  myCluster = parcluster('local');
  %  myCluster.NumWorkers = 6;  % 'Modified' property now TRUE
  %  saveProfile(myCluster); 
  %  parpool(6);
    parfor i=1:length(x)
        T(i)=mfat_anal_final(r,D,x(i),alpha);
	end
	val=[0, T.*exp(-x/lambda)/lambda];
	y=trapz(val)*dx;
   % delete(gcp);
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
    N1=10^2;    % Na tyle dzielimy okres cosinusa
    N2=10;      % Tyle okresow minimum musimy przejsc
    eps=10^(-3);% Oraz tyle razy przynajmniej musi spasc wartosc obwoluty
   
    T_cos=2*pi/x;
    k_max_pot=ceil((1/eps^(1/alpha))/T_cos);
    k_max=max(N2*T_cos,k_max_pot*T_cos);
    dk=min(T_cos/N1,1);
  %  k_max
  %  dk
    k_ciag=0:dk:k_max;
    S=trapz(f_to_int(k_ciag,x,alpha))*dk;
end

function y=f_to_int(k,x,alpha)
    y=cos(k*x)./(abs(k).^alpha+1);
end
