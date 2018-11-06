function [icp_T,x,fval] = perform_fmincon(input_part_ptcloud_icp,scan_traj,tx,ty,tz,q0,q1,q2,q3,type)

global x0

x = [tx ty tz q0 q1 q2 q3];
% lb = [-20 -20 -20 -1 -1 -1 -1];
% ub = [20 20 20 1 1 1 1];

lb = [-50 -50 -50 -1 -1 -1 -1];
ub = [50 50 50 1 1 1 1];

KDtree = KDTreeSearcher(input_part_ptcloud_icp);

switch type
    case 'mean_d'
        fun = @(x)error_function_mean_d(x,input_part_ptcloud_icp,scan_traj,KDtree);
    case 'max_d'
        fun = @(x)error_function_max_d(x,input_part_ptcloud_icp,scan_traj,KDtree);
    case 'weighted_max_mean_d'
        fun = @(x)error_function_weighted_max_mean_d(x,input_part_ptcloud_icp,scan_traj,KDtree);      
    case 'mean_plane_d'
        fun = @(x)error_function_mean_plane_d(x,input_part_ptcloud_icp,scan_traj,KDtree);
    case 'weighted_max_mean_plane_d'
        fun = @(x)error_function_weighted_max_mean_plane_d(x,input_part_ptcloud_icp,scan_traj,KDtree);
end

nonlcon = @nonlin_constaints;
options = optimoptions(@fmincon);
options.Display = 'none';
% options.MaxIterations = 200;
% options.UseParallel = true;
% options.StepTolerance = 1e-10;
% options.Algorithm = 'interior-point';
% options.DiffMaxChange = 1e-8;
options.FunctionTolerance = 1e-5;

[x,fval,~,output] = fmincon(fun,x0,[],[],[],[],lb,ub,nonlcon,options);

icp_r = quat2rotm([x(4) x(5) x(6) x(7)]);
icp_t = [x(1);x(2);x(3)];
icp_T = [icp_r,icp_t;0 0 0 1];

    function [c,ceq] = nonlin_constaints(x)
        c= [];
        ceq = (x(4)^2)+(x(5)^2)+(x(6)^2)+(x(7)^2)-1;
    end
end