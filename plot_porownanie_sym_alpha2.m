fs_label=14;

load('data/data4comparison3.mat');
h=figure
hold on
plot(x_tab2,log(meanTa(:,:)),'b');
%plot(x_tab,log(meanTs(:,:)),'k.','MarkerSize',12);

for i=1:size(meanTs,1)    
    errorbar(x_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
end
set(gca,'XTick',x_tab)

xlabel('x','fontsize',fs_label);
ylabel('log <T>','fontsize',fs_label);
grid on
axis tight

printpdf(h,'graphics/mfat_comp_x');
