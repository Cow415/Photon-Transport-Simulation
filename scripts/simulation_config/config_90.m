%% ================================
%  Redbird Forward Simulation at 90 Degree Beam Entry
%  (Using existing mesh data)
% =================================

% Set-up =================================
clear; clc;

%% Load processed mesh
% Mesh must contain:
%   node : [N x 3]
%   elem : [M x 4]

mesh = load('mesh_data.mat'); %Mesh Stored Path

cfg = struct();
cfg.node = mesh.node;
cfg.elem = mesh.elem;

% Optional surface faces (recommended for speed??)
if isfield(mesh,'face')
    cfg.face = mesh.face;
end

% Initialization ================================= 
%% Preprocess mesh (IMPORTANT)
% Computes volumes, surfaces, FEM bookkeeping, etc.
cfg = rbmeshprep(cfg);

%% Define optical properties
% Format per row: [mua  musp  g  n]
% Row 1 = background (unused)
% Row 2 = tissue region

cfg.prop = [
    0     0     1.0  1.0 ;   % dummy background
    0.01  1.0   0.9  1.4     % tissue
];

% Assign every element to region 2
cfg.seg = 2 * ones(size(cfg.elem,1),1);

%% Define source(s)
cfg.srctype = 'pencil';
cfg.srcpos  = [0 0 0];     % [x y z]
cfg.srcdir  = [0 0 1];     % direction

%% Define detector(s)
cfg.dettype = 'pencil';
cfg.detpos  = [0 0 20];    % detector position

%% Frequency-domain setting (optional)
cfg.omega = 0;             % 0 = CW (most common)


% Iterate Calculation =================================
%% Run Redbird forward solver
[detval, phi] = rbrunforward(cfg);

%% Inspect detector output
disp('Detector value:');
disp(detval);

% Post-process ================================= 
%% Visualize fluence on surface
figure;

% Extract surface triangles if not provided
if ~isfield(cfg,'face')
    fv = rb2surf(cfg.node, cfg.elem);
    trisurf(fv, cfg.node(:,1), cfg.node(:,2), cfg.node(:,3), phi);
else
    trisurf(cfg.face, cfg.node(:,1), cfg.node(:,2), cfg.node(:,3), phi);
end

% Graphing ================================= 
shading interp;
axis equal;
view(3);
colorbar;
title('Redbird Fluence Distribution');
xlabel('x'); ylabel('y'); zlabel('z');
