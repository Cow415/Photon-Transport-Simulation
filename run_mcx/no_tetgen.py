import numpy as np
import pmcx

# 2D phantom
phantom2d = np.array([
[0,0,1,1],
[0,1,1,2],
[1,1,2,2]
], dtype=np.uint8)

# extrude to 3D
vol = np.repeat(phantom2d[:, :, None], 40, axis=2)

cfg = {
    "nphoton": 1e6,
    "vol": vol,
    "prop": [
        [0,0,1,1],
        [0.01,10,0.9,1.37],
        [0.02,15,0.9,1.4]
    ],
    "srcpos":[2,2,0],
    "srcdir":[0,0,1],
    # "gpuid": -1
    "autopilot": 0
}

res = pmcx.run(cfg)

print(res["fluence"].shape)