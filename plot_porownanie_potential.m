fs_label=14;
h=figure;
hold on;
znaczki=['ko';'k+'];
wielkosci=[8;8];
load('data/opt_potential_delta2.mat');
M
%errorbar(ctab,Ts,3*sdTs,znaczki(2,:),'MarkerSize',wielkosci(2));
plot(ctab,Ts,znaczki(2,:),'MarkerSize',wielkosci(2));
load('data/opt_potential_exp2.mat');
%errorbar(ctab,Ts/4,3*sdTs/4,znaczki(1,:),'MarkerSize',wielkosci(1));
plot(ctab,Ts/4,znaczki(1,:),'MarkerSize',wielkosci(1));
M

z=min(ctab):0.01:max(ctab);
plot(z,(z+exp(z)+2*exp(-z)-3)./z.^2,'k');

xlabel('z','fontsize',fs_label);
ylabel('MFPT','fontsize',fs_label);

legend('MC: x_t=\pm1','MC: x_t Laplace-distributed','Analytical prediction');

printpdf(h,'graphics/potential_comp');