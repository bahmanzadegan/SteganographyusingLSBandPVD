function [Q] = Qualtiyfunction(CoverImage,StegoImage)

[x y]=size(CoverImage);
Xp = 0 ;
Yp = 0 ;
Zp = 0 ;
Wp = 0 ;
Bp = 0 ;

CoverImage=double(CoverImage);
StegoImage=double(StegoImage);

%15
for i=1:1:x
    for j=1:1:y
        Xp = Xp + CoverImage(i,j);
        Yp = Yp + StegoImage(i,j);
    end
end

Xp = Xp / (x*y);
Yp = Yp / (x*y);

%16
for i=1:1:x
    for j=1:1:y
        Zp = Zp + (CoverImage(i,j) - Xp)^2;
        Wp = Wp + (StegoImage(i,j) - Yp)^2;
    end
end

Zp = Zp / ( (x*y) - 1 ) ;
Wp = Wp / ( (x*y) - 1 ) ;

%17
for i=1:1:x
    for j=1:1:y
        Bp = Bp + ( (CoverImage(i,j) - Xp) * (StegoImage(i,j) - Yp) );
    end
end

Bp = Bp / ( (x*y) - 1 ) ;


%14
Q = ( 4 * (Bp^0.5) * Xp * Yp )   /   ( (Zp + Wp) * ((Xp^2)+(Yp^2)) ) ; 
Q = abs(Q - 1);

