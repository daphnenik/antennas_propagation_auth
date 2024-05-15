clear all;

N = 16;
M = 12;
lambda = 1;
k = 2*pi/lambda;
d_value = lambda/2; 
theta_values = deg2rad([0, 30, 60, 90]);
phi_values = pi/2 - theta_values;

%1st way // Not applicable for θ=90
HPBW_broad = (48.4*lambda)/(N*d_value);
%HPBWs on x-axis for different θ values from the diagram (array length = 8)
HPBW(1)= 7;   %HPBW_0 
HPBW(2)= 8;   %HPBW_30 
HPBW(3)= 14;  %HPBW_60 
HPBW(4)= 40;  %HPBW_90 

for i = 1:length(theta_values)
    Dz = 2*M*d_value/lambda; %Broadside on z-axis
    Dx(i)=((2*N*d_value)/lambda)*(HPBW_broad/HPBW(i)); %Almost broadside for θ=30,60,90
    D1(i)= pi*cos(theta_values(i))*Dz*Dx(i);
    
    fprintf("The directivity for θ= %d using the 1st method is : %.2f dBi \n", rad2deg(theta_values(i)), 10*log10(D1(i)));
end

%2nd way
Theta_z = (48.4*lambda)/(M*d_value); %Broadside on z-axis

for i = 1:length(theta_values)
    Theta_x(i) = HPBW(i);
    Theta_h(i) = Theta_x(i)/cos(theta_values(i));
    if theta_values(i) == pi/2
        Theta_h(i) = Theta_x(i);
    end
    Y_h(i) = Theta_z;

    D2(i) = 32400/(Theta_h(i)*Y_h(i));
    fprintf("The directivity for θ= %d using the 2nd method is : %.2f dBi \n", rad2deg(theta_values(i)), 10*log10(D2(i)));

end

