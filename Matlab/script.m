Sigma=[4 4; 4 9];
class1=mvnrnd([10 10 ],Sigma,1000);
class2=mvnrnd([22 10],Sigma,1000);
samples=[class1; class2];

plot(samples(:,1),samples(:,2),'*');
hold on ;
[coeff score latent] = pca(samples);
% plot(coeff(1,:));
% plot(coeff(2,:));

points = zeros(2000,1,'double');
for i = 1 : 2000
    points(i) = dot(samples(i,:),coeff(1,:));
end
proj = points * coeff(1,:);

plot(proj(:,1), proj(:,2) , '.');

temp = score * coeff';
for i= 1:2000
    rebuilding(i , 1:2) = temp(i , 1:2) + mean(samples);
end
plot(rebuilding(:,1),rebuilding(:,2),'.');

approxError = norm(rebuilding - samples);