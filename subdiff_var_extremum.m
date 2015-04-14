function y=subdiff_var_extremum(mu,dx,xmax)
	xciag=0:dx:xmax;
	xciag(1)=dx;
	fv=f(xciag,mu);
	%fv(1)=fv(2);
	ifv=cumtrapz(fv)*dx;

	dfv=fv-ifv;
	dfv=dfv(1:end-1).*dfv(2:end);
	dfv=find(dfv<0);
	x0=xciag(dfv)
	
	fvhyper=1.1*(xciag.^mu).*(1/mu-1+hypergeom([],[1+mu],xciag));
	h=figure;
        hold on
        plot(xciag,log(fv),'r');
        plot(xciag,log(ifv),'k');
	plot(xciag,log(fvhyper));
	plot(xciag,log(exp(xciag)-1),'y')
	plot(x0,log(fv(dfv)),'rx','MarkerSize',10);
        printpdf(h,sprintf('graphics/subdiff_max%.0f.pdf',10*mu));

%	fv1=hypergeom([],[1+mu],xciag)+1/mu-1;
%        fv1=fv1.*xciag.*exp(-xciag)-1;
%	fv2=fv1(1:end-1).*fv1(2:end);
 %       fv2=find(fv2<0);
 %       x02=xciag(fv2)
%	h=figure
%	plot(xciag, fv1,'.r');
%	printpdf(h,sprintf('graphics/subdiff_max2%.0f.pdf',10*mu));
end

function y=f(x,mu)
	y=x.^(mu-1).*exp(x);
end
