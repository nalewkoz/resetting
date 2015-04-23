function [Ta Ts sdTs ctab]=potential_exp_mfat(dt,M)
	%ctab=0.35:0.01:0.5;
	ctab=[-2:0.3:3.1];
	Nc=length(ctab);
	Ta=zeros(Nc,1);
	Ts=zeros(Nc,1);
	sdTs=zeros(Nc,1);
	tic
	parfor i=1:Nc
		%Ta(i)=mfat_linear_anal(ctab(i));
		%Ts(i)=mfat_linear_mc(ctab(i),dt,M);
		Ta(i)=mfat_opt_anal(ctab(i));
		[Ts(i) sdTs(i)]=mfat_opt_mc(ctab(i),1/2,dt,M);
	%	fprintf('%d/%d',i,Nc);
	end
	toc
	[ctab' Ta Ts 3*sdTs]
	save('data/opt_potential_delta.mat','Ta' ,'Ts','sdTs', 'ctab','dt','M'); 
end
function y=mfat_linear_mc(c,dt,M)
	T=zeros(M,1);

	for i=1:M
		x=0;
		xt=-log(rand());
		t=0;
		for j=1:10^9
			t=t+dt;
			
			xn=x-c*sign(x)*dt+sqrt(2*dt)*randn();
			if(xn>xt) 
				break;
			end
%			if(rand()<exp(-(xt-x)*(xt-xn)/dt)) 
%				break;
%			end

			x=xn;
		end
		T(i)=t-dt/2;
	end
	y=mean(T);
end
function y=mfat_linear_anal(c)
	y=(2/(1-c)-1)/c;
end

function [y sdy]=mfat_opt_mc(z1,c,dt,M)
        T=zeros(M,1);

        for i=1:M
                x=0;
                xt=-log(rand());
                t=0;
                for j=1:10^9
                        t=t+dt;
                        xn=x + c*sign(x)*(z1*exp(-c*abs(x))-1)*dt + sqrt(2*dt)*randn();
                        if(xn>xt)
                                break;
                        end
			if(rand()<exp(-(xt-x)*(xt-xn)/dt))
				break;
			end

			x=xn;
                end
                T(i)=t-dt/2;
        end
        y=mean(T);
	sdy=sqrt(mean((T-y).^2)/(M-1));
end
function y=mfat_opt_anal(z)
        % valid for c=1/2 !!!
	
	y=4*(z+exp(z)+2*exp(-z)-3)./z.^2;
end

