function energyMap = gaborEnergy(indata,ori, sigma)

gamma = 0.50;

lambda = 7.0;

phi00 = 0.0;

phi11 = - pi / 2.0;

gobor1 = simplefunction(sigma,ori,gamma,lambda,phi00); 

gobor2 = simplefunction(sigma,ori,gamma,lambda,phi11);

%%

[hei,wid]=size(indata);

inputData = imresize(indata,[hei+8 wid+8]);

result00 = conv2(inputData,gobor1,'valid');
result11 = conv2(inputData,gobor2,'valid');

energyMap = sqrt(result00.*result00 + result11.*result11);

end