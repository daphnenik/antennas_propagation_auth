startPoint = [0, -0.0125, 0];

lengthLine = 0.25;

angleWithY = deg2rad(30);
angleBetweenLines = deg2rad(60);


figure;
hold on;

endingPoints = zeros(6, 3);

for i = 1:6
    % Εnding point for each line
    x2 = startPoint(1) + lengthLine * sin(angleWithY) * cos((i-1) * angleBetweenLines);
    y2 = startPoint(2) + lengthLine * cos(angleWithY);
    z2 = startPoint(3) + lengthLine * sin(angleWithY) * sin((i-1) * angleBetweenLines);

    endingPoints(i, :) = [x2, y2, z2];

    plot3([startPoint(1), x2], [startPoint(2), y2], [startPoint(3), z2], '-o');
end

grid on;
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('Lines in 3D Space');

disp('Ending points of each line:');
disp(endingPoints);

hold off;
