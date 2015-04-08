load('data/data4comparison.mat');
n=1;
h=figure
hold on
plot(r_tab2,log(meanTa(:,:)),'k');
plot(r_tab,meanTs(:,:),'k.','MarkerSize',12);

%for i=1:size(meanTs,1)
%    errorbar(r_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
%end
set(gca,'XTick',r_tab)

xlabel('r','fontsize',fs_label);
ylabel('log <T>','fontsize',fs_label);

legend('Analytical formula','Monte Carlo');

printpdf(h,'graphics/mfat_comp_r');

