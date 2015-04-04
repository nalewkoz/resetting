function [h, fname]=plot3d(xx)
    load(sprintf('data3dplots_%.1f.mat',xx));
    h=surf(r,alphap,T);
    ylabel('\alpha');
    xlabel('r');
    fname=sprintf('mfat3d_%.1f',x);
    %printpdf(h,fname);
end