load('data/data4comparison.mat');
n=1;
figure
hold on
plot(r_tab2,meanTa(:,:),'r');
plot(r_tab,meanTs(:,:),'b.','MarkerSize',12);
