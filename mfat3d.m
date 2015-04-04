function T=mfat3d(x)
	alphap=1.6:0.01:2;
	r=[0.05:0.02:0.3 0.4:0.3:10];
	Na=length(alphap);
	Nr=length(r);
	T=zeros(Na,Nr);
	for i=1:Na
		a=alphap(i)
		D=(pi/(2*gamma(1-1/a)))^a;
		for j=1:Nr
			T(i,j)=mfat_anal_final(r(j),D,x,a);
		end
	end
	min(min(T))
	max(max(T))

	%h=surf(r,alpha,T);
	%printpdf(h,sprintf('mfat3d_%.1f',x));
	save(sprintf('data3dplots_%.1f.mat',x),'x','alphap','r','T');
end
