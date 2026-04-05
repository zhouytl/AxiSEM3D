# Import the relevant classes
import sys
sys.path.append("../src")
from model import Model 
from ellipsoid import Ellipsoid 
from injector import Injector

# Create a model object with the dimensions of the domain. 
# Note that in this example where we are injecting just one blob, we could make the domain dimensions simply just a box that
# fits around our sphere of interest - this will substantially reduce the size of the overall .nc file and is therefore 
# useful (and sometimes imperetive) for single shapes in large domains. Here however, the domain is small so it doesnt really
# matter. I discuss this idea a bit more in Example 2. 
m = Model(type = "cartesian",
          x_lim = [-10000, 20000], 
          y_lim = [-6000, 6000], 
          z_lim = [0, 17000], 
          elements_per_wavelength = 3, 
          dominant_freq = 3,
          min_velocity = 900, 
          )


# Create an ellipse: 
ellpsoid = Ellipsoid(model = m, 
                    vp  = -0.2,
                    vs  = -1,
                    rho = -0.2,
                    dim = [3000, 3000, 3000, 0, 0, 1])


# Create an injector object for the model 
i = Injector(m)

# Add an object at the centre of the domain using injector 
i.addObj(ellpsoid, location = [13000, 0, 8500])

# Write to netcdf file
m.writeNetCDF("example_sphere_cartesian.nc", paraview=True)