function VBR = init_vbr_struct()
    VBR.in.elastic.methods_list={'anharmonic';'anh_poro'};
    VBR.in.viscous.methods_list={'HZK2011'};
    VBR.in.anelastic.methods_list={'eburgers_psp';'andrade_psp';'xfit_premelt';'xfit_mxw'};
    VBR.in.anelastic.eburgers_psp.eBurgerFit='bg_peak';
end
