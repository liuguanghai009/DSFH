function  arr = normalization(OSSH,FC )

ymin=min(FC,[],'all');

ymax=max(FC,[],'all');

xmax=max(OSSH,[],'all');

xmin=min(OSSH,[],'all');

arr = (ymax-ymin).*(OSSH-xmin)./(xmax-xmin) + ymin;
 
end

