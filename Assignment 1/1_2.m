
% Υπολογισμός οριζόντιας ακτινοβολίας

radiation_plot(0,linspace(0,pi,180));

function [] = radiation_plot(phi,theta)

N = 16;
M = 12;
lambda = 1;
d_values = [lambda/2, 3*lambda/4]; % Τιμές αποστάσεων d
theta_values = deg2rad([0, 30, 60, 90]); % Τιμές γωνιών θ σε μοίρες
phi_values = pi/2 - theta_values;

for i = 1:length(d_values)
    for j = 1:length(phi_values)
    dx(i,j) = -(2*pi/lambda)*d_values(i)*cos(phi_values(j))*sin(pi/2);
    dz(i,j) = -(2*pi/lambda)*d_values(i)*cos(pi/2);


    yx = (2*pi/lambda)*d_values(i)*cos(phi_values(j))*sin(theta)+dx(i,j);
    yz = (2*pi/lambda)*d_values(i)*cos(theta)+dz(i,j);

    AFx = 0; AFz = 0;

    for n = 0:N-1
        AFx = AFx + exp(1i*n*yx);
    end

    for m = 0:M-1
        AFz = AFz + exp(1i*m*yz);
    end

    AF = AFx.*AFz; AFmag = abs(AF);
    
    figure;
    polarplot(theta,AFmag);
    title(['Κατακόρυφη Ακτινοβολία, d = ', num2str(d_values(i)), ', θ = ', num2str(rad2deg(theta_values(j))), ' μοίρες']);
        end 
end
end

