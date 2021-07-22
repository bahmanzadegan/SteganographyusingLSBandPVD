function [MSE,PSNR] = PSNRfunction(CoverImage,StegoImage)

[x y]=size(CoverImage);
C = 0 ;

CoverImage=double(CoverImage);
StegoImage=double(StegoImage);

%13
for i=1:1:x
    for j=1:1:y
        C = C + (CoverImage(i,j) - StegoImage(i,j) )^2;
    end
end

c=double(C);
MSE = double( c  / (x*y) );

%12
PSNR = (10) * (log10((255^2)/MSE));