clear all;

Si = @(x) sinint(x);
Ci = @(x) cosint(x);

Z0 = 50;
lambda = 1;
k = 2*pi/lambda;
l = lambda/2;
d1 = [linspace(0,1,10)] ;
d2 = [linspace(1,2,10)] ;
n0 = 12*pi;

Zin = zeros(1,length(d1));
Gamma = zeros(1,length(d1));

for j = 1: length(d1)
    u0 = k*d1(j);
    u1 = k*(sqrt(d1(j)^2+l^2)+l);
    u2 = k*(sqrt(d1(j)^2+l^2)-l);

    R(j) = (n0/4*pi)*(2*Ci(u0)-Ci(u1)-Ci(u2));
    X(j) = -(n0/4*pi)*(2*Si(u0)-Si(u1)-Si(u2));

    Z(1,j) =  R(j) + (1i)*X(j);
    
    Z12(j) = Z(1,j); 
end

for i = 1: length(d2)
    u0 = k*d2(i);
    u1 = k*(sqrt(d2(i)^2+l^2)+l);
    u2 = k*(sqrt(d2(i)^2+l^2)-l);

    R(i) = (n0/4*pi)*(2*Ci(u0)-Ci(u1)-Ci(u2));
    X(i) = -(n0/4*pi)*(2*Si(u0)-Si(u1)-Si(u2));

    Z(2,i) =  R(i) + (1i)*X(i);

    Z13(i) = Z(2,i); 
end

    Z11 = 73.1 + (1i)*42.5; 
    for j =1: length(d1)
        i = j;
        Zin(j)= Z11 - (2*Z12(j)^2)/(Z11 + Z13(i));
        Gamma(j) = (Zin(j) - Z0)/(Zin(j) + Z0);
    end

    plot(d1, abs(Gamma)); 
    xlabel('Distance d/λ'); 
    ylabel('Magnitude of Reflection Coefficient'); 
    title('Reflection Coefficient Magnitude for different d'); 

grid on; 
