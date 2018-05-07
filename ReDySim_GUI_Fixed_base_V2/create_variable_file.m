function [] =  create_variable_file(n_, type_)
    n = n_;
    type = type_;
    % n: number of links
    % type: Open loop systems: 0, Closed loop systems: 1
   % type = 0;
    
    %Degree of Freedom of the system
    dof = n;    
    
    %default value for all link lengths
    default_length = 0.3;
    default_mass = 0.5;
    
    % Link lengths: al(i) represents the length of i-th link
    al(1:n,1) = default_length;
    
    % DH Parameters, alpha, a, b
    alp(1:n,1) = 0;
    a(1:n,1) = default_length;  a(1) = 0;
    b(1:n,1) = 0;
    
    % Parent Array
    bt(1:n, 1) = 0;
    
    % Initialization for the parent array
    for i = 1:n
        bt(i) = i-1;
    end
    
    %Actuated joints of open tree
    %1 for actuated joints and 0 otherwise
    aj(1:n, 1) = 1  ;
    % Initialized with 1 for all joints
    
    % Vector from origin to cg of links
    
    dx(1:n, 1) = default_length/2;
    dy(1:n, 1) = 0;
    dz(1:n, 1) = 0;
    
    m(1:n, 1) = default_mass;
    g=[0; -9.81; 0];
    
    %Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
    %which is rigid attach to the link
    
    Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1);
    
    Icxx(1:n,1)=(1/12)*default_mass*.01*.01;    %initialization with default values 
    Icyy(1:n,1)=(1/12)*default_mass*default_mass*default_mass;  
    Iczz(1:n,1)=(1/12)*default_mass*default_mass*default_mass;
    
    save('inputs.mat');
    
end