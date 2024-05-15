lambda = 1;
d = 0.05*lambda:0.05*lambda:2*lambda; %horizontal
b = 0.025*lambda:0.025*lambda:lambda; %vertical
I1 = zeros(length(d),length(b));
I2 = zeros(length(d),length(b));
Zm = zeros(length(d),length(b));
Z_dipole = 73.1 + 1i*42.5;

for i = 1:length(d)
    for j = 1:length(b)
    write_nec(d(i),b(j),i,j);
    end
end

run_nec(i,j);

 for i = 1:length(d)
    for j = 1:length(b)
    [I1(i,j),I2(i,j)] = get_currents(i,j);
    Zm(i,j) = Z_dipole*(I2(i,j)/I1(i,j));
    end
end

figure;
surf(d,b,real(Zm));
xlabel('Distance d/λ');
ylabel('Distance b/λ');
zlabel('Re(Zm)');
colorbar;

figure;
surf(d,b,imag(Zm));
xlabel('Distance d/λ');
ylabel('Distance b/λ');
zlabel('Im(Zm)');
colorbar;

function run_nec(i,j) 
    %Start 4NEC2 and load the NEC file
    necFilePath = ['C:\4nec2\models\keraies3\nec3_file',num2str(i), num2str(j),'.nec'];
    fourNEC2Path = 'C:\4nec2\exe\4nec2.exe'; 

    command = ['"', fourNEC2Path, '" "', necFilePath, '"'];
    status = system(char(command));
end


function [c1,c2] = get_currents(i,j) %Read output file
    outputFilePath=['C:\4nec2\out\nec3_file',num2str(i), num2str(j),'.out'];
    
    % Number of lines to skip
    headerLines = 124;
    
    % Read the data into a table, skipping the header lines
    dataTable = readtable(outputFilePath,'FileType', 'text', 'Delimiter', ' ', 'MultipleDelimsAsOne', true, 'HeaderLines', headerLines);
    
    % Calculate the currents
    c1 = 0;
    c2 = 0;
    for k=1:5
        c1 = c1 + (dataTable.REAL(k) + 1i*dataTable.IMAG_(k))*0.10007;
        c2 = c2 + (dataTable.REAL(k+5) + 1i*dataTable.IMAG_(k+5))*0.10007;
    end
end

function write_nec(new_dist1,new_dist2,i,j) %Change distance of dipoles in file
    inputFileName = 'nec3_file.nec';
    fileID = fopen(inputFileName, 'r');

    if fileID == -1
        error('Could not open file for reading');
    end
    
    % Read the existing content of the file
    allLines = textscan(fileID, '%s', 'Delimiter', '\n');
    allLines = allLines{1};
    
    fclose(fileID);
    
    % Replace fourth line with new content
    newContent = ['GW	2	5	',num2str(new_dist1),'	0	',num2str(0.25+new_dist2), '	',num2str(new_dist1),'	0	', num2str(0.75+new_dist2), '	0.0005'];
    allLines{4} = newContent;
    
    % New file name
    outputFileName = ['nec3_file',num2str(i), num2str(j),'.nec'];

    fileID = fopen(outputFileName, 'w');

    if fileID == -1
        error('Could not open file for writing');
    end
    
    % Write the modified content to the new file
    fprintf(fileID, '%s\r\n', allLines{:});

    fclose(fileID);
end