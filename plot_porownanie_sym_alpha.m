load('data/data4comparison.mat');

figure
hold on
plot(r_tab2,meanTa(1,:),'r');
plot(r_tab,meanTs(1,:),'b.','MarkerSize',12);
