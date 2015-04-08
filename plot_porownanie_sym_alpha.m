% Pierwszy rysunek

load('data/data4comparison.mat');
n=1;
h=figure

subplot(1,2,2);
hold on
plot(r_tab2,log(meanTa(:,:)),'b');
plot(r_tab,log(meanTs(:,:)),'k.','MarkerSize',12);

%for i=1:size(meanTs,1)
%    errorbar(r_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
%end
set(gca,'XTick',r_tab)

xlabel('r','fontsize',fs_label);
ylabel('log <T>','fontsize',fs_label);

%legend('Analytical formula','Monte Carlo');

% Drugi rysunek
fs_label=14;

load('data/data4comparison2.mat');
subplot(1,2,1);
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

printpdf(h,'graphics/mfat_comp_r');
