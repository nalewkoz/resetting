x=1;
D=1; % Albo uzaleznimy of alpha (w petli), sprawiedliwe porownanie wtedy
N=5; % Bedziemy mieli 2*N+1 punktow do fitowania funkcji kwadratowej

z=1.59362;
% ===================================================
% Porownanie fair, moment ulamkowy p=1 ustalamy na 1:
D=pi/4;
% ===================================================
r0=D*z^2/x^2;
%alpha_tab=2:-0.001:1.01;
alpha_tab=2:-0.001:1.01;
Tmin_tab=zeros(size(alpha_tab));
rmin_tab=zeros(size(alpha_tab));
for i=1:length(alpha_tab)
    % for each alpha...
    l=20;
    alpha=alpha_tab(i);
    % ===================================================
    % Porownanie fair, moment ulamkowy p=1 ustalamy na 1:
    lambda=2*gamma(1-1/alpha)/pi;
    D=1/lambda^alpha;
    % ===================================================
    alpha
    tic
    for k=1:3
        r=(l-1)*r0/l:r0/(N*l):(l+1)*r0/l;
        Tr=zeros(size(r));

        for j=1:length(r)
%            Tr(j)=mfat_anal_final(r(j),D,x,alpha);
            Tr(j)=mfat_anal_lambda(r(j),D,lambda,alpha);
        end
        p = polyfit(r,Tr,2);
        r_min=-p(2)/(2*p(1));
        r0=r_min;
        fprintf('%.4f zawiera sie(?) w [%.4f; %.4f]\n',r_min,min(r),max(r));
        l=2*l;
    end    
    rmin_tab(i)=r_min;
    Tmin_tab(i)=polyval(p,r_min);
    toc
end
save('data_min_mfat_anal_fair1_small');
%% TESTUJ (skalowanie)!!
% Wyszedl pozytywnie dla x=5 i x=0.1
load('data_min_mfat_anal_naive_test01');
Tmin_tab5=Tmin_tab;
rmin_tab5=rmin_tab;
alpha_tab5=alpha_tab;
Xold=x;
load('data_min_mfat_anal_naive_BIG');
% Tu przeliczyamy na x=5:
x=Xold;
Na=length(alpha_tab);
for i=1:Na
    Tmin_tab(i)=Tmin_tab(i)*x^alpha_tab(i);
    rmin_tab(i)=rmin_tab(i)/x^alpha_tab(i);
end
figure
hold on
plot(alpha_tab,Tmin_tab,'.');
plot(alpha_tab5,Tmin_tab5,'r.','MarkerSize',20);
figure
hold on
plot(alpha_tab,rmin_tab,'.');
plot(alpha_tab5,rmin_tab5,'r.','MarkerSize',20);
%% TESTUJ (staly pierwszy modulo moment)
tic
alpha=2;
lambda=2*gamma(1-1/alpha)/pi;
D=1/lambda^alpha;
Y=rand_alpha2(1,10^7,alpha,1);
mean(Y.^2) % DLA alpha=2 POWINNO WYJSC 2, SPRWADZAM W TEN SPOSOB PARAMETRYZACJE
Y=Y/lambda;
mean(abs(Y))
toc
%% Rysuj ostatni wykres (dla najmniejszego alpha) T od r

%r_min
%z^2
%T_min=polyval(p,r_min)
figure
hold on
plot(r,Tr,'.');
plot([r0 r0],[min(Tr) max(Tr)],'g')
ciag=min(r):0.001:max(r);
plot(ciag,polyval(p,ciag),'r');

%% Rysuj wykres optymalnych parametrow
figure
hold on
plot(alpha_tab,Tmin_tab,'.')
figure
hold on
plot(alpha_tab,rmin_tab,'.')

%% Wykresy: optymalne T,r,alpha od x. Wykorzystujemy skalowanie

x=0.01:0.01:100;
Na=length(alpha_tab);
Nx=length(x);
Tmin_matrix=zeros(Na,Nx);
for i=1:Na
    Tmin_matrix(i,:)=Tmin_tab(i)*(x.^(alpha_tab(i)));
end

[T_glopt I]=min(Tmin_matrix,[],1);
r_glopt=zeros(1,Nx);
alpha_glopt=zeros(1,Nx);
I(100)
for i=1:Nx
    r_glopt(i)=rmin_tab(I(i))/x(i)^alpha_tab(I(i));
    alpha_glopt(i)=alpha_tab(I(i));
end

h1=figure
plot(x,T_glopt,'.');
ylabel('T^*','fontsize',14);
xlabel('x','fontsize',14);
h2=figure
hold on
plot(log(x),log(r_glopt),'.');
plot(log(10.77),log(r_glopt(find(x==10.77))),'r+','MarkerSize',20);
ylabel('log(r^*)','fontsize',14);
xlabel('log(x)','fontsize',14);
h3=figure
plot(x,alpha_glopt,'.');
ylabel('\alpha^*','fontsize',14);
xlabel('x','fontsize',14);
printpdf(h1,'mfat_fair_T');
printpdf(h2,'mfat_fair_r');
printpdf(h3,'mfat_fair_alpha');
%size(T_glopt)
%size(I)
%plot(alpha_tab,Tmin_matrix(:,200),'.')
