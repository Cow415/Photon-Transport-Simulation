import numpy as np
import pmcx
import os

# -------------------------
# Paths
# -------------------------

MESH_DIR = "../output/mesh"
OUTPUT_DIR = "../output/mcx"

os.makedirs(OUTPUT_DIR, exist_ok=True)

# -------------------------
# Load mesh
# -------------------------

nodes = np.load(f"{MESH_DIR}/nodes.npy")
elements = np.load(f"{MESH_DIR}/elements.npy")
regions = np.load(f"{MESH_DIR}/regions.npy")

# -------------------------
# Optical properties
# -------------------------

# [mua, mus, g, n]

optical_props = [
    [0.0, 0.0, 1.0, 1.0],   # background
    [0.01, 10.0, 0.9, 1.37], # tissue 1
    [0.02, 15.0, 0.9, 1.4]   # tissue 2
]

# -------------------------
# MCX configuration
# -------------------------

cfg = {}

cfg["nphoton"] = 1e7
cfg["tstart"] = 0
cfg["tend"] = 5e-9
cfg["tstep"] = 5e-10

cfg["srcpos"] = [20,20,0]
cfg["srcdir"] = [0,0,1]

cfg["prop"] = optical_props

cfg["mesh"] = {
    "node": nodes,
    "elem": elements,
    "region": regions
}

# -------------------------
# Run MCX
# -------------------------

result = pmcx.run(cfg)

np.save(f"{OUTPUT_DIR}/fluence.npy", result["fluence"])

print("Simulation complete!")