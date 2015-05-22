C = tf([ 0.525 5.022 4.4 ], [ 0.005 1 0]);
G = tf([ 52.1 ] , [ 1.21 1 0 ]);
C.InputName = 'e';
C.OutputName = 'u';
G.InputName = 'u';
G.OutputName = 'y';
Sum = sumblk('e', 'r', 'y' , '+-');
controlled = connect(G, C, Sum, 'r', 'y');
Ts = 1/bandwidth(controlled);
Ts1 = Ts/15;
Ts2 = Ts/150;

% Names in the simulink model...
T2 = Ts1;
CT2_tust = c2d(C, Ts1, 'tustin');
G_tust = c2d(G, Ts1, 'tustin');