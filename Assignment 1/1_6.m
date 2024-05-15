
d_value = [lambda/4]; % Τιμές αποστάσεων d
theta = linspace(0,pi,300);
phi = linspace(0,2*pi,300);

A=zeros(length(theta),length(phi));
    for i=1:length(theta)
        for j=1:length(phi)
            A(i,j)=radiation_plot(d_value,phi(j),theta(i));
        end
    end
    figure
    [Phi,Theta]=meshgrid(phi,theta);
    Ax=A.*sin(Theta).*cos(Phi);
    Ay=A.*sin(Theta).*sin(Phi);
    Az=A.*cos(Theta);
    surf(Ax,Ay,Az,A,"EdgeColor","none")
    xlabel('X'); 
    ylabel('Y'); 
    zlabel('Z'); 
    title('Στερεό Ακτινοβολίας Στοιχειοκεραίας'); 
    axis equal

% Directivity 1st way
Theta_x = 2*acosd(1-(0.1398*lambda/(N*d_value)));
Theta_z = 48.4*(lambda/(M*lambda/2)); %broadside
D = 10*log10(32400/(Theta_x*Theta_z))

% Directivity 2nd way

[theta_mesh, phi_mesh] = meshgrid(theta, phi);

f = @(theta, phi) (AFmag.^2).*sin(theta);

d_theta = (pi - 0) / 1250;
d_phi = (2*pi - 0) / 1250;

z_values = f(theta_mesh, phi_mesh);

% Calculate the double integral using Riemann sums
integral_value= sum(sum(z_values * d_theta * d_phi));

D = 10*log10(4*pi*max(AFmag)^2/(integral_value));

disp(['Directivity Value: ', num2str(D)]);
  
function [AFmag] = radiation_plot(d,phi,theta)

N = 16;
M = 12;
lambda = 1;
k = 2*pi/lambda; 

dx = -k*d-(2.92/N);
dz = 0;

yx = (2*pi/lambda).*d.*cos(phi).*sin(theta)+dx;
yz = (2*pi/lambda).*cos(theta)+dz;

AFx = 0; AFz = 0;

for n = 0:N-1
    AFx = AFx + exp(1i*n*yx);
end

for m = 0:M-1
    AFz = AFz + exp(1i*m*yz);
end

AF = AFx.*AFz; AFmag = abs(AF);

end

