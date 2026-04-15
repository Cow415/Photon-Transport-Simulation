# Photon Distribution Simulation For OBM Sample Lumination

This repository contain all work done to simulate photon distribution in a given sample using Monte Carlo Method, and aim to illustrate photon activity within the sample during imaging cross-sectionally.

Workflow are done differently, all image processing in Python, and simulation is in MatLab

Composite storage for piping sample tiff into MCX. 

Includes Scripts For:
    1. Volume extraction(Python).
    2. Geometry processing(Python).
    3. Meshing(Matab).
    4. Simulation(MatLab).

TIFF exports of real samples from the QPI provides RI by pixels throughout the layers, this repository walks through a rudimentary workflow that takes a desired crossesctional slices of 3D TIFF into matrix, pads the matrix, and then injected with a desired light source model, to simulate and display the photon distribution using the flux, and demonstrate how it varies with changes to medium geometry and properties.

Media involved includes, air, red blood cell, gel, and stained pericytes; and properties involved are absorption coefficient, scattering coefficient, anistropy factor and refractive index.