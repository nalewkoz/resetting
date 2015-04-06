dt=0.01;
eps=[0.09 0.06 0.04];
M=10^4;

alpha_tab=[2 1.8 1.6];
x0=1;
r_tab=0.1:0.5:10;

meanTs=zeros(length(alpha_tab),length(r_tab));
disp('Pierwsza petla (symulacje)...');
tic
for i=1:length(alpha_tab)
	
	a=alpha_tab(i);
	lambda=2*gamma(1-1/a)/pi;
	D=1/lambda^a;
	for j=1:length(r_tab)
		fprintf('\ralpha=%.1f r=%.2f',a,r_tab(j));
		meanTs(i,j)=mfat_sym_alpha(D,x0,r_tab(j),a,dt,eps(i),M);
	end
end
fprintf('\n');
toc
r_tab2=min(r_tab):0.1:max(r_tab);
meanTa=zeros(length(alpha_tab),length(r_tab));
disp('Druga petla (calkowanie wzoru analitycznego)...');
tic
for i=1:length(alpha_tab)
	a=alpha_tab(i);
        lambda=2*gamma(1-1/a)/pi;
        D=1/lambda^a;
	for j=1:length(r_tab2)
		fprintf('\ralpha=%.1f r=%.2f',a,r_tab2(j));
		meanTa(i,j)=mfat_anal_final(r_tab2(j),D,x0,a);
	end
end
fprintf('\n');
toc
save('data/data4comparison.mat','meanTs','meanTa','r_tab','r_tab2','alpha_tab');

