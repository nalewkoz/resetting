dt=0.001;
x0=1;
eps0=[0.07 0.08 0.09 0.1 0.11 0.12];
eps0=eps0/sqrt(10);

M=10^4;

r=1;

alpha_tab=[2 1.8 1.6 1.4];
eps=zeros(1,length(alpha_tab));
x_tab=[0.2 0.6];% 1:0.5:4];

T0=zeros(1,length(eps0));
meanTs=zeros(length(alpha_tab),length(x_tab));
sdevT=zeros(size(meanTs));

disp('Pierwsza petla (symulacje)...');
tic
for i=1:length(alpha_tab)
	
	a=alpha_tab(i);
	lambda=2*gamma(1-1/a)/pi;
	D=1/lambda^a;
	for j=1:length(eps0)
		T0(j)=mfat_sym_alpha(D,x0,r,a,dt,eps0(j),M);
	end
	Tanal=mfat_anal_final(r,D,x0,a);
	T0=T0-Tanal;
	p=polyfit(eps0,T0,2);
%	eps(i)=-p(2)/p(1);
	T0
	eps0=eps0/2;
	eps(i)=(-p(2)-sqrt(p(2)^2-4*p(1)*p(3)))/(2*p(1));

	fprintf('\nIdealny eps: %.3f\n',eps(i));
	for j=1:length(x_tab)
		fprintf('\ralpha=%.1f x=%.2f',a,x_tab(j));
		[meanTs(i,j) sdevT(i,j)]=mfat_sym_alpha(D,x_tab(j),r,a,dt,eps(i),M);
	end
end
fprintf('\n');
toc
x_tab2=[0.1 0.15 min(x_tab):0.05:max(x_tab) max(x_tab)+0.1:0.1:max(x_tab)+0.5];
meanTa=zeros(length(alpha_tab),length(x_tab2));
disp('Druga petla (calkowanie wzoru analitycznego)...');
tic
for i=1:length(alpha_tab)
	a=alpha_tab(i);
        lambda=2*gamma(1-1/a)/pi;
        D=1/lambda^a;
	for j=1:length(x_tab2)
		fprintf('\ralpha=%.1f x=%.2f',a,x_tab2(j));
		meanTa(i,j)=mfat_anal_final(r,D,x_tab2(j),a);
	end
end
fprintf('\n');
toc
save('data/data4comparison_x3.mat','meanTs','sdevT','meanTa','x_tab','x_tab2','alpha_tab','r','eps','dt','M');

