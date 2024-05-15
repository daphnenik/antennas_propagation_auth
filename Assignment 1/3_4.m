d1 = linspace(0.0001,1,10) ;
h = linspace(0.0001,1,10) ;
threshold = 0.3; % threshold for Gamma

Gamma=zeros(length(d1),length(h));
for i=1:length(d1)
    for j=1:length(h)
        Gamma(i,j)=refc(d1(i),h(j));
    end
end

% Plot the contour plot
figure;
contour(d1, h, abs(Gamma), [threshold, threshold],'ShowText','on', 'LineWidth', 2);
xlabel('Distance d'); 
ylabel('Distance h'); 
title('Contour Plot: Reflection Coefficient Magnitude < 0.3');
grid on;

figure;
surf(d1,h, abs(Gamma)); 
xlabel('Distance d'); 
ylabel('Distance h'); 
zlabel('Magnitude of Reflection Coefficient'); 
title('Reflection Coefficient Magnitude for different d,h'); 
grid on; 

function G = refc(d,h)
Z0 = 50;
Z_self = 73.1 + (1i)*42.5; 
Z1 = Z_mutual(d); 
Z2 = Z_mutual(2*d);
Z3 = Z_mutual(2*h);
Z4 = Z_mutual(sqrt((2*h)^2 + d^2)); 
Z5 = Z_mutual(sqrt((2*h)^2 + (2*d)^2));

I1_I2 = (Z4 - Z1)./(Z2 - Z3 - Z5 + Z_self);
Zin = (Z_self - Z3)+2*(Z1 - Z4).*I1_I2;
G = abs((Zin - Z0)/(Zin + Z0));
end


function Z =  Z_mutual(d)
Si = @(x) sinint(x);
Ci = @(x) cosint(x);

    u0=2*pi*d;
    u1=2*pi*(sqrt(d^2+(1/2)^2)+1/2);
    u2=2*pi*(sqrt(d^2+(1/2)^2)-1/2);
    R=120*(2*Ci(u0)-Ci(u1)-Ci(u2))/4;
    X=-120*(2*Si(u0)-Si(u1)-Si(u2))/4;
    Z=R+1i*X;
end