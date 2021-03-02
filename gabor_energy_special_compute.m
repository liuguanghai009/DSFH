
function gaboresum = gabor_energy_special_compute(ori,sigma)

gamma = 0.50;
lambda = 7.0;

phi00 = 0.0;
phi11 = -pi/2.0;

filter00 = simplefunction(sigma, ori, gamma, lambda,phi00);

filter11 = simplefunction(sigma, ori, gamma, lambda, phi11);

sum1 = sum(filter00(:,:),[1 2]);

sum2 = sum(filter11(:,:),[1 2]);

gaboresum = sqrt(sum1*sum1 + sum2*sum2);

end