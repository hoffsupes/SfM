function visualise_S(S)     %% Visualization function (to show 3D version of the polyhedron)

if(size(S,2)~=3)
S = S';
end

scatter3(S(:,1),S(:,2),S(:,3),'bo');

plot3([S(1,1) S(2,1)],[S(1,2) S(2,2)],[S(1,3) S(2,3)],'r-'); hold on;  %% (Connecting 1>2>3>9>11>10>7>6>4>1)
plot3([S(2,1) S(3,1)],[S(2,2) S(3,2)],[S(2,3) S(3,3)],'r-'); hold on;
plot3([S(3,1) S(9,1)],[S(3,2) S(9,2)],[S(3,3) S(9,3)],'r-'); hold on;

plot3([S(11,1) S(9,1)],[S(11,2) S(9,2)],[S(11,3) S(9,3)],'r-'); hold on;
plot3([S(11,1) S(10,1)],[S(11,2) S(10,2)],[S(11,3) S(10,3)],'r-'); hold on;

plot3([S(10,1) S(7,1)],[S(10,2) S(7,2)],[S(10,3) S(7,3)],'r-'); hold on;
plot3([S(6,1) S(7,1)],[S(6,2) S(7,2)],[S(6,3) S(7,3)],'r-'); hold on;

plot3([S(6,1) S(4,1)],[S(6,2) S(4,2)],[S(6,3) S(4,3)],'r-'); hold on;

plot3([S(1,1) S(4,1)],[S(1,2) S(4,2)],[S(1,3) S(4,3)],'r-'); hold on;

end