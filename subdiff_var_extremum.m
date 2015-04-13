function y=subdiff_var_extremum(mu,dx,xmax)
	xciag=0:dx:xmax;
	fv=f(xciag,mu);
	fv(1)=fv(2);
	ifv=cumtrapz(fv)*dx;

	h=figure;
	hold on
	plot(xciag,fv,'r');
	plot(xciag,ifv,'k');
	ifv(2)
	fv(2)
	printpdf(h,sprintf('subdiff_max%.0f.pdf',10*mu));

end

function y=f(x,mu)
	y=x.^(mu-1).*exp(x);
end
