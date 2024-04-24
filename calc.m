%% Dynamics
syms s c u Lm q1 L2 q2
% Pretpostavljamo da su s i c funkcije varijable u
s = sin(u);
c = cos(u);

% Brzina diferencijala mase vodilice
% v = -s*q1*(u + L2)*i + c*q1*(u + L2)*j;S

v = sqrt((-s*q1*(Lm))^2+ (c*q1*(Lm))^2);


v_squared = v^2;

pretty(simplify(v_squared))


%% Drugi joint 


v = sqrt((-s*q1*(L2 + q2))^2+ (c*q1*(L2 + q2))^2);

v_squared = v^2;

pretty(simplify(v_squared))

%% IK
syms q1 L1 L2 L3 L4 q2 q3 real
syms c1 s1
syms nx ny nz ox oy oz ax ay az px py pz

c1 = cos ( q1 ) ;
s1 = sin ( q1 ) ;



A01 = [ c1 -s1 0 0;
        s1 c1 0 0;
        0 0 1 0;
        0 0 0 1];
        
A12 = [ 1 0 0 L2 + q2 ;
        0 1 0 0;
        0 0 1 L1 ;
        0 0 0 1];

A23 = [ 1 0 0 0 ;
        0 1 0 -L4;
        0 0 1 -(L3 + q3) ;
        0 0 0 1];

T02 = A01 * A12 ;

T03 = A01 * A12 * A23 ;

pretty(simplify(inv(A01)))
disp('__________________________')
pretty(simplify(A12 * A23))

T =[nx ox ax px;
    ny oy ay py;
    nz oz az pz;
    0  0  0  1];

disp('__________________________')
pretty(simplify(inv(A01) * T))

%% solve for q1 and q2

syms q1 q2
px = sym('px'); 
py = sym('py'); 
L2 = sym('L2'); 
L4 = sym('L4'); 

% Define the equations
eqn1 = px*cos(q1) + py*sin(q1) == L2 + q2;
eqn2 = py*cos(q1) - px*sin(q1) == -L4;

% Solve the equations for q1 and q2
sol = solve([eqn1, eqn2], [q1, q2], 'ReturnConditions', true);

% Display the solutions
q1_sol = sol.q1;
q2_sol = sol.q2;


disp('__________________________')
pretty(simplify(q1_sol))
pretty(simplify(q2_sol))

%% Extended with polar coordinates
syms r alpha 

syms q1 q2
px = sym('px'); 
py = sym('py'); 
L2 = sym('L2'); 
L4 = sym('L4'); 

% Define the equations
eqn1 = px*cos(q1) + py*sin(q1) == L2 + q2;
eqn2 = py*cos(q1) - px*sin(q1) == -L4;
eqn3 = px == r*cos(alpha);
eqn4 = py == r*sin(alpha);
eqn5 = alpha == atan(px/py);


% Solve the equations for q1 and q2
sol = solve([eqn1, eqn2, eqn3, eqn4, eqn5], [q1, q2], 'ReturnConditions', true);

% Display the solutions
q1_sol = sol.q1;
q2_sol = sol.q2;
