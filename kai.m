path='./georec_train/';
files=dir([path,'*']);
for i=3:5002
file=[path,files(i).name];
load(file)
[col,cum,p]=size(Rec);
for turn=1:10
a=zeros(col,cum,p);
b=Rec;
for m=1:col
    for n=1:cum
        for k=1:p
            if b(m,n,k)==0||b(m,n,k)==1
                a(m,n,k)=1;
            end
        end
    end
end
for m=2:col-1
    for n=2:cum-1
        for k=1:p
            if a(m,n,k)==1
                c=sum(a(m-1:m+1,n-1:n+1,k));
                if c<5
                    ave=0;
                    t=0;
                    for l=m-1:m+1
                        for j=n-1:n+1
                            if a(l,j,k)==0
                                ave=ave+Rec(l,j,k);
                                t=t+1;
                            end
                        end
                    end
                    if t>0
                    ave=ave/t;
                    b(m,n,k)=ave;
                    end
                end
            end
        end
    end
end
Rec=b;
end   
%Rec=rgb2gray(Rec);
%imshow(b)
save(['./georec_train/georec',num2str(i-2),'.mat'],'Rec');
end