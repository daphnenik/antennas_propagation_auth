clear;
phi=0;
theta0=linspace(0, pi, 1000);
theta=pi/2;
lambda = 1;
k = 2*pi/lambda;

h=lambda/8;

A=zeros(1,length(theta0));

for j = 1:length(theta0)
     Ax(j)=1i*sin(theta0(j))*(exp(-1i*k*h*cos(phi)*sin(theta))+exp(1i*k*h*cos(phi)*sin(theta)));
     Az(j)=cos(theta0(j))*(exp(-1i*k*h*cos(phi)*sin(theta))-exp(1i*k*h*cos(phi)*sin(theta)));
     A(j) = Az(j)+Ax(j);
end

% Find the index where A is maximum
[~, maxIndex] = max(abs(A));

theta_max = rad2deg(theta0(maxIndex));

fprintf('Theta_max: %.4f degrees\n', theta_max);