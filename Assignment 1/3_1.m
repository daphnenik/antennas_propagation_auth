clear all;

Si = @(x) sinint(x);
Ci = @(x) cosint(x);

n0=12*pi;
lambda = 1;
k = 2*pi/lambda;
l = lambda/2;
d = linspace(0,3,120);

R21 = zeros(1,120);
X21 = zeros(1,120);

for i = 1: length(d)

u0 = k*d(i);
u1 = k*(sqrt(d(i)^2+l^2)+l);
u2 = k*(sqrt(d(i)^2+l^2)-l);

R21(i) = (n0/4*pi)*(2*Ci(u0)-Ci(u1)-Ci(u2));
X21(i) = -(n0/4*pi)*(2*Si(u0)-Si(u1)-Si(u2));

Z21(i) =  R21(i) + (1i)*X21(i);
end

figure;
plot(d/lambda, R21);
hold on
plot(d/lambda, X21);
xlabel('d/lambda');
ylabel('Mutual Impedance Z21')
legend('R21','X21');
