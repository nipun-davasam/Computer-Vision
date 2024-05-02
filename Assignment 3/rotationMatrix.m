function M=rotationMatrix( x, y, z )
Rx = [1, 0, 0; 0, cosd(x), -sind(x); 0, sind(x), cosd(x)];
Ry = [cosd(y), 0, sind(y); 0, 1, 0; -sind(y), 0, cosd(y)];
Rz = [cosd(z), -sind(z), 0; sind(z), cosd(z), 0; 0, 0, 1];

M = Rx * Ry * Rz;
end