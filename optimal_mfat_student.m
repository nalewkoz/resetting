mu=2.7;
lambda=1;
D=1; % Albo uzaleznimy of alpha (w petli), sprawiedliwe porownanie wtedy
N=5; % Bedziemy mieli 2*N+1 punktow do fitowania funkcji kwadratowej

%z=1.59362;
z=1/2;

% ===================================================
% Porownanie fair, moment ulamkowy p=1 ustalamy na 1:
D=pi/4;
% ===================================================
r0_2=D*z^2*lambda^2;						% TUTAJ TO NIE MA SENSU, BO DLA ALPHA=2 mamy inf
r0_2=0.0007;
%alpha_tab=2:-0.001:1.01;
alpha_tab=1.695:-0.001:1.29;
%alpha_tab=2
r0=r0_2;
Tmin_tab=zeros(size(alpha_tab));
rmin_tab=zeros(size(alpha_tab));
tic
for i=1:length(alpha_tab)
    % for each alpha...
    l=3;
    alpha=alpha_tab(i);
    % ===================================================
    % Porownanie fair, moment ulamkowy p=1 ustalamy na 1:
    lambda_fair=2*gamma(1-1/alpha)/pi;
    D=1/lambda_fair^alpha;
    % ===================================================
    alpha
    %tic
    for k=1:1
        r=(l-1)*r0/l:r0/(N*l):(l+1)*r0/l;
        Tr=zeros(size(r));

        for j=1:length(r)
%            Tr(j)=mfat_anal_final(r(j),D,x,alpha);
            Tr(j)=mfat_anal_student(mu,r(j),D,lambda,alpha);
        end
        p = polyfit(r,Tr,2);
	Tr
        r_min=-p(2)/(2*p(1));
        r0=r_min;
        fprintf('%.4f zawiera sie(?) w [%.4f; %.4f] \n',r_min,min(r),max(r));
	if(r0<0)
		fprintf('BLAD - wartosc ujemna r..\n');
		r0=0.1;
		break;
	end
        l=2*l;
    end    
    rmin_tab(i)=r_min;
    Tmin_tab(i)=polyval(p,r_min);
    Tmin_tab(i)
    %toc
end
toc
%4*lambda^2/D
%Tmin_tab
save('data_min_mfat_anal_student_fair_huge2');
