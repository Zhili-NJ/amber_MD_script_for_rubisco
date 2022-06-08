 # MD simulation: reproducibility, determinism, chaos theory of protein dynamics, ergodicity
 ## Determinism
 The determinism in computer science (rounding errors): Nonassociativity of floating point calculation in the parallel calculation, especially in the GPU calculations: the atoms calculation distributed to the Cuda unit finishes randomly and the nonassociativity will cause the stochasticity as the divergence progress with integrations. (the reason to use SPFP) In comparison, CPU calculations for a given set of input parameters on identical hardware are perfectly reproducible. 
 ## Thermostats
 The thermostats (Berendsen, Anderson and Langevin thermostats) will affect the deterministic property of the simulation. 
 ## Inital parameters
 The prepare and parameterization of mutation of active site, replacement of ligand etc... are the introductions of the main deviation (error) from the original crystal structure or potential better models. This fits the chaos theory (the butterfly flapping metaphor). And the content of deviation partly reflects the chaotic character of a protein itself. 
 ## Ergodicity
However, even above we say the irreproducibility, the stochasticity of the MD simulation of the proteins, the protein structure is refined by the force field and the temperature is normally set to 300 K, the potential energy will not surpass its upper limit, thus the ergodicity of trajectory is usually utilised for analysis, as the ergodicity explained within the enough timescale the protein conformations in the space will be traversed. In this case, the statistical analysis on the multiple repeats will be more meaningful. 
 ## Repeats
Moreover, a common strategy doing MD repeats is to set the random velocity of the atoms of the equilibrated structures to produce multiple trajectories. 
 ## Acceleration tech
Furthermore, as long as the force field is trustable, the acceleration techniques like GaMD, accelerate the traverse of the conformation space and lift the trapped conformations caused the deviation and random seed velocity... 
