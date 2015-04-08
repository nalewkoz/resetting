fs_label=14;
h=figure;
% Pierwszy rysunek

load('data/data4comparison_mfpt.mat');
n=1;

subplot(1,2,2);
hold on
plot(r_tab2,log(meanTa(:,:)),'k');
plot(r_tab,log(meanTs(:,:)),'k.','MarkerSize',10);

for i=1:size(meanTs,1)
    errorbar(r_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
end
set(gca,'XTick',r_tab(1:end) )
set(gca,'FontSize',8)

xlabel('r','fontsize',fs_label);
%ylabel('log <T>','fontsize',fs_label);
axis([-1 max(r_tab2) 0.5 log(max(max(meanTs)))+0.1])
%M
%legend('Analytical formula','Monte Carlo');

% Drugi rysunek

load('data/data4comparison3.mat');
subplot(1,2,1);
hold on
plot(x_tab2,log(meanTa(:,:)),'k');
plot(x_tab,log(meanTs(:,:)),'k.','MarkerSize',10);

 for i=1:size(meanTs,1)
     errorbar(x_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
 end
set(gca,'XTick',x_tab(1:end))
set(gca,'FontSize',8)
xlabel('x','fontsize',fs_label);
ylabel('log <T>','fontsize',fs_label);
axis tight
%M
printpdf(h,'graphics/mfat_comp_r_mfpt');
