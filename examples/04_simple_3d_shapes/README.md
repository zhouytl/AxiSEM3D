# 04 Simple 3D shapes 

This example contains a few cases of superimposing 3D heterogeneity on the background domain. For a step-by-step tutorial, see the Jupyter notebook ```Example_4_README.ipynb```. Below, a brief description of each case, and how to run, is given: 

## (4.1) ```example_input_cartesian```
This example demonstrates how to produce, and inject, a 3D sphere into the background model. To run the example you will need to 
 
 1. Generate the background mesh using ```gen_mesh.sh```. This requires ```salvus_mesher_lite``` as detailed [here](https://axisem3d.readthedocs.io/en/latest/installation/mesher.html).  
 2. Create the 3D sphere by running  
    ```
    $ python3 gen_blob.py
    ```
3. Copy the files from this directory to ```AxiSEM3D/build/input```. 
4. Run the AxiSEM executable. 

## (4.2) ```example_single_plume``` 
This example adds a plume-like structure to a global model. It uses a homogeneous global 1D structure (though you could replace it with PREM when you generate the mesh). Similar, the steps are: 
1. Generate the background mesh using ```gen_mesh.sh```.
 2. Create the 3D plume running  
    ```
    $ python3 gen_plume.py
    ```
3. Copy the files from this directory to ```AxiSEM3D/build/input```. 
4. Run the AxiSEM executable. 
5. Create a movie that can be viewed in Paraview using ```gen_movie.py```. 

## (4.3) ```example_release_paper```
This case reproduces the example from the AxiSEM release paper. To generate the 3D model, run 
```
$ python3 generate_3D_model.py
``` 
After this, copy the input folder to ```AxiSEM3D/build/``` and run. This may take around 5 hours on a cluster using 1000 cores. Following completion, copy the ```output/stations``` directory to this location and run 
```
$ reproduce_paper_figure.py
``` 