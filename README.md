[![iccad](https://img.shields.io/badge/Published-ICCAD'20-brightgreen.svg?style=for-the-badge)](https://ieeexplore.ieee.org/document/9256696)
[![arXiv](https://img.shields.io/badge/arXiv-2007.15671-brightgreen.svg?style=for-the-badge)](https://arxiv.org/abs/2007.15671)
[![Unitary Fund](https://img.shields.io/badge/Supported%20By-UNITARY%20FUND-brightgreen.svg?style=for-the-badge)](http://unitary.fund)

# OLSQ: Optimal Layout Synthesis for Quantum Computing

## Installation

```
pip install -i https://test.pypi.org/simple/ --no-deps olsq==0.1.dev9
```
Please make sure that you have the `networkx` version `>=2.5` and `z3-solver` version `>=4.8.9.0` in your Python environment.

## Brief Tutorial

The code blocks in this section consist an example usage of OLSQ.
We also add an interface to [Cirq](https://github.com/quantumlib/Cirq), check out the next section as well.

### Initialization

```
from olsq import OLSQ


lsqc_solver = OLSQ("depth", "normal")
```

There are two argument in the constructor of OLSQ: `objective_name` and `mode`.
- `objective_name` can be `depth`, `swap`, or `fidelity`.
- `mode` can be `normal`, or `transition`.
The latter stands for TB-OLSQ in the paper.

### Setting the Input Program

```
circuit = "OPENQASM 2.0;\n include \"qelib1.inc\";\n qreg q[3];\n h q[2];\n cx q[1], q[2];\n tdg q[2];\n " \
          "cx q[0], q[2];\n t q[2];\n cx q[1], q[2];\n tdg q[2];\n cx q[0], q[2];\n t q[1];\n t q[2];\n " \
          "cx q[0], q[1];\n h q[2];\n t q[0];\n tdg q[1];\n cx q[0], q[1];\n"
lsqc_solver.setprogram(circuit)
```

The example circuit above is a Toffoli gate
```
"""
                                                       ┌───┐      
q_0: ───────────────────■─────────────────────■────■───┤ T ├───■──
                        │             ┌───┐   │  ┌─┴─┐┌┴───┴┐┌─┴─┐
q_1: ───────■───────────┼─────────■───┤ T ├───┼──┤ X ├┤ TDG ├┤ X ├
     ┌───┐┌─┴─┐┌─────┐┌─┴─┐┌───┐┌─┴─┐┌┴───┴┐┌─┴─┐├───┤└┬───┬┘└───┘
q_2: ┤ H ├┤ X ├┤ TDG ├┤ X ├┤ T ├┤ X ├┤ TDG ├┤ X ├┤ T ├─┤ H ├──────
     └───┘└───┘└─────┘└───┘└───┘└───┘└─────┘└───┘└───┘ └───┘      
"""
```

### Setting the input device

```
from olsq.device import qcdevice


lsqc_solver.setdevice(qcdevice("dev", 5, [(0, 1), (1, 2), (1, 3), (3, 4)], 3))
```

We only use a few properties of the QC device, so we use a minimalist class `qcdevice` to store these values.
To construct a `qcdevice`, The below arguments are required.
(The last three are only for fidelity optimization.)
1. `name`
2. `nqubits`: the number of physical qubits
3. `connection`: a list of physical qubit pairs corresponding to edges in the coupling graph
4. `swap_duration`: number of cycles a SWAP gate takes.
   Usually it is either one, or three meaning three CX gates.
5. `fmeas`: a list of measurement fidelity
6. `fsingle`: a list of single-qubit gate fidelity
7. `ftwo`: a list of two-qubit gate fidelity, indices aligned with `connection`

### Solving and Output

```
result = lsqc_solver.solve()
print(result)
```

The `solve` method can also takes two optional arguemnts
- `output_mode` can be `"IR"` or `"QASM"`. The former means our own IR.

- `output_file_name`

The result of the above example is as below.
```
"""
                                                 ┌───┐     ┌───┐┌───┐ ┌───┐      ┌─┐      
q_0: ───────────────────■─────────────────────■──┤ X ├──■──┤ X ├┤ T ├─┤ H ├──────┤M├──────
     ┌───┐┌───┐┌─────┐┌─┴─┐┌───┐┌───┐┌─────┐┌─┴─┐└─┬─┘┌─┴─┐└─┬─┘└───┘ ├───┤      └╥┘┌─┐   
q_1: ┤ H ├┤ X ├┤ TDG ├┤ X ├┤ T ├┤ X ├┤ TDG ├┤ X ├──■──┤ X ├──■────■───┤ T ├───■───╫─┤M├───
     └───┘└─┬─┘└─────┘└───┘└───┘└─┬─┘└┬───┬┘└───┘     └───┘     ┌─┴─┐┌┴───┴┐┌─┴─┐ ║ └╥┘┌─┐
q_2: ───────■─────────────────────■───┤ T ├─────────────────────┤ X ├┤ TDG ├┤ X ├─╫──╫─┤M├
                                      └───┘                     └───┘└─────┘└───┘ ║  ║ └╥┘
q_3: ─────────────────────────────────────────────────────────────────────────────╫──╫──╫─
                                                                                  ║  ║  ║
q_4: ─────────────────────────────────────────────────────────────────────────────╫──╫──╫─
                                                                                  ║  ║  ║
c: 5/═════════════════════════════════════════════════════════════════════════════╩══╩══╩═
                                                                                  2  0  1
"""
```

## Cirq Interface

Given `circuit` and `device_graph` as in [this line](https://github.com/quantumlib/Cirq/blob/8f9d8597364b8bd0d29833cbbd014ebf1c62f3db/cirq/contrib/quantum_volume/quantum_volume.py#L215).
```
from olsq.olsq_cirq import OLSQ_cirq


# use OLSQ to route the circuit
lsqc_solver = OLSQ_cirq("depth", "normal")

# simply pass the circuit
lsqc_solver.setprogram(circuit)

# construct a device from a device graph
lsqc_solver.setdevicegraph(device_graph)

# mapping is the final mapping from physical to logical
routed_circuit, mapping = lsqc_solver.solve()
```

## BibTeX Citation
```
@InProceedings{iccad20-tan-cong-optimal-layout-synthesis,
  author          = {Tan, Bochen and Cong, Jason},
  booktitle       = {Proceedings of the 39th International Conference on Computer-Aided Design},
  title           = {Optimal Layout Synthesis for Quantum Computing},
  year            = {2020},
  address         = {New York, NY, USA},
  publisher       = {Association for Computing Machinery},
  series          = {ICCAD '20},
  archiveprefix   = {arXiv},
  eprint          = {2007.15671},
  primaryclass    = {quant-ph},
  articleno       = {137},
  doi             = {10.1145/3400302.3415620},
  isbn            = {9781450380263},
  keywords        = {quantum computing, scheduling, allocation, mapping, placement, layout synthesis},
  location        = {Virtual Event, USA},
  numpages        = {9},
  url             = {https://doi.org/10.1145/3400302.3415620},
}
```
