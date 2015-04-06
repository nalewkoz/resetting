function [h, fname]=plot3d(xx)
    fs_label=14;
    
    h=figure(1);
    load(sprintf('ploty3d/data3dplots_%.1f.mat',xx));
    surfc(r,alphap,T);%,'EdgeColor','none');
    colormap(bone);
    rotate3d on
    %shading interp
    ylabel('\alpha','fontsize',fs_label);
    xlabel('r','fontsize',fs_label);
    zlabel('<T>','fontsize',fs_label);
    fname=sprintf('mfat3d_%.1f',x);
    %printpdf(h,fname);
end