function FCLFH= FCLFH_feature(FC_NS,OSSH,DSC)

FRC = sum(FC_NS,[1 2]); 
 
OSSH = normalization(OSSH,FRC);

FCLFH = ranking_sum(FC_NS,FRC,OSSH,DSC);

end