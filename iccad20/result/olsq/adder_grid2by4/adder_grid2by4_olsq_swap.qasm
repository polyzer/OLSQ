OPENQASM 2.0;
include "qelib1.inc";
qreg q[8];
creg c[4];
u2(0,3.141592653589793) q[1];
u3(3.141592653589793,0,3.141592653589793) q[2];
u1(0.7853981633974483) q[2];
cx q[5],q[1];
u1(-0.7853981633974483) q[1];
u1(0.7853981633974483) q[5];
cx q[5],q[1];
u3(3.141592653589793,0,3.141592653589793) q[6];
u1(0.7853981633974483) q[6];
cx q[2],q[6];
cx q[1],q[2];
cx q[6],q[5];
cx q[2],q[6];
u1(-0.7853981633974483) q[2];
cx q[5],q[1];
u1(0.7853981633974483) q[1];
u1(-0.7853981633974483) q[5];
cx q[5],q[1];
u1(1.5707963267948966) q[1];
u1(-0.7853981633974483) q[6];
cx q[2],q[6];
cx q[1],q[2];
u2(0,3.141592653589793) q[1];
measure q[2] -> c[0];
measure q[6] -> c[1];
measure q[5] -> c[2];
measure q[1] -> c[3];
