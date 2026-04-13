# Example 01 Global 3D Simulation (S362ANI)

This is an example of a global simulation using the 3D mantle model S362ANI, superimposed on a 1D PREM background. The 3D model S362ANI_percent.nc was downloaded from IRIS EMC.

Here is the basic information about this simulation.
- Source: 2011 Virginia earthquake (Mw 5.8)
- Stations: GSN global network + USArray transportable array
- Period: 50 s

The mesh and 3D model have already been prepared and are provided in input/.
To regenerate the mesh, run:
```
python -m salvus_mesh_lite.interface AxiSEM --basic.model prem_ani --basic.period 50 --output_file input/global_mesh__prem_ani__50s.e
```

To run the simulation, input the following comments:
```
cp path/to/axisem3d . `
mpirun -np 4 ./axisem3d input/
```

This simulation should take around 35 minutes on 4 cores, and the output will be written to output/ inside this folder.

Use **post_processing.ipynb** to visualize seismograms and USArray animations.
To compare 1D and 3D results, first run **/example 00_global_1D** and point the notebook to both output directories (see instructions in the notebook).
