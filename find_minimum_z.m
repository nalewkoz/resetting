function [z fz]=find_minimum_z(minz,maxz,N)
	dz=(maxz-minz)/N;
	ztab=minz:dz:maxz;
	ftab=f(ztab);
	[fz Iz]=min(ftab);
	z=ztab(Iz);
end

function y=f(z)
	y=(z+exp(z)+2*exp(-z)-3)./z.^2;
end
