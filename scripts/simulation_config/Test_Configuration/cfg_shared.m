%% cfg_shared.m
% Shared configuration for MCX and Redbird

cfg = struct;

%% -----------------------------
% Units
%% -----------------------------
cfg.unit = 'mm';

%% -----------------------------
% Optical properties
% [mua, mus, g, n]
%% -----------------------------
cfg.optical.tissue = [ ...
    0.01, ...   % absorption [1/mm]
    1.0,  ...   % scattering [1/mm]
    0.9,  ...   % anisotropy
    1.37  ...   % refractive index
];

%% -----------------------------
% Source definition
%% -----------------------------
cfg.src.type = 'pencil';
cfg.src.pos  = [20, 20, 0.5];   % mm
cfg.src.dir  = [0, 0, 1];
cfg.src.mag  = 1;

%% -----------------------------
% Detectors
%% -----------------------------
[x,y] = meshgrid(10:10:30, 10:10:30);
cfg.det.pos = [x(:), y(:), 9.5 * ones(numel(x),1)];

%% -----------------------------
% Simulation controls
%% -----------------------------
cfg.nphoton = 1e7;     % MCX photons
cfg.seed    = 12345;
