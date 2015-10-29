fs_label=14;
fsize2=12;
h=figure;
znaczki=['ko';'k+';'k.'];
wielkosci=[6;6;10];
% Pierwszy rysunek
n=1;
subplot(1,2,2);
hold on

for i=3:-1:1
    load(sprintf('data/data4comparison_r%d.mat',i));
    plot(r_tab,log(meanTs(:,:)),znaczki(i,:),'MarkerSize',wielkosci(i));
end
plot(r_tab2,log(meanTa(:,:)),'k');
%for i=1:size(meanTs,1)
%     errorbar(r_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
% end
set(gca,'XTick',r_tab(2:1:end) )
set(gca,'FontSize',fsize2)

xlabel('r','fontsize',fs_label);
%ylabel('log <T>','fontsize',fs_label);
axis([-1 max(r_tab2) 0.5 log(max(max(meanTs)))+0.1])
%M
%legend('Analytical formula','Monte Carlo');

% Drugi rysunek

subplot(1,2,1);
hold on
h2=zeros(4,3);

for i=3:-1:1
    load(sprintf('data/data4comparison_x%d.mat',i));
    h2(:,i)=plot(x_tab,log(meanTs(:,:)),znaczki(i,:),'MarkerSize',wielkosci(i));
end
% for i=1:size(meanTs,1)
%     h2=errorbar(x_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
% end
h1=plot(x_tab2,log(meanTa(:,:)),'k');
set(gca,'XTick',x_tab(1:2:end))
set(gca,'FontSize',fsize2)
xlabel('x','fontsize',fs_label);
ylabel('ln <T>','fontsize',fs_label);
axis tight
%M
hL=legend([h1(1) h2(1,:)],{'Prediction','\deltat=0.03','\deltat=0.01','\deltat=0.001'});

newPosition = [0.38 0.3 0.01 0.01];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits,'fontsize',12);


printpdf(h,'graphics/mfat_comp_xr');
