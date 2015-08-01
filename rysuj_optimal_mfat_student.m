load('data_min_mfat_anal_student_fair_huge2');

x=[0.001:0.001:0.02, 0.025:0.01:1, 1:0.1:100] ;
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
grid on
h2=figure
hold on
plot(log(x),log(r_glopt),'.');
%plot(log(10.77),log(r_glopt(find(x==10.77))),'r+','MarkerSize',20);
%plot(log(3.25),log(r_glopt(find(x==3.25))),'r+','MarkerSize',20);
ylabel('log(r^*)','fontsize',14);
xlabel('log(\lambda_t)','fontsize',14);
set(gca,'XTick',[-5 -3 -1 1 3 5])
grid on
h3=figure
plot(x,alpha_glopt,'.');
ylabel('\alpha^*','fontsize',14);
xlabel('\lambda_t','fontsize',14);
grid on
printpdf(h1,'graphics/mfat_fair_student27_T');
printpdf(h2,'graphics/mfat_fair_student27_r');
printpdf(h3,'graphics/mfat_fair_student27_alpha');

h=figure;
subplot(2,2,1);
plot(x,T_glopt,'.');
ylabel('T^*','fontsize',14);
xlabel('\lambda_t','fontsize',14);
set(gca,'XTick',[0 20 40 60 80 100])
grid on
subplot(2,2,2);
hold on
plot(log(x),log(r_glopt),'.');
%plot(log(10.77),log(r_glopt(find(x==10.77))),'r+','MarkerSize',20);
%plot(log(3.25),log(r_glopt(find(x==3.25))),'r+','MarkerSize',20);
ylabel('log(r^*)','fontsize',14);
xlabel('log(\lambda_t)','fontsize',14);
set(gca,'XTick',[-5 -3 -1 1 3 5])
grid on
subplot(2,1,2);
plot(x,alpha_glopt,'.');
ylabel('\alpha^*','fontsize',14);
xlabel('\lambda_t','fontsize',14);
grid on

printpdf(h,'graphics/mfat_fair_student27_allinone');

%size(T_glopt)
%size(I)
%plot(alpha_tab,Tmin_matrix(:,200),'.')

