dt=0.01;
eps=[0.095 0.06 0.03];
M=10^3;

r=1;

alpha_tab=[2 1.8 1.6];
x_tab=0.1:0.6:3.1;

meanTs=zeros(length(alpha_tab),length(x_tab));
disp('Pierwsza petla (symulacje)...');
tic
for i=1:length(alpha_tab)
	
	a=alpha_tab(i);
	lambda=2*gamma(1-1/a)/pi;
	D=1/lambda^a;
	for j=1:length(x_tab)
		fprintf('\ralpha=%.1f x=%.2f',a,x_tab(j));
		meanTs(i,j)=mfat_sym_alpha(D,x_tab(j),r,a,dt,eps(i),M);
	end
end
fprintf('\n');
toc
x_tab2=min(x_tab):0.1:max(x_tab);
meanTa=zeros(length(alpha_tab),length(x_tab));
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
save('data/data4comparison2.mat','meanTs','meanTa','x_tab','x_tab2','alpha_tab','r','eps','dt');

