%% run_redbird.m
clear; clc;

addpath(genpath('redbird'));
run cfg_shared;

load('tissue_mesh.mat');

%% -----------------------------
% Build Redbird mesh
%% -----------------------------
mesh = rbmesh;
mesh.node = tissue.node;
mesh.elem = tissue.elem;
mesh.face = tissue.face;

mua  = cfg.optical.tissue(1);
mus  = cfg.optical.tissue(2);
g    = cfg.optical.tissue(3);
n    = cfg.optical.tissue(4);

musp = mus * (1 - g);
D    = 1 / (3 * (mua + musp));

mesh.mua    = mua  * ones(size(mesh.elem,1),1);
mesh.kappa = D    * ones(size(mesh.elem,1),1);
mesh.n     = n;

%% -----------------------------
% Redbird configuration
%% -----------------------------
rb_cfg = struct;
rb_cfg.mesh = mesh;
rb_cfg.src  = cfg.src;
rb_cfg.det  = cfg.det;
rb_cfg.method = 'cw';
rb_cfg.isnormalize = 1;

%% -----------------------------
% Run Redbird
%% -----------------------------
result = rbfem(rb_cfg);

save('redbird_output.mat', 'result');

disp('Redbird simulation complete');
