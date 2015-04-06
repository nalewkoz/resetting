function [h, fname]=plot3d(xx)
    load(sprintf('data3dplot/data3dplots_%.1f.mat',xx));
    h=surf(r,alphap,T);
    h
    ylabel('\alpha');
    xlabel('r');
    zlabel('<T>');
    colormap(bone);
    fname=sprintf('mfat3d_%.1f',x);
    %printpdf(h,fname);
end