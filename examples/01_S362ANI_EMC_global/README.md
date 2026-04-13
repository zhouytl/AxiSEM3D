# 01 README

Add text from readme.txt here.# Example 01 — Global 3D (S362ANI)
# ==================================
# A global simulation using the 3D mantle model S362ANI from IRIS EMC,
# superimposed on a 1D PREM background.
# Source: 2011 Virginia earthquake (Mw 5.8)
# Stations: GSN global network + USArray transportable array
# Period: 50 s

# The mesh and 3D model have already been prepared and are provided in input/.
# To regenerate the mesh:
#   python -m salvus_mesh_lite.interface AxiSEM --basic.model prem_ani --basic.period 50 --output_file input/global_mesh__prem_ani__50s.e
# The 3D model S362ANI_percent.nc was downloaded from IRIS EMC.

# To run the simulation (~35 minutes on 4 cores):
#   cp path/to/axisem3d .
#   mpirun -np 4 ./axisem3d input/

# Output will be written to output/ inside this folder.

# Use post_processing.ipynb to visualize seismograms and USArray animations.
# To compare 1D and 3D results, first run example 00_global_1D and point
# the notebook to both output directories (see instructions in the notebook).
