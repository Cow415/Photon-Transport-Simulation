"""Run the MCXCL simulation"""
import os
import numpy as np
import pmcxcl
import matplotlib.pyplot as plt

# Load phantom
vol = np.load("/Users/caoze/Documents/GitHub/Photon-Transport-Simulation/data/phantom/phantom.npy")

print("Volume shape:", vol.shape)
print("Tissue labels:", np.unique(vol))

# Configurations
cfg = {
    'nphoton': 1000000, 
    'vol':np.ones([60,60,60],dtype='uint8'), 
    'tstart':0, 'tend':5e-9, 'tstep':5e-9,
    'srcpos': [30,30,0], 'srcdir':[0,0,1], 
    'prop':[[0,0,1,1],[0.005,1,0.01,1.37]]}

# Run simulation
print("Running MCXCL simulation...")

res = pmcxcl.run(cfg)
print(res.keys())
print(res)

print("Simulation finished")

fluence = res["flux"]

# Result
print("Fluence shape:", fluence.shape)
# x, y, z voxels, time t steps => (x,y,z,t)

# Plot ts
# Pick time index, e.g., 0
t_idx = 0

# Pick a z-slice, e.g., mid-plane
z_idx = 20

# Slice: select a single time
slice2d = fluence[:, :, z_idx, t_idx]  # shape (4,5)

plt.imshow(slice2d, cmap='hot', interpolation='nearest')
plt.colorbar(label="Fluence")
plt.title(f"Fluence at z={z_idx}, t_idx={t_idx}")
plt.show()
