phi=0;
theta0=[0, pi/6, pi/3, pi/2];
theta=linspace(0,pi,300);
lambda = 1;
k = 2*pi/lambda;

h=lambda/4;
figure
for j=1:length(theta0)
    Az=zeros(1,length(theta));
    Ax=zeros(1,length(theta));
    for i=1:length(theta)
        Ax(i)=1i*sin(theta0(j))*(exp(-1i*k*h*cos(phi)*sin(theta(i)))+exp(1i*k*h*cos(phi)*sin(theta(i))));
        Az(i)=cos(theta0(j))*(exp(-1i*k*h*cos(phi)*sin(theta(i)))-exp(1i*k*h*cos(phi)*sin(theta(i))));
    end
    subplot(2,2,j);
    polarplot(theta,abs(Az+Ax))
    title(['Για h = λ/4 και γωνία θ0 = ',num2str(rad2deg(theta0(j))), ' μοίρες'])
    ax=gca;
    ax.ThetaZeroLocation='top';
    ax.ThetaDir = 'clockwise';

end

h=lambda/2;
figure
for j=1:length(theta0)
    Az=zeros(1,length(theta));
    Ax=zeros(1,length(theta));
    for i=1:length(theta)
        Ax(i)=1i*sin(theta0(j))*(exp(-1i*k*h*cos(phi)*sin(theta(i)))+exp(1i*k*h*cos(phi)*sin(theta(i))));
        Az(i)=cos(theta0(j))*(exp(-1i*k*h*cos(phi)*sin(theta(i)))-exp(1i*k*h*cos(phi)*sin(theta(i))));
    end
    subplot(2,2,j);
    polarplot(theta,abs(Az+Ax))
    title(['Για h = λ/2 και γωνία θ0 = ',num2str(rad2deg(theta0(j))), ' μοίρες'])
    ax=gca;
    ax.ThetaZeroLocation='top';
    ax.ThetaDir = 'clockwise';

end

