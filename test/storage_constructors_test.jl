@test try
    @info "testing Abstract Storage With DC - PF"
    ps_model = PSI.CanonicalModel(Model(GLPK_optimizer),
                              Dict{String, JuMP.Containers.DenseAxisArray{JuMP.AbstractVariableRef}}(),
                              Dict{String, JuMP.Containers.DenseAxisArray}(),
                              nothing,
                              Dict{String, PSI.JumpAffineExpressionArray}("var_active" => PSI.JumpAffineExpressionArray(undef, 5, 24),
                                                                         "var_reactive" => PSI.JumpAffineExpressionArray(undef, 5, 24)),
                              Dict{String,Any}(),
                              nothing);
    PSI.construct_device!(ps_model, PSY.Storage, PSI.AbstractStorageForm, PM.DCPlosslessForm, sys5b_uc);
true finally end

@test try
    @info "testing Abstract Storage With AC - PF"
    ps_model = PSI.CanonicalModel(Model(ipopt_optimizer),
                              Dict{String, JuMP.Containers.DenseAxisArray{JuMP.AbstractVariableRef}}(),
                              Dict{String, JuMP.Containers.DenseAxisArray}(),
                              nothing,
                              Dict{String, PSI.JumpAffineExpressionArray}("var_active" => PSI.JumpAffineExpressionArray(undef, 5, 24),
                                                                         "var_reactive" => PSI.JumpAffineExpressionArray(undef, 5, 24)),
                              Dict{String,Any}(),
                              nothing);
PSI.construct_device!(ps_model, PSY.Storage, PSI.AbstractStorageForm, PM.StandardACPForm, sys5b_uc);
true finally end

@test try
    @info "testing Basic Storage With DC - PF"
    ps_model = PSI.CanonicalModel(Model(GLPK_optimizer),
                                  Dict{String, JuMP.Containers.DenseAxisArray{JuMP.AbstractVariableRef}}(),
                                  Dict{String, JuMP.Containers.DenseAxisArray}(),
                                  nothing,
                              Dict{String, PSI.JumpAffineExpressionArray}("var_active" => PSI.JumpAffineExpressionArray(undef, 5, 24),
                                                                         "var_reactive" => PSI.JumpAffineExpressionArray(undef, 5, 24)),
                              Dict{String,Any}(),
                              nothing);
    PSI.construct_device!(ps_model, PSY.Storage, PSI.BookKeepingModel, PM.DCPlosslessForm, sys5b_uc);
    true finally end

@test try
    @info "testing Basic Storage With AC - PF"
    ps_model = PSI.CanonicalModel(Model(ipopt_optimizer),
                                  Dict{String, JuMP.Containers.DenseAxisArray{JuMP.AbstractVariableRef}}(),
                                  Dict{String, JuMP.Containers.DenseAxisArray}(),
                                  nothing,
                              Dict{String, PSI.JumpAffineExpressionArray}("var_active" => PSI.JumpAffineExpressionArray(undef, 5, 24),
                                                                         "var_reactive" => PSI.JumpAffineExpressionArray(undef, 5, 24)),
                              Dict{String,Any}(),
                              nothing);
    PSI.construct_device!(ps_model, PSY.Storage, PSI.BookKeepingModel, PM.StandardACPForm, sys5b_uc);
    true finally end
