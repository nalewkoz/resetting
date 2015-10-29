function [h, fname]=plot3d_allinone(xx)
    fs_label=14;
    
    h=figure(1);
    
    a_ticks=[1.7 1.85 2;1.6 1.8 2;1.5 1.75 2;1.4 1.7 2];
    r_ticks=[2 5 8; 0.02 0.06 0.1; 0.01 0.02 0.03; 0.5*10^(-3) 1*10^(-3) 1.5*10^(-3)];
    tit=['a','b','c','d'];
    for i=1:length(xx)
        load(sprintf('graphics/ploty3d/data3dplots_%.1f.mat',xx(i)));
        subplot(2,2,i);
        surfc(r,alphap,T);%,'EdgeColor','none');
        colormap(bone);
        %shading interp
        axis([min(r) max(r) min(alphap) max(alphap)]);
        
        set(gca,'XTick',r_ticks(i,:))
        set(gca,'YTick',a_ticks(i,:))
      
        ylabel('\alpha','fontsize',fs_label);
        xlabel('r','fontsize',fs_label);
        zlabel('<T>','fontsize',fs_label);
        
        %title(sprintf('x=%.0f',xx(i)));
        title(sprintf('(%s)',tit(i)),'fontsize',10);
    end
    
    
    fname='plot3Dallinone';
    printpdf(h,fname);
end
