function VBR = density_correction(VBR);
    
    P_GPa = VBR.in.SV.P_GPa; 
    T_K = VBR.in.SV.T_K; 
    
    rho_p = san_carlos_density_from_pressure(P_GPa);
    rho = Density_Thermal_Expansion(rho_p, T_K, 0.9);
    
    VBR.in.SV.rho = rho; 
        
end
    
