function [zp zm ftab]=find_minimum_2d_z(p,minz,maxz,N)
	ror=sqrt(p/(1-p)); % ten sam ksztalt, inne prawdopodobienstwa
	dz=(maxz-minz)/N;
	ztab=minz:dz:maxz;
	[zp zm]=meshgrid(ztab,ztab);

	ftab=sqrt(p*(1-p))*f(ror,zp,zm);

	[fz1 Iz1]=min(ftab);
	[fz2 Iz2]=min(fz1);

	zp_opt=ztab(Iz1(Iz2))
	zm_opt=ztab(Iz2)
	
	
	fz2
end
function y=faux(ror,zp,zm)
	y=ror*(zm./zp).*(exp(-zp)-1+zp)+(exp(-zp)-1).*(1-exp(+zm));
end
function y=f(ror,zp,zm)
	y=(faux(ror,zp,zm)+faux(1/ror,zm,zp))./(zp.*zm);
end
