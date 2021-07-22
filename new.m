clc;
clear all;

[filename, pathname] = uigetfile({'*.bmp','BMP file'},'Please select Orginal-image');
QueryPath=[pathname,filename];
QueryImage=imread(QueryPath);
% imshow (QueryImage);
disp('         Ok , Orginal-image selected.');
disp(' ')

% if ndims(QueryImage)==3
%    QueryImage=rgb2gray(QueryImage);
% end

I = imresize(QueryImage,[333 333]);
%imwrite(I,'E:\Uni901\Fuzzy\Project\Source code\fuzzy\Result\Orginal_image.tif','tif');
%figure,imshow(I); % tasvire vorudi

%V=blkproc(I,[8 8],@dct2); % enteghale tasvir be hozeye dct

[x y]=size(I);
u=1;
p=1; %shomare belack

for i=1:1:x
    for j=1:1:y
        if (mod(j,3) == 0)
            j=j+1;
        else
            if I(i,j) > I(i,j+1) 
                I_1(1,u)= I(i,j) - I(i,j+1); % 2 ekhtelafee maghadir 3 pixel dar yek belack1*3
                
                I_2(1,u)= p + fix((j-1)/3) ; %shomare belak'ha
                
                u=u+1;
            else
                I_1(1,u)= I(i,j+1) - I(i,j);
                
                I_2(1,u)= p + fix((j-1)/3) ;
                
                u=u+1;
            end
        end
    end
    j=1;
    if (mod (i,3)==0 && (i) ~= 0)
        p = p + 300;
    end
end



n=0;
i=1;
j=1;
for i=1:2:u-1
   if ( I_1(i)> 63 && I_1(i+1)>63 ) 
       I_3(1,j) = I_2(i); %shomare belak'ha
       j=j+1;
       n=n+1;
   end
end

m=0;
i=1;
for i=1:2:u-1
   if ( I_1(i)< 63 && I_1(i+1)>63 ) ||  ( I_1(i)> 63 && I_1(i+1)<63 )
       m=m+1;
   end
end

s=0;
i=1;
for i=1:2:u-1
   if ( I_1(i)< 63 && I_1(i+1)<63 ) 
       s=s+1;
   end
end





u=1;
[x y]=size(I);
i=1;
j=1;
F=1;

for i=i:9:x
    for j=j:9:y
        V_u = I(i:(i-1)+9,j:(j-1)+9); % mohasebeye har belak 9*9
        
        % mohasebeye 4 factore Texture baraye har belake 9*9
        Stats = graycoprops(V_u);
        Input.Contrast(1,F) = Stats.Contrast;
        Contrast(F) = Input.Contrast(1,F) ;
        
        Input.Correlation(1,F) = Stats.Correlation;
        Correlation(F) = Input.Correlation(1,F);
        
        Input.Energy(1,F) = Stats.Energy;
        Energy(F) = Input.Energy(1,F);
        
        Input.Homogeneity(1,F) = Stats.Homogeneity;
        Homogeneity(F)= Input.Homogeneity(1,F);
        
        F=F+1;
        
        [t p]=size(V_u);
        for k=1:1:t
            for h=1:1:p
                V_1(u)=V_u(k,h); % chidane belakhaye poshte sare ham be soorate yek arraye 1bodi
                u=u+1;
            end
        end
    end
    j=1;
end

% %% Fis
% F = readfis('E:\Propozal\Fuzzy(File.fis)\fis1.fis'); 
% mfedit(F)
% %plotfis(F)
% Fuzzy_memberships = evalfis([Contrast ; Correlation ; Energy ; Homogeneity],F); %defuzz (Centroid)

%% Fis

Fuzzy = newfis('tipper');

Fuzzy = addvar(Fuzzy,'input','Contrast',[min(Contrast) max(Contrast)]);
D = max(Contrast) - min(Contrast);
Fuzzy = addmf(Fuzzy,'input',1,'poor','trapmf',[min(Contrast) min(Contrast) +((D/3)/2)+min(Contrast) (D/2)+min(Contrast)]);
Fuzzy = addmf(Fuzzy,'input',1,'good','trimf',[((D/3)/2)+min(Contrast) min(Contrast)+(D/2) max(Contrast)-((D/3)/2)]);
Fuzzy = addmf(Fuzzy,'input',1,'excellent','trapmf',[max(Contrast)-(D/2) max(Contrast)-((D/3)/2) max(Contrast) max(Contrast)]);

Fuzzy = addvar(Fuzzy,'input','Correlation',[min(Correlation) max(Correlation)]);
D = max(Correlation) - min(Correlation) ;
Fuzzy = addmf(Fuzzy,'input',2,'excellent','trapmf',[min(Correlation) min(Correlation) +((D/3)/2)+min(Correlation) (D/2)+min(Correlation)]);
Fuzzy = addmf(Fuzzy,'input',2,'good','trimf',[((D/3)/2)+min(Correlation) min(Correlation)+(D/2) max(Correlation)-((D/3)/2)]);
Fuzzy = addmf(Fuzzy,'input',2,'poor','trapmf',[max(Correlation)-(D/2) max(Correlation)-((D/3)/2) max(Correlation) max(Correlation)]);

Fuzzy = addvar(Fuzzy,'input','Energy',[min(Energy) max(Energy)]);
D = max(Energy) - min(Energy) ;
Fuzzy = addmf(Fuzzy,'input',3,'poor','trapmf',[min(Energy) min(Energy) +((D/3)/2)+min(Energy) (D/2)+min(Energy)]);
Fuzzy = addmf(Fuzzy,'input',3,'good','trimf',[((D/3)/2)+min(Energy) min(Energy)+(D/2) max(Energy)-((D/3)/2)]);
Fuzzy = addmf(Fuzzy,'input',3,'excellent','trapmf' ,[max(Energy)-(D/2) max(Energy)-((D/3)/2) max(Energy) max(Energy)]);

Fuzzy = addvar(Fuzzy,'input','Homogeneity',[min(Homogeneity) max(Homogeneity)]);
D = max(Homogeneity) - min(Homogeneity) ;
Fuzzy = addmf(Fuzzy,'input',4,'poor','trapmf',[min(Homogeneity) min(Homogeneity) +((D/3)/2)+min(Homogeneity) (D/2)+min(Homogeneity)]);
Fuzzy = addmf(Fuzzy,'input',4,'good','trimf',[((D/3)/2)+min(Homogeneity) min(Homogeneity)+(D/2) max(Homogeneity)-((D/3)/2)]);
Fuzzy = addmf(Fuzzy,'input',4,'excellent','trapmf',[max(Homogeneity)-(D/2) max(Homogeneity)-((D/3)/2) max(Homogeneity) max(Homogeneity)]);

% Fuzzy = addvar(Fuzzy,'output','Output',[0 1]);
% Fuzzy = addmf(Fuzzy,'output',1,'mf1','trimf',[0 5 5]);
% Fuzzy = addmf(Fuzzy,'output',1,'mf2','trimf',[0.3 1.9 1.9]);
% Fuzzy = addmf(Fuzzy,'output',1,'mf3','trimf',[0.4 1.45 1.45]);
% Fuzzy = addmf(Fuzzy,'output',1,'mf4','trimf',[0.5 1.25 1.25]);
% Fuzzy = addmf(Fuzzy,'output',1,'mf5','trimf',[0.6 1.13 1.13]);
% Fuzzy = addmf(Fuzzy,'output',1,'mf6','trimf',[0.7 1.06 1.06]);
% Fuzzy = addmf(Fuzzy,'output',1,'mf7','trimf',[0.8 1.02 1.02]);
% Fuzzy = addmf(Fuzzy,'output',1,'mf8','trimf',[0.9 1 1]);

Fuzzy = addvar(Fuzzy,'output','Output',[0 1]);
Fuzzy = addmf(Fuzzy,'output',1,'mf1','trimf',[0 0 0.2]);
Fuzzy = addmf(Fuzzy,'output',1,'mf2','trimf',[0 0.2 0.4]);
Fuzzy = addmf(Fuzzy,'output',1,'mf3','trimf',[0.2 0.4 0.6]);
Fuzzy = addmf(Fuzzy,'output',1,'mf4','trimf',[0.4 0.6 0.8]);
Fuzzy = addmf(Fuzzy,'output',1,'mf5','trimf',[0.6 0.8 1]);
Fuzzy = addmf(Fuzzy,'output',1,'mf6','trimf',[0.8 1 1]);


ruleList=[
1 3 1 1 1 1 1
2 0 0 0 2 0.9 2
0 2 0 0 3 0.3 2
0 0 2 0 4 0.2 2
0 0 0 2 5 0.1 2
3 1 3 3 6 1 1

% 2 1 3 3 5 1 1
% 3 2 3 3 5 1 1
% 3 1 2 3 5 1 1
% 3 1 3 2 5 1 1

];
Fuzzy = addrule(Fuzzy,ruleList);

mfedit(Fuzzy);

Fuzzy_memberships = evalfis([Contrast ; Correlation ; Energy ; Homogeneity],Fuzzy); %defuzz (Centroid)