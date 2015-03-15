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
xlabel('\lambda_t','fontsize',14);
h2=figure
hold on
plot(log(x),log(r_glopt),'.');
%plot(log(10.77),log(r_glopt(find(x==10.77))),'r+','MarkerSize',20);
plot(log(3.25),log(r_glopt(find(x==3.25))),'r+','MarkerSize',20);
ylabel('log(r^*)','fontsize',14);
xlabel('log(\lambda_t)','fontsize',14);
h3=figure
plot(x,alpha_glopt,'.');
ylabel('\alpha^*','fontsize',14);
xlabel('\lambda_t','fontsize',14);
printpdf(h1,'mfat_fair_lambda_T');
printpdf(h2,'mfat_fair_lambda_r');
printpdf(h3,'mfat_fair_lambda_alpha');
%size(T_glopt)
%size(I)
%plot(alpha_tab,Tmin_matrix(:,200),'.')

