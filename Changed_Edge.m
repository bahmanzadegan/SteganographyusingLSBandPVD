clc;
clear all;

[filename, pathname] = uigetfile({'*.gif','GIF file'},'Please select Cover-image');
QueryPath=[pathname,filename];
QueryImage=imread(QueryPath);
% imshow (QueryImage);
disp('%%%%%%%%%% Changed-Method %%%%%%%%%%');
disp('=> Cover-image selected...');
disp(QueryPath);
disp(' ');

% h = seqgen.pn('Shift', 0);
% % Output 10 PN bits
% %set(h, 'NumBitsOut', 1215252);
% set(h, 'NumBitsOut', 1300000);
% S=generate(h);
% Secret = textread('Secret.txt','%q');
% Secret =char(Secret) ;

Secret = char ('1010000100110101001010110100001000001001000110110110111000110100001110000011001101011000011000101100111110110011001000000111010100100110000011011010000110101100001110011110000101111011010101000001001110000111100110001000001110001000101010111101100000001101001111111010011000010101001101011011100101101101011100111110100111100011011100111001011010011101000010011111100110001101111101010000001000101101101001101000001010000000100110011100110011001100010100001000000101111011010010100011010001110011100001110000110111010000001010100010110110010101001000110001001111011111000001100101100000100011110110100100001000100010101011010010100001111110000111110110110010011000000110011001000110000111111001101001100101111100110101000010011101010101100000010000000101010111011110101001111001010000111110100110100011010010111100100111001110101010101111010000100101010001010011000110100010000010001110111100111100010110110100000010000100101101110111110100010100110101110111010000111100000000111111110111101100010000');
%Lentgh 1000

I = QueryImage;
Z=I;

[x y]=size(I);
u=1;
p=1;

Div = 63 ; % 31|63
k = 3 ;    % 3|4|5|6

t1=0;
t2=0;

b=0; % error
bit=0;

flag=0;
T1=0;
T2=0;
T3=0;
T4=0;
T5=0;
T6=0;
T7=0;
T8=0;
T9=0;
T10=0;
T11=0;
T12=0;
T13=0;
T14=0;
T15=0;

N1=0;
N2=0;
N3=0;
N4=0;
N5=0;

FlagP1=0;
FlagP2=0;

BIT = 0;

% for h=1:1:2
%     if h == 1
%         Div = 31;
%     else
%         Div = 63;
%     end
%     
%     I = QueryImage;
%     b=0; % error
%     bit=0;
    
% for k=3:1:6
%     
%     I = QueryImage;
%     b=0; % error
%     bit=0;
    
for i=1:1:x
    blk1 = I(i,:);
    for j=1:1:y
        if (mod(j,3) == 0)
            blk2 = blk1(j-2:j);
            
            %Step1
            Pc = dec2bin(blk2(1,2),k);
            
            %Step2
            [n m] =size(Pc);
            KRightmost = Pc(m-(k-1):m); 
            
            %Step3
            if( p+(k-1) > 1000)
                p=1;
                %break;
            end
            
            if p <= 0
                p = 1 ;
            end
            
            KLefttmost = Secret(p:p+(k-1));
            p = p+(k);
            bit=bit+k;
            
            [n m] =size(Pc);
            Pc(m-(k-1):m) = KLefttmost ;
            
            %Step4
            d = (bin2dec(KRightmost))-(bin2dec(KLefttmost)) ; %abs
            
            %Step5
            Pc=bin2dec(Pc);
            if(d>2^(k-1) && 0 <= (Pc)+(2^k) <= 255)
                Pc=Pc+(2^k);
            elseif(d<(-(2^(k-1))) && 0 <= (Pc)-(2^k) <= 255)
                Pc=Pc-(2^k);
            end
            
            blk2(1,2) = Pc ;
            
            
            P1 =dec2bin( blk2(1,1));
            P2 =dec2bin( blk2(1,3));
            P1 =bin2dec( P1 );
            P2 =bin2dec( P2 );
            
            %Step6
            d1 = abs(P1 - Pc);
            d2 = abs(P2 - Pc);
            
            if (d1>63)
                FlagP1 = 1;
            else 
                FlagP1 = 0;
            end
            if (d2>63)
                FlagP2 = 1;
            else 
                FlagP2 = 0;
            end
            
            if ( (d1>63)&&(d2>63) || (d1>63)&&(d2>63))
                T1=T1+1;
                flag=0;
            elseif ( (d1>63)&&(d2>31) || (d1>31)&&(d2>63))
                T12=T12+1;
                flag=0;
            elseif ( (d1>63)&&(d2>15) || (d1>15)&&(d2>63))
                T13=T13+1;
                flag=0;
            elseif ( (d1>63)&&(d2>7) || (d1>7)&&(d2>63))
                T4=T4+1;
                flag=0;
            elseif ( (d1>63)&&(d2>0) || (d1>0)&&(d2>63))
                T5=T5+1;
                flag=0;
            elseif ( (d1>31)&&(d2>31) || (d1>31)&&(d2>31))
                T6=T6+1;
                flag=0;
            elseif ( (d1>31)&&(d2>15) || (d1>15)&&(d2>31))
                T7=T7+1;
                flag=0;
            elseif ( (d1>31)&&(d2>7) || (d1>7)&&(d2>31))
                T8=T8+1;
                flag=0;
            elseif ( (d1>31)&&(d2>0) || (d1>0)&&(d2>31))
                T9=T9+1;
                flag=0;
            elseif ( (d1>15)&&(d2>15) || (d1>15)&&(d2>15))
                T10=T10+1;
                flag=0;
            elseif ( (d1>15)&&(d2>7) || (d1>7)&&(d2>15))
                T11=T11+1;
                flag=0;
            elseif ( (d1>15)&&(d2>0) || (d1>0)&&(d2>15))
                T12=T12+1;
                flag=0;
            elseif ( (d1>7)&&(d2>7) || (d1>7)&&(d2>7))
                T13=T13+1;
                flag=0;
            elseif ( (d1>7)&&(d2>0) || (d1>0)&&(d2>7))
                T14=T14+1;
                flag=0;
            elseif ( (d1>0)&&(d2>0) || (d1>0)&&(d2>0))
                T15=T15+1;
                flag=0;
            end
                
            
            if(d1 >= 64 )
                    N1=N1+1;
            elseif(d1 >= 32)
                    N2=N2+1;
            elseif(d1 >= 16)
                    N3=N3+1;
            elseif(d1 >= 8)
                    N4=N4+1;
            else
                    N5=N5+1;
            end
            
            if(d2 >= 64 )
                    N1=N1+1;
            elseif(d2 >= 32)
                    N2=N2+1;
            elseif(d2 >= 16)
                    N3=N3+1;
            elseif(d2 >= 8)
                    N4=N4+1;
            else
                    N5=N5+1;
            end


          t1=0;
          t2=0;
 %% P1    
         if (FlagP1==1)
             
            %Step7 && 8
            if(Div==31)
                
                if(d1 <= 7)
                    t1 = 3;
                elseif(d1 <= 15)
                    t1 = 3;
                elseif(d1 <= 31)
                    t1 = 3;
                elseif(d1 <= 63)
                    t1 = 4;
                else
                    t1 = 4;
                end
                
                if( p+(t1-1) > 1000)
                   p=1;
                   %break;
                end
                
                S1 = Secret(p:p+(t1-1));
                p = p+(t1);
                bit=bit+t1;
                S1 = bin2dec(S1) ;
               
                if(d1 >= 64 )
                    l1 = 64;
                elseif(d1 >= 32)
                    l1 = 32;
                elseif(d1 >= 16)
                    l1 = 16;
                elseif(d1 >= 8)
                    l1 = 8;
                else
                    l1 = 0;
                end
                
                d11 = l1 + S1;
                
            end
            
            if(Div==63)
                
                if(d1 <= 7)
                    t1 = 3;
                elseif(d1 <= 15)
                    t1 = 3;
                elseif(d1 <= 31)
                    t1 = 4;
                elseif(d1 <= 63)
                    t1 = 5;
                else
                    t1 = 6;
                end
                
                if( p+(t1-1) > 1000)
                   p=1;
                   %break;
                end
                
                S1 = Secret(p:p+(t1-1));
                p = p+(t1);
                bit=bit+t1;
                S1 = bin2dec(S1) ;
               
                if(d1 >= 64 )
                    l1 = 64;
                elseif(d1 >= 32)
                    l1 = 32;
                elseif(d1 >= 16)
                    l1 = 16;
                elseif(d1 >= 8)
                    l1 = 8;
                else
                    l1 = 0;
                end
                
                d11 = l1 + S1;
                
            end
            
            
                %Step9
                P11 = Pc - d11; 
                P111 = Pc + d11;
                
                P1test = P1;

                %Step10
                if( abs(P1-P11)<abs(P1-P111) )
                    P1 = P11 ;
                else 
                    P1 = P111;
                end
                
                blk2(1,1) = P1 ;
                
                %new
                if  ( (P2 < 0 || P2 > 255) && (t2-1 >= 3))
                    b = b+1 ;
                end
                
                while  ( (P1 < 0 || P1 > 255) && (t1-1 >= 3)) % || P11<0 || P111>255 )

                    p = p-(t1);
                    bit=bit-t1;
                    
                    t1 = t1 - 1 ;
                    S1 = Secret(p:p+(t1-1));
                    p = p+(t1);
                    bit=bit+t1;
                    S1 = bin2dec(S1) ;
                
                    if(l1 == 64 )
                        l1 = 32;
                    elseif(l1 == 32)
                        l1 = 16;
                    elseif(l1 == 16)
                        l1 = 8;
                    elseif(l1 == 8)
                        l1 = 0;
                    else
                        l1 = 0;
                    end
                
                    d11 = l1 + S1;
                
                    %Step9
                    P11 = Pc - d11; 
                    P111 = Pc + d11;
                
                    %new
                    P1test = P1;
                    %new

                    %Step10
                    if( abs(P1-P11)<abs(P1-P111) )
                        P1 = P11 ;
                    else 
                        P1 = P111;
                    end

                    blk2(1,1) = P1 ;
                    
                    %break;
                    
                end
                %    new
         end  
%% P2       
         if(FlagP2==1)
             
            if(Div==31)
                
                if(d2 <= 7)
                    t2 = 3;
                elseif(d2 <= 15)
                    t2 = 3;
                elseif(d2 <= 31)
                    t2 = 3;
                elseif(d2 <= 63)
                    t2 = 4;
                else
                    t2 = 4;
                end
                
                if( p+(t2-1) > 1000)
                   p=1;
                   %break;
                end
                
               S2 = Secret(p:p+(t2-1));
               p = p+(t2);
               bit=bit+t2;
               S2 = bin2dec(S2);
                
                if(d2 >= 64 )
                    l2 = 64;
                elseif(d2 >= 32)
                    l2 = 32;
                elseif(d2 >= 16)
                    l2 = 16;
                elseif(d2 >= 8)
                    l2 = 8;
                else
                    l2 = 0;
                end
                d22 = l2 + S2;
                
            end
            
            if(Div==63)
                
                if(d2 <= 7)
                    t2 = 3;
                elseif(d2 <= 15)
                    t2 = 3;
                elseif(d2 <= 31)
                    t2 = 4;
                elseif(d2 <= 63)
                    t2 = 5;
                else
                    t2 = 6;
                end
                
                if( p+(t2-1) > 1000)
                  p=1;
                  %break;
                end
                
               S2 = Secret(p:p+(t2-1));
               p = p+(t2);
               bit=bit+t2;
               S2 = bin2dec(S2);
                
                if(d2 >= 64 )
                    l2 = 64;
                elseif(d2 >= 32)
                    l2 = 32;
                elseif(d2 >= 16)
                    l2 = 16;
                elseif(d2 >= 8)
                    l2 = 8;
                else
                    l2 = 0;
                end
                d22 = l2 + S2;
                
            end
            
            
                %Step9
                P22 = Pc - d22 ;
                P222 = Pc + d22;
                
                P2test = P2;
        
                if( abs(P2-P22)<abs(P2-P222) )
                    P2 = P22 ;
                else 
                    P2 = P222;
                end
                
                blk2(1,3) = P2 ;
                
                %new
                if  ( (P2 < 0 || P2 > 255) && (t2-1 >= 3))
                    b = b+1 ;
                end
                
                while  ( (P2 < 0 || P2 > 255) && (t2-1 >= 3)) 

                    p = p-(t2);
                    bit=bit-t2;
                    
                    
                    t2 = t2 - 1 ;
                    S2 = Secret(p:p+(t2-1));
                    p = p+(t2);
                    bit=bit+t2;
                    S2 = bin2dec(S2) ;
                
                    if(l2 == 64 )
                        l2 = 32;
                    elseif(l2 == 32)
                        l2 = 16;
                    elseif(l2 == 16)
                        l2 = 8;
                    elseif(l2 == 8)
                        l2 = 0;
                    else
                        l2 = 0;
                    end
                
                    d22 = l2 + S2;
                
                    %Step9
                    P22 = Pc - d22; 
                    P222 = Pc + d22;
                
                    P2test = P2;

                    %Step10
                    if( abs(P2-P22)<abs(P2-P222) )
                        P2 = P22 ;
                    else 
                        P2 = P222;
                    end
                    

                    blk2(1,3) = P2 ;
                   
                end
                %  new
        end  
%%      
        if(FlagP1==1 || FlagP2==1)
            
               BIT = (t1+t2+k) + BIT;
               
               blk1(j-2:j) = blk2;
%        else
%            continue;
        end
               
        end%if
        
        if( p+(k-1) > 1000 || p+(t1-1) > 1000 || p+(t2-1) > 1000)
           p=1;
           %break;
        end
        
        
%         if (bit >= 801684)
%             break;
%         end
        
    end %for
    
    I(i,:) = blk1;
    
    if( p+(k-1) > 1000 || p+(t1-1) > 1000 || p+(t2-1) > 1000)
        p=1;
       %break;
    end
    
%     
%         if (bit >= 801684)
%             break;
%         end
    
end%for


% imwrite(I,'G:\Orginal_image.gif','gif');
% figure,imshow(I); % tasvire vorudi


%% Performance evaluation

% PSNR Function
[SNR,wPSNR] = PSNRfunction_Weight(Z,I);
disp('--------------------------------');
disp('Div ') , disp(Div) , disp('K ') , disp(k);
disp('wPSNR Weight Peak Signal to Noise Ratio');
disp(wPSNR);

% Quality Function
[Q] = Qualtiyfunction(Z,I);
disp('Quality index Q');
disp(Q);
disp('Embedding Capacity ');
disp(bit)
disp('--------------------------------');
% Correlation value
% Corelation_value = corr2(I,Z);
% disp('Correlation value');
% disp(Corelation_value);

% Bit error rate
% disp('Bit error rate');
% disp(nnz(message-rec_M)/numel(M));

%% Plotting
figure,subplot(1,2,1),imshow(Z),title({'Changed method';'Cover image';['Div = ',num2str(Div)];['K = ',num2str(k)];'';''});
subplot(1,2,2),imshow(I),title({'';'Stego image';['wPSNR = ',num2str(wPSNR),' dB'];['Quality = ',num2str(Q),];['Embedding Capacity = ',num2str(BIT),' bpp'];['Error = ',num2str(b)]});

%imwrite(Z,'G:\Propozal\Result\Cover_image-Change.gif','gif');
%imwrite(I,'G:\Propozal\Result\Stego_image-Change.gif','gif');

%end
%end
K = imabsdiff(I,Z);
figure;
imshow(K,[0 255]);