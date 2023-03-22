%% put VBR in the path %%
  clear
  path_to_top_level_vbr=getenv('vbrdir');
  addpath(path_to_top_level_vbr)
  vbr_init

%% write method lists, adjust parameters %%
  VBR = init_vbr_struct();

%% Define the Thermodynamic State %%
  % build grid of dg and phi
  dg_um=logspace(-4,-1.3,30)*1e6; % grain size [um] (1 mm to 5 cm)
  
  T_K = linspace(500, 1400, 25)+273; % etmperature [K]
  [VBR.in.SV.dg_um,VBR.in.SV.T_K]=meshgrid(dg_um,T_K);

  % size of the state variable arrays to initialize remainign state variables
  sz=size(VBR.in.SV.dg_um);
  VBR = add_on_other_vars(VBR, sz);
  
  % calculate density
  VBR = density_correction(VBR);
    
%% CALL THE VBR CALCULATOR %%
  [VBR] = VBR_spine(VBR) ;


% co vary it! 

VBR2 = covary_T_dg(-2, -4, 1400, 700);




%% Build Plots %%
imeth = 1;
meth=VBR.in.anelastic.methods_list{imeth};
V=VBR.out.anelastic.(meth).V/1e3;
Qinv=VBR.out.anelastic.(meth).Qinv;

figure() 
subplot(1,2,1)
contourf(log10(dg_um/1e6), T_K, V)
hold on
plot(log10(VBR2.in.SV.dg_um*1e-6), VBR2.in.SV.T_K, 'k', 'linewidth',2)
colorbar()
xlabel('log10(grain size [m])')
ylabel('T [K]')
title("V [m/s]")

subplot(1,2,2)
contourf(log10(dg_um/1e6), T_K, log10(Qinv))
hold on
plot(log10(VBR2.in.SV.dg_um*1e-6), VBR2.in.SV.T_K, 'k', 'linewidth',2)
colorbar()
xlabel('log10(grain size [m])')
ylabel('T [K]')
title("log10(Q^{-1})")


figure()

subplot(2,1,1)
Vms = VBR2.out.anelastic.(meth).V/1e3;
plot(VBR2.in.SV.T_K, Vms, 'linewidth',2)
xlim([min(VBR2.in.SV.T_K), max(VBR2.in.SV.T_K)])
ylabel('V [m/s]')
xlabel('T [K] along path')
set(gca,'xdir','rev')
subplot(2,1,2)
logdg_m = log10(VBR2.in.SV.dg_um*1e-6);
plot(logdg_m, Vms, 'linewidth',2)
xlim([min(logdg_m), max(logdg_m)])
set(gca,'xdir','rev')
ylabel('V [m/s]')
xlabel('log10(grain size [m]) along path')

figure()

subplot(2,1,1)
Qinv = log10(VBR2.out.anelastic.(meth).Qinv);
plot(VBR2.in.SV.T_K, Qinv, 'linewidth',2)
xlim([min(VBR2.in.SV.T_K), max(VBR2.in.SV.T_K)])
set(gca,'xdir','rev')
ylabel('log10(Qinv)')
xlabel('T [K] along path')

subplot(2,1,2)
logdg_m = log10(VBR2.in.SV.dg_um*1e-6);
plot(logdg_m, Qinv, 'linewidth',2)
xlim([min(logdg_m), max(logdg_m)])
set(gca,'xdir','rev')
ylabel('log10(Qinv)')
xlabel('log10(grain size [m]) along path')
