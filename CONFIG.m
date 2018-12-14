%part ptcloud - blue
%start ptcloud - red
%final ptcloud - green
%%%%%%%%%%%%%%%%%%%%% sampling data %%%%%%%%%%%%%%%%%%%%%%%%
sampling_count = 100;
% sampling_pts = round(size(scan_ptcloud,1)/50);
sampling_pts = 5;
upper_bound_fact = 5;
lower_bound_fact = 0.1;
%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
view_data = true;
%%%%%%%%

num = 30;
% model_ptcloud_data = 'HeliBlade_ptcloud.csv';
% scan_ptcloud_data = 'HeliBladeSegmented0.csv';
model_ptcloud = dlmread(model_ptcloud_data);
% model_ptcloud  = model_ptcloud.*1000;
scan_ptcloud = dlmread(scan_ptcloud_data);
m0 = [0,0,0];
s0 = [0,0,0];
nx = [1,0,0];ny = [0,1,0];nz = [0,0,1];

if view_data
    scatter3d(model_ptcloud,'.b');
    hold on;
    scatter3(m0(1),m0(2),m0(3),100,'d','filled','b');
    hold on;
    quiver3(m0(1),m0(2),m0(3),1,0,0,100,'r');hold on;quiver3(m0(1),m0(2),m0(3),0,1,0,100,'g');hold on;quiver3(m0(1),m0(2),m0(3),0,0,1,100,'b');
    
    hold on;
    scatter3d(scan_ptcloud,'.r');
    hold on;
    scatter3(s0(1),s0(2),s0(3),100,'d','filled','r');
    hold on;
    quiver3(s0(1),s0(2),s0(3),nx(1),nx(2),nx(3),100,'r');hold on;quiver3(s0(1),s0(2),s0(3),ny(1),ny(2),ny(3),100,'g');hold on;quiver3(s0(1),s0(2),s0(3),nz(1),nz(2),nz(3),100,'b');
end