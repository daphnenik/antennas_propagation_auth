AFplot = sum_AF_weighted([1 1.644 2.614 3.485 4]);

function sum_AF_weighted = sum_AF_weighted(p)
%I1 = p(1); I2 = p(2); I3 = p(3); I4 = p(4); I5 = p(5); 

lambda = 1;
d = lambda/2;
k = 2*pi/lambda;
N = 10;

theta = deg2rad(0:1:180);
AFmag = zeros(length(theta),1);
sum_AF_weighted = 0;
for i = 1:length(theta)
    w0 = 1;
    wmax = 20;
    w(i) = w0 + (wmax - w0) * theta(i) / max(theta);

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
    sum_AF_weighted = sum_AF_weighted + w(i)*AFmag(i);
end
figure(1);
plot(theta,AFmag)
title('Γραμμικό Διάγραμμα Ακτινοβολίας');
figure(2);
polarplot(theta,AFmag)
title('Πολικό Διάγραμμα Ακτινοβολίας');
ax = gca;
ax.ThetaZeroLocation = 'bottom';
end
