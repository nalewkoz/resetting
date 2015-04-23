fs_label=14;
h=figure;
hold on;
znaczki=['ro';'g+'];
wielkosci=[6;6];
load('data/opt_potential_delta.mat');
errorbar(ctab,Ts,3*sdTs,znaczki(2,:),'MarkerSize',wielkosci(2));
load('data/opt_potential_exp.mat');
errorbar(ctab,Ts/4,3*sdTs/4,znaczki(1,:),'MarkerSize',wielkosci(1));

z=min(ctab):0.01:max(ctab);
plot(z,(z+exp(z)+2*exp(-z)-3)./z.^2,'k');

xlabel('z','fontsize',fs_label);
ylabel('MFPT','fontsize',fs_label);

legend('Monte Carlo: x_t=\pm1','Monte Carlo (rescaled): x_t Laplace-distributed','Analytical prediction');

printpdf(h,'graphics/potential_comp');