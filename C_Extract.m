%% C-Extract

%Div
%k

[filename, pathname] = uigetfile({'*.gif','GIF file'},'Please select Stego-image');
QueryPath=[pathname,filename];
QueryImage=imread(QueryPath);
% imshow (QueryImage);
disp('         Ok , Stego-image selected.');
disp(' ')


I = QueryImage;
Z=I ;


Secret_Out = '' ;

for i=1:1:x
    blk1 = I(i,:);
    for j=1:1:y
        if (mod(j,3) == 0)
            blk2 = blk1(j-2:j);
            
            %Step1
            Pc = dec2bin(blk2(1,2),k);
            [n m] =size(Pc);
            KRightmost = Pc(m-(k-1):m); 
            
            if isempty(Secret_Out)
                Secret_Out = KRightmost ;
            else
                [n m] =size(KRightmost);
                [z x] =size(Secret_Out);
                Secret_Out(x+1:((m-n)+1)+(x) ) =  KRightmost ;
            end
                
            
            %Step2
            P1 =dec2bin( blk2(1,1));
            P2 =dec2bin( blk2(1,3));
            P1 =bin2dec( P1 );
            P2 =bin2dec( P2 );
            Pc =bin2dec( Pc );
            
            d1 = abs(P1 - Pc);
            d2 = abs(P2 - Pc);
            
            %Step3
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

                S1 = d1 - l1;
                S2 = d2 - l2;
                
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

                S1 = d1 - l1;
                S2 = d2 - l2;
            end
            
                %Step4
                
                
                %Step5
                S1 = dec2bin(S1,t1);
                S2 = dec2bin(S2,t2);
                
                if (size(S1) == [1 1] )
                   if (S1 == '0' && t1 == 3)
                      S1='000';
                   elseif (S1 == '0' && t1 == 4)
                      S1 = '0000';
                   elseif (S1 == '0' && t1 == 5)
                      S1 = '00000';
                   elseif (S1 == '0' && t1 == 6)
                      S1 = '000000';
                   end
                end
                
                if (size(S2) == [1 1] )
                  if (S2 == '0' && t2 == 3)
                      S2='000';
                  elseif (S2 == '0' && t2 == 4)
                      S2 = '0000';
                  elseif (S2 == '0' && t2 == 5)
                      S2 = '00000';
                  elseif (S2 == '0' && t2 == 6)
                      S2 = '000000';
                  end
                end
                
                %Secret_Out = Secret_Out + S1;
                [n m] =size(S1);
                [z x] =size(Secret_Out);
                Secret_Out(x+1:((m-n)+1)+(x) ) =  S1 ;
                
                
                %Secret_Out = Secret_Out + S2;
                [n m] =size(S2);
                [z x] =size(Secret_Out);
                Secret_Out(x+1:((m-n)+1)+(x) ) =  S2 ;

        end
    end
end