function meanT=mfat_sym_alpha(D,x0,r,alpha,dt,eps,M)
    
    X=zeros(M,2)+x0;
    over=zeros(M,1);
    czy_reset=zeros(M,1);
    over_old=zeros(M,1);
    T(M,1)=0;
    wsp=(dt*D)^(1/alpha);
    Nover=0;
    
    t_akt=0;
    i=1;
    tic
    while(Nover<M)
        i=i+1;
        t_akt=t_akt+dt;
        
        K=M-Nover;
        over_old(1:K)=over(1:K);
        dX(1:K,1)=wsp*rand_alpha(M-Nover,alpha,0,1,0);
        
        X(1:K,1)=X(1:K,1)+dX(1:K);     % Aktualizujemy tylko te wektory, dla ktorych nie przekroczymy lewej granicy i nie przekroczylismy -xm+r (wowczas over)
        czy_reset(1:K)=rand(K,1)<r*dt;
        X(1:K,1)=X(1:K,1).*(1-czy_reset(1:K))+x0*czy_reset(1:K);
%         dX(1:K)=czy_krok(1:K).*dX(1:K)-(1-czy_krok(1:K)).*X(1:K);
        
%         % KOREKTA:
%         czy_przeszlo(1:K)=(rand(K,1)<exp(-( (X(1:K,1)-eps).*(X(1:K,1)-dX(1:K,1)-eps)/(D*dt) ) ))&(1-czy_reset(1:K));
%         X(1:K,1)=X(1:K,1).*(1-czy_przeszlo(1:K))+czy_przeszlo(1:K)*(0);
        
        X(1:K,2)=abs(X(1:K))-eps; 
        [X(K:-1:1,:) I]=sortrows(X(1:K,:),2);
        over(1:K)=X(1:K,2)<0;
        Nover=Nover+sum(over(1:K));
        T(1:K)=T(1:K)+( (over(1:K)-over_old(1:K))>0 )*(t_akt-dt/2); %Wa�ne: bierzemy czas do statystyki FPT w po�owie przedzia�u ca�kowania!
        
%         czasy(i)=t_akt;
%         if(wskaznik<=K)        wskaznik=I(wskaznik); end %Nie dzial [Dzia�a tylko gdy M=1]
%         traj(i)=X(wskaznik,1);
    end
    toc
%     plot(czasy,traj);
    meanT=mean(T);
end

function Y=rand_cauchy(M,N)
    szum=rand(M,N);
    Y=tan( (szum-0.5)*pi );
end