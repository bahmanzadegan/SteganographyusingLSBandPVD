function [MSE,PSNR] = PSNRfunction_Weight(CoverImage,StegoImage)

[x y]=size(CoverImage);
C = 0 ;

CoverImage=double(CoverImage);
StegoImage=double(StegoImage);

NVF = 1;

%13
for i=1:1:x
    for j=1:1:y
        
        if (mod(j,3) == 0 )
            
            if abs( CoverImage(i,j)-CoverImage(i,j-1) ) > 63
                NVF=0.1;
            elseif abs( CoverImage(i,j)-CoverImage(i,j-1) ) > 31
                NVF=0.2;
            elseif abs( CoverImage(i,j)-CoverImage(i,j-1) ) > 15
                NVF=0.3;
            elseif abs( CoverImage(i,j)-CoverImage(i,j-1) ) > 7
                NVF=0.5;
            else
                NVF=1;
            end
            
        elseif (mod(j-1,3) == 0)
            
            if abs( CoverImage(i,j)-CoverImage(i,j+1) ) > 63
                NVF=0.1;
            elseif abs( CoverImage(i,j)-CoverImage(i,j+1) ) > 31
                NVF=0.2;
            elseif abs( CoverImage(i,j)-CoverImage(i,j+1) ) > 15
                NVF=0.3;
            elseif abs( CoverImage(i,j)-CoverImage(i,j+1) ) > 7
                NVF=0.5;
            else
                NVF=1;
            end
            
        end
        C = C + (NVF*(CoverImage(i,j) - StegoImage(i,j)))^2 ;
    end
end

c=double(C);
MSE = double( c  / (x*y) );

%12
PSNR = (10) * (log10((255^2)/MSE));