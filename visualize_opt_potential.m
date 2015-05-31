%% Laplace
fs=12;
dx=0.001;
x=-3:dx:3;
f=exp(-abs(x))/2;
U=(exp(-abs(x)/2)-1)*log(2)+abs(x)/2;

h1=figure;
hold on;

X=[x fliplr(x)];
Y=[0*x fliplr(U)];
fill(X,Y,[0.6 0 0],'FaceAlpha',0.8,'EdgeColor',[0.6 0 0]);
plot(x,U,'r');

plot(x,f,'LineWidth',2);
xlabel('x','Fontsize',fs);
ylabel('f_G(x) and U^*(x)','Fontsize',fs);
printpdf(h1,'graphics/visualize_opt_pot_laplace');
%% Uniform
MAX=1;
C=log(2)-(log(3*log(2))+1)/3;
dx=0.001;
x=-3:dx:3;
xint=-2:dx:2;
f=abs(x)<2;
f=f/4;
U=((1-abs(x)/2).^(3/2)-1)*log(2)-log(1-abs(x)/2)/2+C;
U=(abs(x)<2).*U+(abs(x)>=2)*MAX;
U(abs(x)==2)=MAX;
U2=((1-abs(xint)/2).^(3/2)-1)*log(2)-log(1-abs(xint)/2)/2+C;
h2=figure;
hold on;

X=[x fliplr(x)];
Y=[0*x fliplr(U)];
fill(X,Y,[0.6 0 0],'FaceAlpha',0.8,'EdgeColor',[0.6 0 0]);
plot(xint,U2,'r');
plot(x,U,'r');

plot(x,f,'LineWidth',2);

xlabel('x','Fontsize',fs);
ylabel('f_G(x) and U^*(x)','Fontsize',fs);

axis([-3 3 0 MAX])

printpdf(h2,'graphics/visualize_opt_pot_uniform');
%% two points

MAX=1;
C=log(2);
dx=0.01;
x=-3:dx:3;
xint=-2:dx:2;

U=-log(2)*abs(x)+C;
U=(abs(x)<1).*U+(abs(x)>=1)*MAX;
U(abs(x)==1)=MAX;
U2=-log(2)*abs(xint)+C;
h3=figure;
hold on;

X=[x fliplr(x)];
Y=[0*x fliplr(U)];
fill(X,Y,[0.6 0 0],'FaceAlpha',0.8,'EdgeColor',[0.6 0 0]);
plot(xint,U2,'r');
plot(x,U,'r');

% plot(x,f,'LineWidth',2);
quiver([-1,1],[0,0],[0,0],[1/2, 1/2],'AutoScale','off','LineWidth',2);

xlabel('x','Fontsize',fs);
ylabel('f_G(x) and U^*(x)','Fontsize',fs);

axis([-3 3 0 MAX])

printpdf(h3,'graphics/visualize_opt_pot_deltas');
