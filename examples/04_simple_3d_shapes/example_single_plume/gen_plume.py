import sys 
sys.path.append("../src")

import numpy as np
import scipy.ndimage as sci
from model import Model
from ellipsoid import Ellipsoid
from cylinder import *
from injector import *
import netCDF4 as nc

# We dont need to make a model that spans the whole domain, just the part we are interested in injecting a plume in: 
radius = 4000000
perturb = -0.1
lat_lim = [-20, 20]
long_lim = [-20, 20]
depth_lim = [0, radius]

# Set locations for shapes:
ell_loc = [0,0, 1200000]
cyl_loc = [0,0, 2000000]

# Create our global model: 
glob_m = Model("spherical", lat_lim, long_lim, depth_lim, elements_per_wavelength=1, dominant_freq=1, min_velocity=10000, oversaturation=1, a=radius)

# Create cylinder: 
cylinder = Cylinder(model=glob_m, vp=perturb, vs=perturb, rho=perturb, dim=[2000000, 100000, 0, 0, 1], loc=cyl_loc, major_axis='Z')

# Create ellipse: 
ellipse = Ellipsoid(model=glob_m, vp=perturb, vs=perturb, rho=perturb, dim=[500000, 500000, 500000, np.pi/2, 0, 1], loc=ell_loc)

# Create injector object and inject
i = Injector(glob_m)
i.addObj(cylinder, location=cyl_loc, overwrite=True)
i.addObj(ellipse, location=ell_loc, overwrite=True)

# Gaussian filter to make the plume boundaries a bit less harsh 
sigma = 1
glob_m.bm_rho =  sci.gaussian_filter(input=glob_m.bm_rho, sigma=sigma)
glob_m.bm_vp =  sci.gaussian_filter(input=glob_m.bm_vp, sigma=sigma)
glob_m.bm_vs =  sci.gaussian_filter(input=glob_m.bm_vs, sigma=sigma)

# Write to NetCDF file 
out_path = f"plume_{sigma}"
glob_m.writeNetCDF(f"{out_path}.nc")
glob_m.writeNetCDF(f"{out_path}_visual.nc", paraview=True)


