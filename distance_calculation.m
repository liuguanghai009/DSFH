function  dist = distance_calculation(feature,OSSH)

HCnum = length(OSSH);

dim = length(feature);

%%

dist = 0;

for n=1:dim
    for m=1:HCnum
        if (abs(feature(1,n)) + abs(OSSH(1,m)) ~= 0.0)
            dist = dist+ abs(feature(1,n) - OSSH(1,m))/(abs(feature(1,n)) + abs(OSSH(1,m)));
        else
            dist = dist +0.0;
        end
    end
end

  

%%
end
