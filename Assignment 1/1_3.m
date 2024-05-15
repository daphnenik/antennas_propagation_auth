theta=linspace(0,pi,300);
phi=linspace(0,2*pi,300);
lambda = 1;
d_values = [lambda/2, 3*lambda/4]; % Τιμές αποστάσεων d
theta_values = [0, pi/6, pi/3, pi/2]; % Τιμές γωνιών θ 
phi_values = pi/2 - theta_values;


%For d=l/2
for k=1:length(theta_values)
    A=zeros(length(theta),length(phi));
    for i=1:length(theta)
        for j=1:length(phi)
            A(i,j)=radiation_plot(d_values(1),phi_values(k),phi(j),theta(i));
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
    title(['Στερεό Ακτινοβολίας Στοιχειοκεραίας d = ', num2str(d_values(1)), ', θ = ', num2str(rad2deg(theta_values(k))), ' μοίρες']); 
    axis equal;
end
 
%For d=3l/4
for k=1:length(theta_values)
    A=zeros(length(theta),length(phi));
    for i=1:length(theta)
        for j=1:length(phi)
            A(i,j)=radiation_plot(d_values(2),phi_values(k),phi(j),theta(i));
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
    title(['Στερεό Ακτινοβολίας Στοιχειοκεραίας d = ', num2str(d_values(2)), ', θ = ', num2str(rad2deg(theta_values(k))), ' μοίρες']); 
    axis equal;
end


function [AFmag] = radiation_plot(d,p,phi,theta)

N = 16;
M = 12;
lambda = 1;

dx = -(2*pi/lambda)*d*cos(p)*sin(pi/2);
dz = -(2*pi/lambda)*d*cos(pi/2);

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