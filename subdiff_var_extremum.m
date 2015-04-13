function y=subdiff_var_extremum(mu,dx,xmax)
	xciag=0:dx:xmax;
	fv=f(xciag,mu);
	fv(1)=fv(2);
	ifv=cumtrapz(fv)*dx;

	dfv=fv-ifv;
	dfv=dfv(1:end-1).*dfv(2:end);
	dfv=find(dfv<0);
	x0=xciag(dfv)

	h=figure;
        hold on
        plot(xciag,fv,'r');
        plot(xciag,ifv,'k');
	plot(x0,fv(dfv),'rx','MarkerSize',10);
        printpdf(h,sprintf('graphics/subdiff_max%.0f.pdf',10*mu));

end

function y=f(x,mu)
	y=x.^(mu-1).*exp(x);
end
