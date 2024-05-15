clear;

Si = @(x) sinint(x);
Ci = @(x) cosint(x);

lambda = 1;
k = 2*pi/lambda;
l = lambda/2;
d=[lambda/4 lambda/2];
d1 = lambda/4;
n0 = 12*pi;


for i = 1:length(d)
    
u0(i) = k*d(i);
u1(i) = k*(sqrt(d(i)^2+l^2)+l);
u2(i) = k*(sqrt(d(i)^2+l^2)-l);
R(i) = (n0/4*pi)*(2*Ci(u0(i))-Ci(u1(i))-Ci(u2(i)));
X(i) = -(n0/4*pi)*(2*Si(u0(i))-Si(u1(i))-Si(u2(i)));

Z(i) =  R(i) + (1i)*X(i);

end

% Define impedance matrix elements
Z11 = 73.1 + (1i)*42.5;
Z12 = Z(1);
Z13 = Z(2);

I1 = abs(-Z12/(Z11 + Z13));
I2 = I1*(Z11 + Z13)/-Z12;
I3 = I1;

theta = 90;
fi = linspace(0, 2*pi, 360);

AF = I1*exp(-1i*k*d1*cos(fi)*sin(theta)) + I2*exp(1i*0*k*d1*cos(fi)*sin(theta)) + I3*exp(1i*1*k*d1*cos(fi)*sin(theta));


Zin = Z11 - (2*Z12^2/(Z11 + Z13))

% Plot the radiation pattern
figure;
polarplot(fi, abs(AF), 'LineWidth', 2);
title('Radiation Pattern of Three-Element Array');
