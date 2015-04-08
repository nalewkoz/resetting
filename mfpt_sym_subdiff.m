function [meanT sdevT]=mfpt_sym_subdiff(D,x0,r,alpha,mu,dt,M)
    
    X=zeros(M,2)+x0;
    over=zeros(M,1);
    czy_reset=zeros(M,1);
    over_old=zeros(M,1);
    T(M,1)=0;
    wsp=(dt*D)^(1/alpha);
    Nover=0;
    
    t_akt=0;
    i=1;

    while(Nover<M)
        i=i+1;
        t_akt=t_akt+dt;
        
        K=M-Nover;
        over_old(1:K)=over(1:K);
        dX(1:K,1)=wsp*rand_alpha2(M-Nover,1,alpha,1);
        
        X(1:K,1)=X(1:K,1)+dX(1:K);     % Aktualizujemy tylko te wektory, dla ktorych nie przekroczymy lewej granicy i nie przekroczylismy -xm+r (wowczas over)
        czy_reset(1:K)=rand(K,1)<r*dt;
        X(1:K,1)=X(1:K,1).*(1-czy_reset(1:K))+x0*czy_reset(1:K);
%         dX(1:K)=czy_krok(1:K).*dX(1:K)-(1-czy_krok(1:K)).*X(1:K);
        
%         % KOREKTA:
%         czy_przeszlo(1:K)=(rand(K,1)<exp(-( (X(1:K,1)-eps).*(X(1:K,1)-dX(1:K,1)-eps)/(D*dt) ) ))&(1-czy_reset(1:K));
%         X(1:K,1)=X(1:K,1).*(1-czy_przeszlo(1:K))+czy_przeszlo(1:K)*(0);
        
	X(1:K,2)=X(1:K,1);
        [X(K:-1:1,:) I]=sortrows(X(1:K,:),2);
        over(1:K)=X(1:K,2)<0;
        Nover=Nover+sum(over(1:K));
        T(1:K)=T(1:K)+( (over(1:K)-over_old(1:K))>0 )*(t_akt-dt/2); %Wa¿ne: bierzemy czas do statystyki FPT w po³owie przedzia³u ca³kowania!
        
%         czasy(i)=t_akt;
%         if(wskaznik<=K)        wskaznik=I(wskaznik); end %Nie dzial [Dzia³a tylko gdy M=1]
%         traj(i)=X(wskaznik,1);
    end
  
%     plot(czasy,traj);
    meanT=mean(T);
    sdevT=sqrt(mean( (T-meanT).^2 )/(length(T)-1));
end

function Y=rand_cauchy(M,N)
    szum=rand(M,N);
    Y=tan( (szum-0.5)*pi );
end
