load('data/data4comparison.mat');
n=1;
h=figure
hold on
plot(r_tab2,log(meanTa(:,:)),'r');
%plot(r_tab,meanTs(:,:),'b.','MarkerSize',12);

for i=1:size(meanTs,1)
    errorbar(r_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
end
set(gca,'XTick',r_tab)

xlabel('r','fontsize',fs_label);
ylabel('log <T>','fontsize',fs_label);



printpdf(h,'graphics/mfat_comp_r');

