function  DSFH = ranking_sum(FC_NS,HFC,OSSH,DSC)

[hei,wid,K] = size(FC_NS);

HCnum = length(OSSH);

%%

dist = zeros(1,K );

for n=1:K
    for m=1:HCnum
        if (abs(HFC(1,n)) + abs(OSSH(1,m)) ~= 0.0)
            dist(1,n) = dist(1,n)+ abs(HFC(1,n) - OSSH(1,m))/(abs(HFC(1,n)) + abs(OSSH(1,m)));
        else
            dist(1,n) = dist(1,n) + 0.0;
        end
    end
end

%%

[~,index] = sort(dist,'ascend');

SRC = zeros(hei,wid,K );

for v=1:K/2
    SRC(:,:,index(v)) = (FC_NS(:,:,index(v)).^2).* dist(1,index(v));
end

%%

filRC = sum(SRC,[1 2]);

SN = K  / DSC ;

DSFH = zeros(1,DSC);

%%
for i=1:DSC
    for j=1:SN
        sz = (i-1) * SN + j;
        DSFH(1,i) = DSFH(1,i) + filRC(1,sz).^2;
    end
end

%%
end
