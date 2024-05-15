N = 16;
M = 12;
lambda = 1;
d_value = [lambda/2]; % Τιμές αποστάσεων d
theta_values = [0, pi/6, pi/3, pi/2]; % Τιμές γωνιών θ
phi_values = pi/2 - theta_values;

theta = linspace(0,pi,300);
phi = linspace(0,2*pi,300);
[theta_mesh, phi_mesh] = meshgrid(theta, phi);


for j = 1:length(phi_values)
dx(j) = -(2*pi/lambda)*d_value*cos(phi_values(j))*sin(pi/2);
dz(j) = -(2*pi/lambda)*d_value*cos(pi/2);


yx = (2*pi/lambda)*d_value*cos(phi).*sin(theta)+dx(j);
yz = (2*pi/lambda)*d_value*cos(theta)+dz(j);

AFx = 0; AFz = 0;

for n = 0:N-1
    AFx = AFx + exp(1i*n*yx);
end

for m = 0:M-1
    AFz = AFz + exp(1i*m*yz);
end

AF = AFx.*AFz; AFmag = abs(AF);

f = @(theta, phi) (AFmag.^2).*sin(theta);

d_theta = (pi - 0) / 1200;
d_phi = (2*pi - 0) / 1200;

z_values = f(theta_mesh, phi_mesh);

% Calculate the double integral using Riemann sums
integral_value(j) = sum(sum(z_values * d_theta * d_phi));

D(j) = 4*pi*(max(AFmag)^2)/(integral_value(j));
disp(['Directivity Value: ', num2str(10*log10(D(j))) ' for θ = ', num2str(rad2deg(theta_values(j)))]);

end
