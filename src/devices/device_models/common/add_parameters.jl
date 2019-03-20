function add_parameters(ps_m::CanonicalModel,
                        data::Matrix,
                        param_name::Symbol,
                        axs...)

    ps_m.parameters[param_name] = JuMP.Containers.DenseAxisArray{PJ.Parameter}(undef, axs...)

    Cidx = CartesianIndices(length.(axs))

    for idx in Cidx
        ps_m.parameters[param_name].data[idx] = PJ.Parameter(ps_m.JuMPmodel,data[idx])
    end

end