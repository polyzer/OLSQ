OPENQASM 2.0;
include "qelib1.inc";
qreg node[10];
creg c[5];
u1(0.7853981633974483) node[2];
u1(0.7853981633974483) node[3];
cx node[3],node[2];
cx node[5],node[4];
u2(0,3.141592653589793) node[4];
u1(0.7853981633974483) node[4];
u1(0.7853981633974483) node[5];
u1(0.7853981633974483) node[9];
cx node[5],node[9];
cx node[4],node[5];
u1(-0.7853981633974483) node[5];
cx node[4],node[5];
cx node[5],node[9];
cx node[4],node[5];
u1(0.7853981633974483) node[4];
cx node[5],node[9];
cx node[9],node[5];
u1(-0.7853981633974483) node[5];
cx node[4],node[5];
cx node[4],node[5];
u1(-0.7853981633974483) node[9];
cx node[5],node[9];
cx node[4],node[5];
u2(0,3.141592653589793) node[4];
u2(0,3.141592653589793) node[4];
u1(0.7853981633974483) node[4];
cx node[5],node[9];
cx node[5],node[9];
u2(0,3.141592653589793) node[5];
u1(0.7853981633974483) node[5];
cx node[5],node[4];
cx node[4],node[5];
cx node[5],node[4];
cx node[4],node[3];
u1(-0.7853981633974483) node[3];
cx node[2],node[3];
cx node[3],node[2];
cx node[2],node[3];
cx node[3],node[4];
cx node[3],node[2];
u1(-0.7853981633974483) node[2];
u1(-0.7853981633974483) node[3];
u1(0.7853981633974483) node[4];
cx node[4],node[3];
cx node[3],node[4];
cx node[4],node[3];
cx node[3],node[2];
cx node[4],node[3];
u2(0,3.141592653589793) node[3];
u1(0.7853981633974483) node[3];
cx node[4],node[3];
cx node[3],node[4];
cx node[4],node[3];
cx node[2],node[3];
u1(0.7853981633974483) node[2];
u1(0.7853981633974483) node[3];
cx node[2],node[3];
u1(0.7853981633974483) node[9];
cx node[9],node[5];
cx node[5],node[4];
cx node[9],node[5];
cx node[5],node[4];
cx node[5],node[4];
u1(-0.7853981633974483) node[4];
cx node[9],node[5];
u1(0.7853981633974483) node[5];
cx node[5],node[4];
cx node[9],node[5];
cx node[5],node[4];
u1(-0.7853981633974483) node[4];
cx node[9],node[5];
cx node[5],node[4];
u1(-0.7853981633974483) node[9];
cx node[9],node[5];
u2(0,3.141592653589793) node[5];
cx node[5],node[9];
cx node[9],node[5];
cx node[5],node[9];
cx node[4],node[5];
u2(0,3.141592653589793) node[4];
u1(0.7853981633974483) node[4];
cx node[4],node[3];
cx node[3],node[4];
cx node[4],node[3];
cx node[3],node[2];
u1(-0.7853981633974483) node[2];
cx node[4],node[3];
u1(0.7853981633974483) node[3];
cx node[2],node[3];
cx node[3],node[2];
cx node[2],node[3];
cx node[4],node[3];
u1(-0.7853981633974483) node[3];
cx node[2],node[3];
cx node[2],node[3];
cx node[3],node[2];
cx node[2],node[3];
u1(-0.7853981633974483) node[4];
cx node[4],node[3];
u2(0,3.141592653589793) node[3];
cx node[4],node[3];
cx node[3],node[4];
cx node[4],node[3];
cx node[2],node[3];
measure node[5] -> c[1];
cx node[5],node[4];
cx node[4],node[5];
cx node[5],node[4];
cx node[9],node[5];
measure node[9] -> c[0];
measure node[2] -> c[2];
measure node[3] -> c[3];
measure node[5] -> c[4];
