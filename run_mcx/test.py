import numpy as np
from iso2mesh import vol2mesh

vol = np.zeros((30,30,30))
vol[10:20,10:20,10:20] = 1

node, elem, face, region = vol2mesh(vol)

print(node.shape)
print(elem.shape)