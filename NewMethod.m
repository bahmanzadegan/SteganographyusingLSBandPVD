clc;
clear all;

[filename, pathname] = uigetfile({'*.gif','GIF file'},'Please select Cover-image');
QueryPath=[pathname,filename];
QueryImage=imread(QueryPath);
% imshow (QueryImage);
disp('%%%%%%%%%% New-Method %%%%%%%%%%');
disp('=> Cover-image selected...');
disp(QueryPath);
disp(' ');

EmbeddingCapatcity= 13000;
Secret = char ('1010000100110101001010110100001000001001000110110110111000110100001110000011001101011000011000101100111110110011001000000111010100100110000011011010000110101100001110011110000101111011010101000001001110000111100110001000001110001000101010111101100000001101001111111010011000010101001101011011100101101101011100111110100111100011011100111001011010011101000010011111100110001101111101010000001000101101101001101000001010000000100110011100110011001100010100001000000101111011010010100011010001110011100001110000110111010000001010100010110110010101001000110001001111011111000001100101100000100011110110100100001000100010101011010010100001111110000111110110110010011000000110011001000110000111111001101001100101111100110101000010011101010101100000010000000101010111011110101001111001010000111110100110100011010010111100100111001110101010101111010000100101010001010011000110100010000010001110111100111100010110110100000010000100101101110111110100010100110101110111010000111100000000111111110111101100010000');
%Lentgh 1000

IMAGE = QueryImage;
I = IMAGE;

[x y]=size(I);
[l Secret_len] = size(Secret);

Variance(x,y) = 0;
NVF(x,y) = 0; Brightness(x,y) = 0;

for i = 1 : 1 : x
    for j = 1 : 1 : y
        
        if (i-1) > 0 && (j-1) > 0
            P1 = I(i-1,j-1); else P1 = -1; end
        if (i-1) > 0
            P2 = I(i-1,j); else P2 = -1; end
        if (i-1) > 0 && (j+1) <= y
            P3 = I(i-1,j+1); else P3 = -1; end
        if (j-1) > 0
            P4 = I(i,j-1); else P4 = -1; end
        P5 = I(i,j);
        if (j+1) <= y
            P6 = I(i,j+1); else P6 = -1; end
        if (i+1) <= x && (j-1) > 0
            P7 = I(i+1,j-1); else P7 = -1; end
        if (i+1) <= x
            P8 = I(i+1,j); else P8 = -1; end
        if (i+1) <= x && (j+1) <= y
            P9 = I(i+1,j+1); else P9 = -1; end
        
        if (P1 == -1) && (P2 == -1) && (P3 == -1) && (P4 == -1) && (P5 ~= -1) && (P6 ~= -1) && (P7 == -1) && (P8 ~= -1) && (P9 ~= -1)
            P = [P5 P6 ; P8 P9];
        elseif (P1 == -1) && (P2 == -1) && (P3 == -1) && (P4 ~= -1) && (P5 ~= -1) && (P6 ~= -1) && (P7 ~= -1) && (P8 ~= -1) && (P9 ~= -1)
            P = [P4 P5 P6 ; P7 P8 P9];
        elseif (P1 == -1) && (P2 == -1) && (P3 == -1) && (P4 ~= -1) && (P5 ~= -1) && (P6 == -1) && (P7 ~= -1) && (P8 ~= -1) && (P9 == -1)
            P = [P4 P5 ; P7 P8];
        elseif (P1 == -1) && (P2 ~= -1) && (P3 ~= -1) && (P4 == -1) && (P5 ~= -1) && (P6 ~= -1) && (P7 == -1) && (P8 ~= -1) && (P9 ~= -1)
            P = [P2 P3 ; P5 P6 ; P8 P9];
        elseif (P1 ~= -1) && (P2 ~= -1) && (P3 == -1) && (P4 ~= -1) && (P5 ~= -1) && (P6 == -1) && (P7 ~= -1) && (P8 ~= -1) && (P9 == -1)
            P = [P1 P2 ; P4 P5 ; P7 P8];
        elseif (P1 == -1) && (P2 ~= -1) && (P3 ~= -1) && (P4 == -1) && (P5 ~= -1) && (P6 ~= -1) && (P7 == -1) && (P8 == -1) && (P9 == -1)
            P = [P2 P3 ; P5 P6];
        elseif (P1 ~= -1) && (P2 ~= -1) && (P3 ~= -1) && (P4 ~= -1) && (P5 ~= -1) && (P6 ~= -1) && (P7 == -1) && (P8 == -1) && (P9 == -1)
            P = [P1 P2 P3 ; P4 P5 P6];
        elseif (P1 ~= -1) && (P2 ~= -1) && (P3 == -1) && (P4 ~= -1) && (P5 ~= -1) && (P6 == -1) && (P7 == -1) && (P8 == -1) && (P9 == -1)
            P = [P1 P2 ; P4 P5];
        elseif (P1 ~= -1) && (P2 ~= -1) && (P3 ~= -1) && (P4 ~= -1) && (P5 ~= -1) && (P6 ~= -1) && (P7 ~= -1) && (P8 ~= -1) && (P9 ~= -1)
            P = [P1 P2 P3 ; P4 P5 P6 ; P7 P8 P9];
        end

        %disp(P);
        
        Variance_P = var(double(P));
        [v w] = size(Variance_P);
        Sum = 0;MaxLocalVariance = 0;
        %for r = 1 : 1 : w
        %    Sum = Sum + Variance_P(1,r);
        %end
        Sum = sum(Variance_P(:));
        
        LocalVariance = double(Sum / w);
        
        if (LocalVariance > MaxLocalVariance)
            MaxLocalVariance = LocalVariance;
        end
        
        Variance(i,j) = LocalVariance;
        
    end
end

D = 75;
Q = D / MaxLocalVariance;


for i = 1 : 1 : x
    for j = 1 : 1 : y
        NVF(i,j) = double( 1 / (1 + (Q * Variance(i,j))));
    end
end
%figure,imshow(NVF);


for i = 1 : 1 : x
    for j = 1 : 1 : y
        Brightness(i,j) = ( double(I(i,j)) / 255 );
    end
end
%figure,imshow(Brightness);


a = 1; 
blk_Status_1 = 0 ; blk_Status_2 = 0 ; blk_Status_3 = 0; blk_Status_4 = 0; blk_Status_0 = 0;

for i = 1 : 3 : x
    for j = 1 : 3 : y
        
        if (i + 2 <= x && j + 2 <= y)
        
            blk_NVF = [NVF(i,j) NVF(i,j+1) NVF(i,j+2) ; 
                   NVF(i+1,j) NVF(i+1,j+1) NVF(i+1,j+2) ; 
                   NVF(i+2,j) NVF(i+2,j+1) NVF(i+2,j+2)];
            blk_NVF_Sum = sum(blk_NVF(:));
            NVFi = abs((blk_NVF_Sum / 9) -1);
        
            blk_Brightness = [Brightness(i,j) Brightness(i,j+1) Brightness(i,j+2) ; 
                          Brightness(i+1,j) Brightness(i+1,j+1) Brightness(i+1,j+2) ; 
                          Brightness(i+2,j) Brightness(i+2,j+1) Brightness(i+2,j+2)];
            blk_Brightness_Sum = sum(blk_Brightness(:));
            Brightnessi = blk_Brightness_Sum / 9;
           
            if (isnan(NVFi))
                 N = 0;
            else N = NVFi;
            end
            
            if (isnan(Brightnessi))
                 B = 0;
            else B = Brightnessi;
            end
            
            
            Ui = N + B;
            if (Ui < 0.5)
                blk_Status_i = 1;
                blk_Status_1 = blk_Status_1 + 1;
            elseif ( Ui >= 0.5 && Ui < 1)
                blk_Status_i = 2;
                blk_Status_2 = blk_Status_2 + 1;
            elseif ( Ui >= 1 && Ui < 1.5)
                blk_Status_i = 3;
                blk_Status_3 = blk_Status_3 + 1;
            elseif (Ui > 1.5)
                blk_Status_i = 4;
                blk_Status_4 = blk_Status_4 + 1;
            else 
                blk_Status_i = 0;
                blk_Status_0 = blk_Status_0 + 1;
            end
            P1 = double(I(i,j)); P2 = double(I(i,j+1)); P3 = double(I(i,j+2)); P4 = double(I(i+1,j)); P5 = double(I(i+1,j+1));
            P6 = double(I(i+1,j+2)); P7 = double(I(i+2,j)); P8 = double(I(i+2,j+1)); P9 = double(I(i+2,j+2));
            Dif(1,1) = abs(P1 - P2); Dif(1,2) = abs(P2 - P3);
            Dif(1,3) = abs(P4 - P5); Dif(1,4) = abs(P5 - P6);
            Dif(1,5) = abs(P7 - P8); Dif(1,6) = abs(P8 - P9);
            
            blk_Status(a , 1) = i; blk_Status(a , 2) = j; blk_Status(a , 3) = blk_Status_i;
            blk_Status(a , 4) = Dif(1,1); blk_Status(a , 5) = Dif(1,2); blk_Status(a , 6) = Dif(1,3); 
            blk_Status(a , 7) = Dif(1,4); blk_Status(a , 8) = Dif(1,5); blk_Status(a , 9) = Dif(1,6);
            
            a = a+1;
        
        end
    end
end

U_Dif(20,3) = 0;

[x y] = size(blk_Status);
for i = 1 : 1 : x
    U = blk_Status(i , 3);
    for j = 4 : 1 : y
        if (U == 4)
            if(blk_Status(i,j) >= 64)
                U_Dif(1,1) = U_Dif(1,1)  +  1;
                U_Dif(1,2) = U_Dif(1,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 64
                    U_Dif(1,2) = U_Dif(1,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 32)
                U_Dif(2,1) = U_Dif(2,1)  +  1;
                U_Dif(2,2) = U_Dif(2,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 32
                    U_Dif(2,2) = U_Dif(2,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 64
                    U_Dif(2,2) = U_Dif(2,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 16)
                U_Dif(3,1) = U_Dif(3,1)  +  1;
                U_Dif(3,2) = U_Dif(3,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 16
                    U_Dif(3,2) = U_Dif(3,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 32
                    U_Dif(3,2) = U_Dif(3,2)  -  1;
                end

            elseif (blk_Status(i,j) >= 8)
                U_Dif(4,1) = U_Dif(4,1)  +  1;
                U_Dif(4,2) = U_Dif(4,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 8
                    U_Dif(4,2) = U_Dif(4,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 16
                    U_Dif(4,2) = U_Dif(4,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 0)
                U_Dif(5,1) = U_Dif(5,1)  +  1;
                U_Dif(5,2) = U_Dif(5,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 0
                    U_Dif(5,2) = U_Dif(5,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 8
                    U_Dif(5,2) = U_Dif(5,2)  -  1;
                end
            end
            
        elseif (U == 3)
            if(blk_Status(i,j) >= 64)
                U_Dif(6,1) = U_Dif(6,1)  +  1;
                U_Dif(6,2) = U_Dif(6,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 64
                    U_Dif(6,2) = U_Dif(6,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 32)
                U_Dif(7,1) = U_Dif(7,1)  +  1;
                U_Dif(7,2) = U_Dif(7,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 32
                    U_Dif(7,2) = U_Dif(7,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 64
                    U_Dif(7,2) = U_Dif(7,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 16)
                U_Dif(8,1) = U_Dif(8,1)  +  1;
                U_Dif(8,2) = U_Dif(8,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 16
                    U_Dif(8,2) = U_Dif(8,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 32
                    U_Dif(8,2) = U_Dif(8,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 8)
                U_Dif(9,1) = U_Dif(9,1)  +  1;
                U_Dif(9,2) = U_Dif(9,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 8
                    U_Dif(9,2) = U_Dif(9,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 16
                    U_Dif(9,2) = U_Dif(9,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 0)
                U_Dif(10,1) = U_Dif(10,1)  +  1;
                U_Dif(10,2) = U_Dif(10,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 0
                    U_Dif(10,2) = U_Dif(10,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 8
                    U_Dif(10,2) = U_Dif(10,2)  -  1;
                end
                
            end
        elseif (U == 2)
            if(blk_Status(i,j) >= 64)
                U_Dif(11,1) = U_Dif(11,1)  +  1;
                U_Dif(11,2) = U_Dif(11,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 64
                    U_Dif(11,2) = U_Dif(11,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 32)
                U_Dif(12,1) = U_Dif(12,1)  +  1;
                U_Dif(12,2) = U_Dif(12,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 32
                    U_Dif(12,2) = U_Dif(12,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 64
                    U_Dif(12,2) = U_Dif(12,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 16)
                U_Dif(13,1) = U_Dif(13,1)  +  1;
                U_Dif(13,2) = U_Dif(13,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 16
                    U_Dif(13,2) = U_Dif(13,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 32
                    U_Dif(13,2) = U_Dif(13,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 8)
                U_Dif(14,1) = U_Dif(14,1)  +  1;
                U_Dif(14,2) = U_Dif(14,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 8
                    U_Dif(14,2) = U_Dif(14,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 16
                    U_Dif(14,2) = U_Dif(14,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 0)
                U_Dif(15,1) = U_Dif(15,1)  +  1;
                U_Dif(15,2) = U_Dif(15,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 0
                    U_Dif(15,2) = U_Dif(15,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 8
                    U_Dif(15,2) = U_Dif(15,2)  -  1;
                end
                
            end  
        elseif (U == 1)
            if(blk_Status(i,j) >= 64)
                U_Dif(16,1) = U_Dif(16,1)  +  1;
                U_Dif(16,2) = U_Dif(16,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 64
                    U_Dif(16,2) = U_Dif(16,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 32)
                U_Dif(17,1) = U_Dif(17,1)  +  1;
                U_Dif(17,2) = U_Dif(17,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 32
                    U_Dif(17,2) = U_Dif(17,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 64
                    U_Dif(17,2) = U_Dif(17,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 16)
                U_Dif(18,1) = U_Dif(18,1)  +  1;
                U_Dif(18,2) = U_Dif(18,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 16
                    U_Dif(18,2) = U_Dif(18,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 32
                    U_Dif(18,2) = U_Dif(18,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 8)
                U_Dif(19,1) = U_Dif(19,1)  +  1;
                U_Dif(19,2) = U_Dif(19,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 8
                    U_Dif(19,2) = U_Dif(19,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 16
                    U_Dif(19,2) = U_Dif(19,2)  -  1;
                end
                
            elseif (blk_Status(i,j) >= 0)
                U_Dif(20,1) = U_Dif(20,1)  +  1;
                U_Dif(20,2) = U_Dif(20,2)  +  1;
                if (j == 4 || j == 6 || j == 8) && blk_Status(i,j+1) >= 0
                    U_Dif(20,2) = U_Dif(20,2)  -  1;
                elseif (j == 5 || j == 7 || j == 9) && blk_Status(i,j-1) >= 8
                    U_Dif(20,2) = U_Dif(20,2)  -  1;
                end
                
            end
        end
    end
end
U_Dif(1:5,3) = 4; U_Dif(6:10,3) = 3; U_Dif(11:15,3) = 2; U_Dif(16:20,3) = 1;

disp( 'blk_Status_0 =' ) , disp(blk_Status_0);
disp( 'blk_Status_1 =' ) , disp(blk_Status_1) , disp(U_Dif(20,:)) , disp(U_Dif(19,:)) , disp(U_Dif(18,:)) , disp(U_Dif(17,:)) , disp(U_Dif(16,:));
disp( 'blk_Status_2 =' ) , disp(blk_Status_2) , disp(U_Dif(15,:)) , disp(U_Dif(14,:)) , disp(U_Dif(13,:)) , disp(U_Dif(12,:)) , disp(U_Dif(11,:));
disp( 'blk_Status_3 =' ) , disp(blk_Status_3) , disp(U_Dif(10,:)) , disp(U_Dif(9,:)) , disp(U_Dif(8,:)) , disp(U_Dif(7,:)) , disp(U_Dif(6,:));
disp( 'blk_Status_4 =' ) , disp(blk_Status_4) , disp(U_Dif(5,:)) , disp(U_Dif(4,:)) , disp(U_Dif(3,:)) , disp(U_Dif(2,:)) , disp(U_Dif(1,:));
disp( 'blk_Count =' ) , disp( blk_Status_0 + blk_Status_1 + blk_Status_2 + blk_Status_3 + blk_Status_4 );

Main_EmbeddingMatrix = [6,5,4,3,3;
                        5,4,3,3,2;
                        4,3,3,2,1;
                        3,3,2,1,1];
This_EmbeddingMatrix(4,5)=0;

Embedding_Status = 0; LastLSB = 0;

if ((U_Dif(1,1) + U_Dif(1,2)) >= EmbeddingCapatcity )
    Embedding_Status = 1;
    This_EmbeddingMatrix(1,1) = 1;
elseif (((U_Dif(1,1) * 2) + (U_Dif(1,2) * 1)) >= EmbeddingCapatcity )
    Embedding_Status = 2;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 2; 
elseif (((U_Dif(1,1) * 2) + (U_Dif(1,2) * 2)) >= EmbeddingCapatcity )
    Embedding_Status = 3;
    This_EmbeddingMatrix(1,1) = 2; 
elseif (((U_Dif(1,1) * 2) + (U_Dif(1,2) * 2) + U_Dif(2,1) + U_Dif(2,2)) >= EmbeddingCapatcity )
    Embedding_Status = 4;
    This_EmbeddingMatrix(1,1) = 2;
    This_EmbeddingMatrix(1,2) = 1;    
elseif (((U_Dif(1,1) * 2) + (U_Dif(1,2) * 2) + U_Dif(2,1) + U_Dif(2,2) + U_Dif(6,1) + U_Dif(6,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 5;
    This_EmbeddingMatrix(1,1) = 2;
    This_EmbeddingMatrix(1,2) = 1;
    This_EmbeddingMatrix(2,1) = 1;
elseif (((U_Dif(1,1) * 3) + (U_Dif(1,2) * 2) + U_Dif(2,1) + U_Dif(2,2) + U_Dif(6,1) + U_Dif(6,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 6;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 3;
    This_EmbeddingMatrix(1,2) = 1;
    This_EmbeddingMatrix(2,1) = 1;
elseif (((U_Dif(1,1) * 3) + (U_Dif(1,2) * 3) + U_Dif(2,1) + U_Dif(2,2) + U_Dif(6,1) + U_Dif(6,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 7;
    This_EmbeddingMatrix(1,1) = 3;
    This_EmbeddingMatrix(1,2) = 1;
    This_EmbeddingMatrix(2,1) = 1;
elseif (((U_Dif(1,1) * 3) + (U_Dif(1,2) * 3) + (U_Dif(2,1) * 2) + (U_Dif(2,2) * 1) + U_Dif(6,1) + U_Dif(6,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 8;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 3;
    This_EmbeddingMatrix(1,2) = 2;
    This_EmbeddingMatrix(2,1) = 1;
elseif (((U_Dif(1,1) * 3) + (U_Dif(1,2) * 3) + (U_Dif(2,1) * 2) + (U_Dif(2,2) * 2) + U_Dif(6,1) + U_Dif(6,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 9;
    This_EmbeddingMatrix(1,1) = 3;
    This_EmbeddingMatrix(1,2) = 2;
    This_EmbeddingMatrix(2,1) = 1;
elseif (((U_Dif(1,1) * 3) + (U_Dif(1,2) * 3) + (U_Dif(2,1) * 2) + (U_Dif(2,2) * 2) + (U_Dif(6,1) * 2) + (U_Dif(6,2) * 1) ) >= EmbeddingCapatcity )
    Embedding_Status = 10;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 3;
    This_EmbeddingMatrix(1,2) = 2;
    This_EmbeddingMatrix(2,1) = 2;
elseif (((U_Dif(1,1) * 3) + (U_Dif(1,2) * 3) + (U_Dif(2,1) * 2) + (U_Dif(2,2) * 2) + (U_Dif(6,1) * 2) + (U_Dif(6,2) * 2) ) >= EmbeddingCapatcity )
    Embedding_Status = 11;
    This_EmbeddingMatrix(1,1) = 3;
    This_EmbeddingMatrix(1,2) = 2;
    This_EmbeddingMatrix(2,1) = 2;
elseif (((U_Dif(1,1) * 3) + (U_Dif(1,2) * 3) + (U_Dif(2,1) * 2) + (U_Dif(2,2) * 2) + (U_Dif(6,1) * 2) + (U_Dif(6,2) * 2) + U_Dif(3,1) + U_Dif(3,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 12;
    This_EmbeddingMatrix(1,1) = 3;
    This_EmbeddingMatrix(1,2) = 2;
    This_EmbeddingMatrix(2,1) = 2;
    This_EmbeddingMatrix(1,3) = 1;
elseif (((U_Dif(1,1) * 3) + (U_Dif(1,2) * 3) + (U_Dif(2,1) * 2) + (U_Dif(2,2) * 2) + (U_Dif(6,1) * 2) + (U_Dif(6,2) * 2) + U_Dif(3,1) + U_Dif(3,2) + U_Dif(7,1) + U_Dif(7,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 13;
    This_EmbeddingMatrix(1,1) = 3;
    This_EmbeddingMatrix(1,2) = 2;
    This_EmbeddingMatrix(2,1) = 2;
    This_EmbeddingMatrix(1,3) = 1;
    This_EmbeddingMatrix(2,2) = 1;
elseif (((U_Dif(1,1) * 3) + (U_Dif(1,2) * 3) + (U_Dif(2,1) * 2) + (U_Dif(2,2) * 2) + (U_Dif(6,1) * 2) + (U_Dif(6,2) * 2) + U_Dif(3,1) + U_Dif(3,2) + U_Dif(7,1) + U_Dif(7,2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 14;
    This_EmbeddingMatrix(1,1) = 3;
    This_EmbeddingMatrix(1,2) = 2;
    This_EmbeddingMatrix(2,1) = 2;
    This_EmbeddingMatrix(1,3) = 1;
    This_EmbeddingMatrix(2,2) = 1;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 3) + (U_Dif(2,1) * 2) + (U_Dif(2,2) * 2) + (U_Dif(6,1) * 2) + (U_Dif(6,2) * 2) + U_Dif(3,1) + U_Dif(3,2) + U_Dif(7,1) + U_Dif(7,2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 15;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 2;
    This_EmbeddingMatrix(2,1) = 2;
    This_EmbeddingMatrix(1,3) = 1;
    This_EmbeddingMatrix(2,2) = 1;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 2) + (U_Dif(2,2) * 2) + (U_Dif(6,1) * 2) + (U_Dif(6,2) * 2) + U_Dif(3,1) + U_Dif(3,2) + U_Dif(7,1) + U_Dif(7,2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 16;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 2;
    This_EmbeddingMatrix(2,1) = 2;
    This_EmbeddingMatrix(1,3) = 1;
    This_EmbeddingMatrix(2,2) = 1;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 2) + (U_Dif(6,1) * 2) + (U_Dif(6,2) * 2) + U_Dif(3,1) + U_Dif(3,2) + U_Dif(7,1) + U_Dif(7,2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 17;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 2;
    This_EmbeddingMatrix(1,3) = 1;
    This_EmbeddingMatrix(2,2) = 1;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 2) + (U_Dif(6,2) * 2) + U_Dif(3,1) + U_Dif(3,2) + U_Dif(7,1) + U_Dif(7,2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 18;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 2;
    This_EmbeddingMatrix(1,3) = 1;
    This_EmbeddingMatrix(2,2) = 1;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 2) + U_Dif(3,1) + U_Dif(3,2) + U_Dif(7,1) + U_Dif(7,2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 19;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 1;
    This_EmbeddingMatrix(2,2) = 1;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + U_Dif(3,1) + U_Dif(3,2) + U_Dif(7,1) + U_Dif(7,2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 20;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 1;
    This_EmbeddingMatrix(2,2) = 1;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 1) + U_Dif(7,1) + U_Dif(7,2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 21;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 1;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + U_Dif(7,1) + U_Dif(7,2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 22;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 1;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 1) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 23;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + U_Dif(11,1) + U_Dif(11,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 24;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 1) ) >= EmbeddingCapatcity )
    Embedding_Status = 25;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) ) >= EmbeddingCapatcity )
    Embedding_Status = 26;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 27;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 28;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 29;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
elseif (((U_Dif(1,1) * 4) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 30;
    This_EmbeddingMatrix(1,1) = 4;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 4) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 31;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 3) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 32;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 3;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 3) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 33;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 3) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 34;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 3;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 3) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 35;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 2) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 36;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 2;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 2) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 37;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 2) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 38;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 2;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 2) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 39;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 2) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 40;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 2;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 2) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 41;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + U_Dif(4,1) + U_Dif(4,2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 42;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 1) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 43;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + U_Dif(8,1) + U_Dif(8,2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 44;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 1;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 1) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 45;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + U_Dif(12,1) + U_Dif(12,2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 46;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 1;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 1) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 47;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + U_Dif(16,1) + U_Dif(16,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 48;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 1) ) >= EmbeddingCapatcity )
    Embedding_Status = 49;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) ) >= EmbeddingCapatcity )
    Embedding_Status = 50;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 51;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 52;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 53;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
elseif (((U_Dif(1,1) * 5) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 54;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 5;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 5) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 55;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
 elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 4) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 56;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 4;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 4) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 57;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
 elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 4) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 58;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 4;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 4) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 59;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 3) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 60;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 3;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 3) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 61;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 3) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 62;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 3;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 3) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 63;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 3) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 64;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 3;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 3) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 65;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 2) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 66;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;

elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 2) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 67;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 2) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 68;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;

elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 2) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 69;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 2) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 70;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 2;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 2) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 71;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 2) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 72;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 2;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 2) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 73;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + U_Dif(5,1) + U_Dif(5,2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 74;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 1;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 1) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 75;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + U_Dif(9,1) + U_Dif(9,2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 76;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 1;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 1) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 77;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + U_Dif(13,1) + U_Dif(13,2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 78;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 1;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 1) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 79;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + U_Dif(17,1) + U_Dif(17,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 80;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 1) ) >= EmbeddingCapatcity )
    Embedding_Status = 81;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 2;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 2) ) >= EmbeddingCapatcity )
    Embedding_Status = 82;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 2;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 2) + U_Dif(10,1) + U_Dif(10,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 82;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 2;
    This_EmbeddingMatrix(2,5) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 2) + U_Dif(10,1) + U_Dif(10,2) + U_Dif(14,1) + U_Dif(14,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 84;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 2;
    This_EmbeddingMatrix(2,5) = 1;
    This_EmbeddingMatrix(3,4) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 2) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 2) + U_Dif(10,1) + U_Dif(10,2) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 85;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 2;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 2;
    This_EmbeddingMatrix(2,5) = 1;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;

elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 2) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 2) + U_Dif(10,1) + U_Dif(10,2) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 86;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 2;
    This_EmbeddingMatrix(2,5) = 1;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 2) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 2) + U_Dif(10,1) + U_Dif(10,2) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 87;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 2;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 2;
    This_EmbeddingMatrix(2,5) = 1;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;

elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 2) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 2) + U_Dif(10,1) + U_Dif(10,2) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 88;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 2;
    This_EmbeddingMatrix(2,5) = 1;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 2) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 2) + U_Dif(10,1) + U_Dif(10,2) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 89;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 2;
    This_EmbeddingMatrix(4,2) = 2;
    This_EmbeddingMatrix(2,5) = 1;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 2) + (U_Dif(17,1) * 2) + (U_Dif(17,2) * 2) + U_Dif(10,1) + U_Dif(10,2) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 90;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 2;
    This_EmbeddingMatrix(2,5) = 1;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 2) + U_Dif(10,1) + U_Dif(10,2) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 91;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 1;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + U_Dif(10,1) + U_Dif(10,2) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 92;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 1;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + (U_Dif(10,1) * 2) + (U_Dif(10,2) * 1) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 93;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 2;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + (U_Dif(10,1) * 2) + (U_Dif(10,2) * 2) + U_Dif(14,1) + U_Dif(14,2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 94;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 2;
    This_EmbeddingMatrix(3,4) = 1;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + (U_Dif(10,1) * 2) + (U_Dif(10,2) * 2) + (U_Dif(14,1) * 2) + (U_Dif(14,2) * 1) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 95;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 2;
    This_EmbeddingMatrix(3,4) = 2;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + (U_Dif(10,1) * 2) + (U_Dif(10,2) * 2) + (U_Dif(14,1) * 2) + (U_Dif(14,2) * 2) + U_Dif(18,1) + U_Dif(18,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 96;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 2;
    This_EmbeddingMatrix(3,4) = 2;
    This_EmbeddingMatrix(2,3) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + (U_Dif(10,1) * 2) + (U_Dif(10,2) * 2) + (U_Dif(14,1) * 2) + (U_Dif(14,2) * 2) + (U_Dif(18,1) * 2) + (U_Dif(18,2) * 1) ) >= EmbeddingCapatcity )
    Embedding_Status = 97;
    LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 2;
    This_EmbeddingMatrix(3,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + (U_Dif(10,1) * 2) + (U_Dif(10,2) * 2) + (U_Dif(14,1) * 2) + (U_Dif(14,2) * 2) + (U_Dif(18,1) * 2) + (U_Dif(18,2) * 2) ) >= EmbeddingCapatcity )
    Embedding_Status = 98;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 2;
    This_EmbeddingMatrix(3,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + (U_Dif(10,1) * 2) + (U_Dif(10,2) * 2) + (U_Dif(14,1) * 2) + (U_Dif(14,2) * 2) + (U_Dif(18,1) * 2) + (U_Dif(18,2) * 2) + U_Dif(15,1) + U_Dif(15,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 99;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 2;
    This_EmbeddingMatrix(3,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,5) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + (U_Dif(10,1) * 2) + (U_Dif(10,2) * 2) + (U_Dif(14,1) * 2) + (U_Dif(14,2) * 2) + (U_Dif(18,1) * 2) + (U_Dif(18,2) * 2) + U_Dif(15,1) + U_Dif(15,2) + U_Dif(19,1) + U_Dif(19,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 100;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 2;
    This_EmbeddingMatrix(3,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,5) = 1;
    This_EmbeddingMatrix(4,4) = 1;
elseif (((U_Dif(1,1) * 6) + (U_Dif(1,2) * 6) + (U_Dif(2,1) * 5) + (U_Dif(2,2) * 5) + (U_Dif(6,1) * 5) + (U_Dif(6,2) * 5) + (U_Dif(3,1) * 4) + (U_Dif(3,2) * 4) + (U_Dif(7,1) * 4) + (U_Dif(7,2) * 4) + (U_Dif(11,1) * 4) + (U_Dif(11,2) * 4) + (U_Dif(4,1) * 3) + (U_Dif(4,2) * 3) + (U_Dif(8,1) * 3) + (U_Dif(8,2) * 3) + (U_Dif(12,1) * 3) + (U_Dif(12,2) * 3) + (U_Dif(16,1) * 3) + (U_Dif(16,2) * 3) + (U_Dif(5,1) * 3) + (U_Dif(5,2) * 3) + (U_Dif(9,1) * 3) + (U_Dif(9,2) * 3) + (U_Dif(13,1) * 3) + (U_Dif(13,2) * 3) + (U_Dif(17,1) * 3) + (U_Dif(17,2) * 3) + (U_Dif(10,1) * 2) + (U_Dif(10,2) * 2) + (U_Dif(14,1) * 2) + (U_Dif(14,2) * 2) + (U_Dif(18,1) * 2) + (U_Dif(18,2) * 2) + U_Dif(15,1) + U_Dif(15,2) + U_Dif(19,1) + U_Dif(19,2) + U_Dif(20,1) + U_Dif(20,2) ) >= EmbeddingCapatcity )
    Embedding_Status = 101;
    %LastLSB = -1;
    This_EmbeddingMatrix(1,1) = 6;
    This_EmbeddingMatrix(1,2) = 5;
    This_EmbeddingMatrix(2,1) = 5;
    This_EmbeddingMatrix(1,3) = 4;
    This_EmbeddingMatrix(2,2) = 4;
    This_EmbeddingMatrix(3,1) = 4;
    This_EmbeddingMatrix(1,4) = 3;
    This_EmbeddingMatrix(2,3) = 3;
    This_EmbeddingMatrix(3,2) = 3;
    This_EmbeddingMatrix(4,1) = 3;
    This_EmbeddingMatrix(1,5) = 3;
    This_EmbeddingMatrix(2,4) = 3;
    This_EmbeddingMatrix(3,3) = 3;
    This_EmbeddingMatrix(4,2) = 3;
    This_EmbeddingMatrix(2,5) = 2;
    This_EmbeddingMatrix(3,4) = 2;
    This_EmbeddingMatrix(2,3) = 2;
    This_EmbeddingMatrix(3,5) = 1;
    This_EmbeddingMatrix(4,4) = 1;
    This_EmbeddingMatrix(4,5) = 1;
else 
    Embedding_Status = -1;
end

disp(This_EmbeddingMatrix) , disp(LastLSB);
disp(Embedding_Status);

[x y] = size(blk_Status);
Demo_blk_Status = blk_Status;
Demo_blk_Status(:) = 0;

d = 1;
for i = 1 : 1 : x
    if (blk_Status(i,3) == 4)
        Demo_blk_Status(d,:) = blk_Status(i,:);
        d = d + 1;
    end
end
for i = 1 : 1 : x
    if (blk_Status(i,3) == 3)
        Demo_blk_Status(d,:) = blk_Status(i,:);
        d = d + 1;
    end
end
for i = 1 : 1 : x
    if (blk_Status(i,3) == 2)
        Demo_blk_Status(d,:) = blk_Status(i,:);
        d = d + 1;
    end
end
for i = 1 : 1 : x
    if (blk_Status(i,3) == 1)
        Demo_blk_Status(d,:) = blk_Status(i,:);
        d = d + 1;
    end
end
        

[n m] = size(This_EmbeddingMatrix);
[x y] = size(Demo_blk_Status);
o = 1;bit=0;

       for a = 1 : 1 : n
           for b = 1 : 1 : m
               
               while EmbeddingCapatcity > 0
                     Capacity = This_EmbeddingMatrix(a,b);
               
                     if Capacity ~= 0
                        for i = 1 : 1 : x
                            
                            blk_S = Demo_blk_Status(i , 3);
                            if (a == 1 && blk_S == 4) || (a == 2 && blk_S == 3) || (a == 3 && blk_S == 2) || (a == 4 && blk_S == 1) 
                                
                                Diff_1 = Demo_blk_Status(i , 4);
                                Diff_2 = Demo_blk_Status(i , 5);
                                Diff_3 = Demo_blk_Status(i , 6);
                                Diff_4 = Demo_blk_Status(i , 7);
                                Diff_5 = Demo_blk_Status(i , 8);
                                Diff_6 = Demo_blk_Status(i , 9);
                                
                                p = Demo_blk_Status(i , 1);
                                q = Demo_blk_Status(i , 2);
                                Block = I( p:p+2 , q:q+2 );
                                NewBlock = Block;
                                
                                if ( b ==1 && ((Diff_1>=64)||(Diff_2>=64)||(Diff_3>=64)||(Diff_4>=64)||(Diff_5>=64)||(Diff_6>=64))) 
                                    
                                    for t = 1 : 1 : 3
                                        for r = 1 : 1 : 3
                                            if (t ~= 3 && r ~= 3)
                                               Diff = abs(Block(t , r) - Block(t , r+1));
                                            else
                                               Diff = -1;
                                            end
                                            
                                            if Diff >= 64
                                                
                                                Pc = dec2bin(Block(t,2),Capacity);
                                                [f e] =size(Pc);
                                                KRightmost = Pc(e-(Capacity-1):e); 
                                                
                                               if( o+(Capacity-1) > 1000)
                                                  o=1;
                                                  %break;
                                               end
                
                                               KLefttmost = Secret(o:o+(Capacity-1));
                                               o = o+(Capacity);
                                               bit=bit+Capacity;
            
                                               [f e] =size(Pc);
                                               Pc(e-(Capacity-1):e) = KLefttmost ;
  
                                               d = (bin2dec(KRightmost))-(bin2dec(KLefttmost)) ; %abs
            
                                               Pc=bin2dec(Pc);
                                               if(d>2^(Capacity-1) && 0 <= (Pc)+(2^Capacity) <= 255)
                                                   Pc=Pc+(2^Capacity);
                                               elseif(d<(-(2^(Capacity-1))) && 0 <= (Pc)-(2^Capacity) <= 255)
                                                   Pc=Pc-(2^Capacity);
                                               end
                                               
                                               NewBlock(t,2) = Pc ;
            
            
                                                
                                            end
                                        end
                                    end
                                    
                                elseif( b ==2 && ((Diff_1>=32 && Diff_1<64 )||(Diff_2 >=32 && Diff_2<64)||(Diff_3>=32 && Diff_3<64)||(Diff_4>=32 || Diff_4<64)||(Diff_5>=32 || Diff_5<64)||(Diff_6>=32 || Diff_6<64))) 
                                
                                elseif( b ==3 && ((Diff_1>=16 && Diff_1<32 )||(Diff_2 >=16 && Diff_2<32)||(Diff_3>=16 && Diff_3<32)||(Diff_4>=16 || Diff_4<32)||(Diff_5>=16 || Diff_5<32)||(Diff_6>=16 || Diff_6<32))) 
                                
                                elseif( b ==4 && ((Diff_1>=8 && Diff_1<16 )||(Diff_2 >=8 && Diff_2<16)||(Diff_3>=8 && Diff_3<16)||(Diff_4>=8 || Diff_4<16)||(Diff_5>=8 || Diff_5<16)||(Diff_6>=8 || Diff_6<16))) 
                                
                                elseif( b ==5 && ((Diff_1>=0 && Diff_1<8 )||(Diff_2 >=0 && Diff_2<8)||(Diff_3>=0 && Diff_3<8)||(Diff_4>=0 || Diff_4<8)||(Diff_5>=0 || Diff_5<8)||(Diff_6>=0 || Diff_6<8))) 
                                    
                                
                                end
                                
                            
                            end
                            
                        end
                     end
                     
               end
               
           end
       end
       




%  
% for i=1:1:x
%     blk1 = I(i,:);
%     for j=1:1:y
%         if (mod(j,3) == 0)
%             
%             blk2 = blk1(j-2:j);
%             
%             blk3 = blk1(j-2:j);
%             
%             %Step1
%             Pc = dec2bin(blk2(1,2),k);
%             
%             %Step2
%             [n m] =size(Pc);
%             KRightmost = Pc(m-(k-1):m); 
%             
%             %Step3
%             if( p+(k-1) > 1000)
%                 p=1;
%                 %break;
%             end
%             
%             KLefttmost = Secret(p:p+(k-1));
%             p = p+(k);
%             bit=bit+k;
%             
%             [n m] =size(Pc);
%             Pc(m-(k-1):m) = KLefttmost ;
%             
%             %Step4
%             d = (bin2dec(KRightmost))-(bin2dec(KLefttmost)) ; %abs
%             
%             %Step5
%             Pc=bin2dec(Pc);
%             if(d>2^(k-1) && 0 <= (Pc)+(2^k) <= 255)
%                 Pc=Pc+(2^k);
%             elseif(d<(-(2^(k-1))) && 0 <= (Pc)-(2^k) <= 255)
%                 Pc=Pc-(2^k);
%             end
%             
%             blk2(1,2) = Pc ;
%             
%             
%             P1 =dec2bin( blk2(1,1));
%             P2 =dec2bin( blk2(1,3));
%             P1 =bin2dec( P1 );
%             P2 =bin2dec( P2 );
%             
%             %Step6
%             d1 = abs(P1 - Pc);
%             d2 = abs(P2 - Pc);
%                     
%     
%     I(i,:) = blk1;
%     
% end%for
% 

% imwrite(I,'G:\Orginal_image.gif','gif');
% figure,imshow(I); % tasvire vorudi

