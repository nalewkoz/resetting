function y=subdiff_var_extremum(mu,dx,xmax)
	% Komentarz: zbieznosc metody z calka dosc wolna, trzeba bardzo male dx! Latwiej z hypergeom (choc i tak dosc wolno dziala liczenie tej funkcji...)
	xciag=0:dx:xmax;
	xciag(1)=dx;
	fv=f(xciag,mu);
	%fv(1)=fv(2);
	ifv=cumtrapz(fv)*dx;

	dfv=fv-ifv;
	dfv=dfv(1:end-1).*dfv(2:end);
	dfv=find(dfv<0);
	x0=xciag(dfv)
	
	%fvhyper=(xciag.^mu).*(hypergeom([mu],[1+mu],xciag))/mu;
	h=figure;
        hold on
        plot(xciag,log(fv),'r');
        plot(xciag,log(ifv),'k');
	%plot(xciag,log(fvhyper));
	%plot(xciag,log(exp(xciag)-1),'ya')
	plot(x0,log(fv(dfv)),'rx','MarkerSize',10);
        printpdf(h,sprintf('graphics/subdiff_max%.0f.pdf',10*mu));
	exp(-x0).*ifv(dfv)/gamma(mu)
	x0^(mu-1)/gamma(mu)
%	xciag=0.853:dx:0.855;
%	fv1=hypergeom([mu-1],[mu],xciag);
%        fv1=fv1-0;
%	fv2=fv1(1:end-1).*fv1(2:end);
%        fv2=find(fv2<0);
%        x02=xciag(fv2)
%	x02/x0
%	h=figure
%	plot(xciag, fv1,'.r');
%	printpdf(h,sprintf('graphics/subdiff_max2%.0f.pdf',10*mu));
end

function y=f(x,mu)
	y=x.^(mu-1).*exp(x);
end
