lambda = 1;
d = 0.05*lambda:0.05*lambda:3*lambda;
I1 = zeros(1,length(d));
I2 = zeros(1,length(d));
Zm = zeros(1,length(d));
Z_dipole = 73.1 + 1i*42.5;

for i = 1:length(d)
    write_nec(d(i),i);
end

 run_nec(i);

for i = 1:length(d)
    [I1(i),I2(i)] = get_currents(i);
     Zm(i) = - Z_dipole*(I2(i)/I1(i));
end

plot(d, Zm);
xlabel('Distance d/λ');
ylabel('Mutual Impedance')


function run_nec(j) 
    %Start 4NEC2 and load the NEC file
    necFilePath = ['C:\4nec2\models\keraies3\nec_file',num2str(j),'.nec'];
    fourNEC2Path = 'C:\4nec2\exe\4nec2.exe'; 

    command = ['"', fourNEC2Path, '" "', necFilePath, '"'];
    status = system(char(command));
end


function [c1,c2] = get_currents(j) %Read output file
    outputFilePath=['C:\4nec2\out\nec_file',num2str(j),'.out'];
    
    % Number of lines to skip
    headerLines = 154;
    
    % Read the data into a table, skipping the header lines
    dataTable = readtable(outputFilePath,'FileType', 'text', 'Delimiter', ' ', 'MultipleDelimsAsOne', true, 'HeaderLines', headerLines);
    
    % Calculate the currents
    c1 = 0;
    c2 = 0;
    for k=1:20
        c1 = c1 + (dataTable.REAL(k) + 1i*dataTable.IMAG_(k))*0.02502;
        c2 = c2 + (dataTable.REAL(k+20) + 1i*dataTable.IMAG_(k+20))*0.02502;
    end
end

function write_nec(new_dist,j) %Change distance of dipoles in file
    inputFileName = 'nec_file.nec';
    fileID = fopen(inputFileName, 'r');

    if fileID == -1
        error('Could not open file for reading');
    end
    
    % Read the existing content of the file
    allLines = textscan(fileID, '%s', 'Delimiter', '\n');
    allLines = allLines{1};
    
    fclose(fileID);
    
    % Replace fourth line with new content
    newContent = ['GW	2	20	', num2str(new_dist), '	0	0.25	', num2str(new_dist), '	0	-0.25	0.0005'];
    allLines{4} = newContent;
    
    % New file name
    outputFileName = ['nec_file',num2str(j),'.nec'];

    fileID = fopen(outputFileName, 'w');

    if fileID == -1
        error('Could not open file for writing');
    end
    
    % Write the modified content to the new file
    fprintf(fileID, '%s\r\n', allLines{:});

    fclose(fileID);
end