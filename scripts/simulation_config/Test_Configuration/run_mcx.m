%% run_mcx.m
clear; clc;

addpath(genpath('mcx'));
run cfg_shared;

%% -----------------------------
% Build voxel volume
%% -----------------------------
% Volume size (must match tissue box!)
Nx = 80; Ny = 80; Nz = 20;
vol = ones(Nx, Ny, Nz, 'uint8');  % single tissue label

%% -----------------------------
% MCX configuration
%% -----------------------------
mcx_cfg = struct;

mcx_cfg.nphoton = cfg.nphoton;
mcx_cfg.vol     = vol;
mcx_cfg.tstart  = 0;
mcx_cfg.tend    = 5e-9;
mcx_cfg.tstep   = 5e-9;

mcx_cfg.unitinmm = 1;

mcx_cfg.srcpos = cfg.src.pos;
mcx_cfg.srcdir = cfg.src.dir;
mcx_cfg.srctype = cfg.src.type;

mcx_cfg.prop = [ ...
    0 0 1 1;                    % background
    cfg.optical.tissue          % tissue
];

mcx_cfg.seed = cfg.seed;
mcx_cfg.autopilot = 1;
mcx_cfg.gpuid = 1;

%% -----------------------------
% Run MCX
%% -----------------------------
out = mcxlab(mcx_cfg);

fluence_mcx = out.data;

save('mcx_output.mat', 'fluence_mcx');

disp('MCX simulation complete');
