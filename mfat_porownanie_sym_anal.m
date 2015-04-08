dt=0.01;
eps=[0.088 0.056 0.028 0.0105];
M=10^3;

alpha_tab=[2 1.8 1.6 1.4];
x0=1;
r_tab=[0.1 1:2:13];

meanTs=zeros(length(alpha_tab),length(r_tab));
sdevT=zeros(size(meanTs));
disp('Pierwsza petla (symulacje)...');
tic
for i=1:length(alpha_tab)
	
	a=alpha_tab(i);
	lambda=2*gamma(1-1/a)/pi;
	D=1/lambda^a;
	for j=1:length(r_tab)
		fprintf('\ralpha=%.1f r=%.2f',a,r_tab(j));
		%[meanTs(i,j) sdevT(i,j)]=mfat_sym_alpha(D,x0,r_tab(j),a,dt,eps(i),M);
		[meanTs(i,j) sdevT(i,j)]=mfpt_sym_subdiff(D,x0,r_tab(j),a,1,dt,M);
	end
end
fprintf('\n');
toc
r_tab2=[0.05 min(r_tab):0.1:max(r_tab) 13.5 14];
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
save('data/data4comparison_mfpt.mat','meanTs','sdevT','meanTa','r_tab','r_tab2','alpha_tab','M');

