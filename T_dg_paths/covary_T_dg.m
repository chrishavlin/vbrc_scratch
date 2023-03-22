function VBR = covary_T_dg(dg_max, dg_min, T_max, T_min)
    
    T_K_1 = linspace(T_max, T_min, 100)+273; % etmperature [K]
    dT = T_max - T_min;
    dg_test_exp = dg_max - (dg_max - dg_min) * (T_K_1(1) - T_K_1)/dT;
    
    VBR = init_vbr_struct();
    VBR.in.SV.T_K = T_K_1;
    VBR.in.SV.dg_um = (10.^(dg_test_exp)) * 1e6;

    VBR = add_on_other_vars(VBR, size(VBR.in.SV.dg_um));
    
    VBR = density_correction(VBR);
    
    VBR = VBR_spine(VBR);
    
end 
