import numpy as np
from pyiso2mesh import vol2mesh
import os

# -------------------------
# Parameters
# -------------------------

INPUT_FILE = "../data/phantom.npy"
OUTPUT_DIR = "../output/mesh"
THICKNESS = 20   # number of layers

os.makedirs(OUTPUT_DIR, exist_ok=True)

# -------------------------
# Load phantom
# -------------------------

phantom2d = np.load(INPUT_FILE)

# Convert to 3D volume by extrusion
volume = np.repeat(phantom2d[:, :, None], THICKNESS, axis=2)

print("Volume shape:", volume.shape)

# -------------------------
# Generate mesh
# -------------------------

nodes, elements, faces, regions = vol2mesh(
    volume,
    maxvol=2.0,
    method="cg"
)

# -------------------------
# Save mesh
# -------------------------

np.save(os.path.join(OUTPUT_DIR, "nodes.npy"), nodes)
np.save(os.path.join(OUTPUT_DIR, "elements.npy"), elements)
np.save(os.path.join(OUTPUT_DIR, "regions.npy"), regions)

print("Mesh generated!")