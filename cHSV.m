function colormap = cHSV( HSV, colnum1,  colnum2, colnum3)

[hei,wid,~] = size(HSV);

colormap = zeros(hei,wid);

%%
for i=1:hei
    for j=1:wid
        
        %%
        HI = fix(HSV(i,j,1) * colnum1);
        
        if HI > (colnum1-1)
            HI = colnum1 - 1;
        end
        if HI < 0
            HI = 0;
        end
        %%
        
        SI = fix(HSV(i,j,2) * colnum2);
        
        if SI > (colnum2-1)
            SI = colnum2-1 ;
        end
        if (SI <0)
            SI = 0;
        end
        %%
        VI = fix(HSV(i,j,3) * colnum3);
        
        if  VI > colnum3-1
            VI = colnum3-1;
        end
        if VI < 0
            VI = 0;
        end
        
        %%
            colormap(i, j) = (colnum3 * colnum2) * HI + colnum3 * SI+ VI+1; 
        %%
    end
end
%%
end