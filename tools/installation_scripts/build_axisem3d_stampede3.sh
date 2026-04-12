# Install conda for dependencies. Using modules does not seem to work well.
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh;
chmod +x Miniconda3-latest-Linux-x86_64.sh;
./Miniconda3-latest-Linux-x86_64.sh -b -p $SCRATCH/miniconda;

# Add conda to PATH
cd miniconda/bin; export PATH=$PATH:$(pwd); 

# Clone AxiSEM3D
cd $SCRATCH; git clone https://github.com/AxiSEMunity/AxiSEM3D.git; cd AxiSEM3D; conda env create --name axisem3d -f environment.yml;

# eval is needed because conda init will not work in a shell script.
eval "$(conda shell.bash hook)"; conda activate axisem3d; 

# Run cmake
rm -rf build && cmake -B build \
  -Dcxx=mpicxx \
  -Dhdf5=$CONDA_PREFIX \
  -Dnetcdf=$CONDA_PREFIX \
  -Deigen=$CONDA_PREFIX \
  -Dboost=$CONDA_PREFIX \
  -Dfftw=$CONDA_PREFIX \
  -Dmetis=$CONDA_PREFIX

# Compile AxiSEM3D
cmake --build build;

# Add AxiSEM3D to PATH
cd build; export PATH=$PATH:$(pwd); 

# Test installation
axisem3d --help;
