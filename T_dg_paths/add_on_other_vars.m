function VBR = add_on_other_vars(VBR, sz)
    VBR.in.SV.phi = zeros(sz); % melt fraction
    VBR.in.SV.P_GPa = 3.2 * ones(sz); % pressure [GPa]
    VBR.in.SV.rho = 3300 * ones(sz); % density [kg m^-3]
    VBR.in.SV.sig_MPa = 0.1 * ones(sz); % differential stress [MPa]
    VBR.in.SV.Tsolidus_K=1200+273*ones(sz);
    Thomol=VBR.in.SV.T_K ./ VBR.in.SV.Tsolidus_K;
    VBR.in.SV.f = 0.01; %  frequencies to calculate at
    
end
