% 1) WA¯NY WNIOSEK: WOLNA ZBIE¯NOŒÆ MFPT w dt [biased estimator] KOREKTA KONIECZNA!
% st¹d: Przyda siê korekta gdy bêdziemy chcieli wykorzystywaæ to do subdyfuzji!
% 2)Korekta dla Levy'ch? Korekta dla dochodzenia do odcinka?
% 3)Kod dla MFPT jest na pewno nieoptymalny (bezsensowne kopiowanie kolumn X)

fs_label=14;
h=figure;
% Pierwszy rysunek

load('data/data4comparison_mfpt.mat');
n=1;

subplot(1,2,2);
hold on
% plot(r_tab2,log(meanTa(:,:)),'k');
% plot(r_tab,log(meanTs(:,:)),'k.','MarkerSize',10);
plot(r_tab2,meanTa(:,:),'k');
plot(r_tab,meanTs(:,:),'k.','MarkerSize',10);

%for i=1:size(meanTs,1)
%    errorbar(r_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
%end
set(gca,'XTick',r_tab(1:end) )
set(gca,'FontSize',8)

xlabel('r','fontsize',fs_label);
%ylabel('log <T>','fontsize',fs_label);
%axis([-1 max(r_tab2) 0.5 log(max(max(meanTs)))+0.1])

% Drugi rysunek

load('data/data4comparison3.mat');
subplot(1,2,1);
hold on
h1=plot(x_tab2,log(meanTa(:,:)),'k');
h2=plot(x_tab,log(meanTs(:,:)),'k.','MarkerSize',10);

%for i=1:size(meanTs,1)
%    errorbar(x_tab,log(meanTs(i,:)),3*sdevT(i,:)./meanTs(i,:),'k.');
%end
set(gca,'XTick',x_tab(1:end))
set(gca,'FontSize',8)
xlabel('x','fontsize',fs_label);
ylabel('log <T>','fontsize',fs_label);
axis tight
%M
hL=legend([h1(1) h2(1)],{'Analytical formula','Monte Carlo'});

newPosition = [0.4 0.3 0.01 0.01];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);


printpdf(h,'graphics/mfat_comp_r_mfpt');
