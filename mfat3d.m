function T=mfat3d(x)
	alphap=2:-0.03:1.6-x/120;
	r=[0.06:0.03:0.3 0.4:0.2:8];
	r=r/x^1.8;

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
	save(sprintf('ploty3d/data3dplots_%.1f.mat',x),'x','alphap','r','T');
end
