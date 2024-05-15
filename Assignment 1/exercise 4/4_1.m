AFplot = compute_AF([1 1.963 2.771 3.602 4]);

function AFmag = compute_AF(p)
%I1 = p(1); I2 = p(2); I3 = p(3); I4 = p(4); I5 = p(5); 

lambda = 1;
d = lambda/2;
k = 2*pi/lambda;
N = 10;

theta = deg2rad(0:1:180);
AFmag = zeros(length(theta),1);
for i = 1: length(theta)
    dz = 0;
    yz = k*d*cos(theta(i))+dz;

    AFz1 = 0;
    AFz2 = 0;
    for n = 1:N/2
            AFz1 = AFz1 + p(n)*exp(1i*(n-1)*yz);
    end
    for n = (N/2+1):N
            AFz2 = AFz2 + p(N-n+1)*exp(1i*(n-1)*yz);
    end
    AFz = AFz1 + AFz2;
    AFmag(i) = abs(AFz);
end
figure(1);
plot(theta,AFmag)
figure(2);
polarplot(theta,AFmag)
ax = gca;
ax.ThetaZeroLocation = 'bottom';
end