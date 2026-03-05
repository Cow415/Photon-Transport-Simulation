%% build_tissue_mesh.m
% Version-safe iso2mesh tissue volume generator

clear; clc;
addpath(genpath('iso2mesh'));

%% -----------------------------
% 1. Define tissue box (mm)
%% -----------------------------
p0 = [0 0 0];     % one corner
p1 = [40 40 10];  % opposite corner

%% -----------------------------
% 2. Mesh controls
%% -----------------------------
maxvol   = 1.0;   % max tetrahedral volume (mm^3)
nodesize = 1;     % uniform sizing near vertices

%% -----------------------------
% 3. Generate tetrahedral mesh
%% -----------------------------
[node, face, elem] = meshabox(p0, p1, maxvol, nodesize);

fprintf('Mesh generated:\n');
fprintf('  Nodes: %d\n', size(node,1));
fprintf('  Elements: %d\n', size(elem,1));

%% -----------------------------
% 4. Optical properties
%% -----------------------------
mua  = 0.01;   % 1/mm
mus  = 1.0;    % 1/mm
g    = 0.9;
n    = 1.37;

musp = mus * (1 - g);
D    = 1 / (3 * (mua + musp));

optical.mua    = mua  * ones(size(elem,1),1);
optical.musp   = musp * ones(size(elem,1),1);
optical.kappa  = D    * ones(size(elem,1),1);
optical.n      = n;

%% -----------------------------
% 5. Package and save
%% -----------------------------
tissue.node    = node;
tissue.elem    = elem;
tissue.face    = face;
tissue.optical = optical;
tissue.bbox    = [p0; p1];
tissue.units   = 'mm';

save('tissue_mesh.mat', 'tissue', '-v7.3');

fprintf('Saved tissue_mesh.mat\n');

%% -----------------------------
% 6. Visualize
%% -----------------------------
figure;
plotmesh(node, elem);
axis equal;
title('Tissue Tetrahedral Mesh');
xlabel('x (mm)'); ylabel('y (mm)'); zlabel('z (mm)');
