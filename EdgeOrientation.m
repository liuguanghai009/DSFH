function  ori = EdgeOrientation(data, num)

[hei,wid] = size(data);

ori = zeros(hei,wid);

[~,~,gv,gh]= edge(data,'sobel');

%%
for i=1:hei
    for j=1:wid
   
        %%
        mx = gh(i,j);   
        my = gv(i,j); 
        %%
        
        theta = fix(90 + atan(my /mx) * 180 / pi);
        
        index = fix(theta * num / 180);
        
        %%
        if index > (num-1)
            index = num - 1 ;
        end
        if  index < 0
            index = 0;
        end
        %%
        ori(i,j) = index + 1;
        %%
    end
end
%%
end
