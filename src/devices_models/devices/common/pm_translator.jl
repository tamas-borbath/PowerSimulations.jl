
struct PMmap
    bus::Dict{Int, PSY.Bus}
    arcs::Dict{
        NamedTuple{(:from_to, :to_from), Tuple{Tuple{Int, Int, Int}, Tuple{Int, Int, Int}}},
        t where t <: PSY.ACBranch,
    }
    arcs_dc::Dict{
        NamedTuple{(:from_to, :to_from), Tuple{Tuple{Int, Int, Int}, Tuple{Int, Int, Int}}},
        t where t <: PSY.DCBranch,
    }
end

function get_branch_to_pm(ix::Int, branch::PSY.PhaseShiftingTransformer)
    PM_branch = Dict{String, Any}(
        "br_r" => PSY.get_r(branch),
        "rate_a" => PSY.get_rate(branch),
        "shift" => PSY.get_α(branch),
        "rate_b" => PSY.get_rate(branch),
        "br_x" => PSY.get_x(branch),
        "rate_c" => PSY.get_rate(branch),
        "g_to" => 0.0,
        "g_fr" => 0.0,
        "b_fr" => PSY.get_primary_shunt(branch) / 2,
        "f_bus" => PSY.get_number(PSY.get_arc(branch).from),
        "br_status" => Float64(PSY.get_available(branch)),
        "t_bus" => PSY.get_number(PSY.get_arc(branch).to),
        "b_to" => PSY.get_primary_shunt(branch) / 2,
        "index" => ix,
        "angmin" => -π / 2,
        "angmax" => π / 2,
        "transformer" => true,
        "tap" => PSY.get_tap(branch),
    )
    return PM_branch
end

function get_branch_to_pm(ix::Int, branch::PSY.Transformer2W)
    PM_branch = Dict{String, Any}(
        "br_r" => PSY.get_r(branch),
        "rate_a" => PSY.get_rate(branch),
        "shift" => 0.0,
        "rate_b" => PSY.get_rate(branch),
        "br_x" => PSY.get_x(branch),
        "rate_c" => PSY.get_rate(branch),
        "g_to" => 0.0,
        "g_fr" => 0.0,
        "b_fr" => PSY.get_primary_shunt(branch) / 2,
        "f_bus" => PSY.get_number(PSY.get_arc(branch).from),
        "br_status" => Float64(PSY.get_available(branch)),
        "t_bus" => PSY.get_number(PSY.get_arc(branch).to),
        "b_to" => PSY.get_primary_shunt(branch) / 2,
        "index" => ix,
        "angmin" => -π / 2,
        "angmax" => π / 2,
        "transformer" => true,
        "tap" => 1.0,
    )
    return PM_branch
end

function get_branch_to_pm(ix::Int, branch::PSY.TapTransformer)
    PM_branch = Dict{String, Any}(
        "br_r" => PSY.get_r(branch),
        "rate_a" => PSY.get_rate(branch),
        "shift" => 0.0,
        "rate_b" => PSY.get_rate(branch),
        "br_x" => PSY.get_x(branch),
        "rate_c" => PSY.get_rate(branch),
        "g_to" => 0.0,
        "g_fr" => 0.0,
        "b_fr" => PSY.get_primary_shunt(branch) / 2,
        "f_bus" => PSY.get_number(PSY.get_arc(branch).from),
        "br_status" => Float64(PSY.get_available(branch)),
        "t_bus" => PSY.get_number(PSY.get_arc(branch).to),
        "b_to" => PSY.get_primary_shunt(branch) / 2,
        "index" => ix,
        "angmin" => -π / 2,
        "angmax" => π / 2,
        "transformer" => true,
        "tap" => PSY.get_tap(branch),
    )
    return PM_branch
end

function get_branch_to_pm(ix::Int, branch::PSY.ACBranch)
    PM_branch = Dict{String, Any}(
        "br_r" => PSY.get_r(branch),
        "rate_a" => PSY.get_rate(branch),
        "shift" => 0.0,
        "rate_b" => PSY.get_rate(branch),
        "br_x" => PSY.get_x(branch),
        "rate_c" => PSY.get_rate(branch),
        "g_to" => 0.0,
        "g_fr" => 0.0,
        "b_fr" => PSY.get_b(branch).from,
        "f_bus" => PSY.get_number(PSY.get_arc(branch).from),
        "br_status" => Float64(PSY.get_available(branch)),
        "t_bus" => PSY.get_number(PSY.get_arc(branch).to),
        "b_to" => PSY.get_b(branch).to,
        "index" => ix,
        "angmin" => PSY.get_angle_limits(branch).min,
        "angmax" => PSY.get_angle_limits(branch).max,
        "transformer" => false,
        "tap" => 1.0,
    )
    return PM_branch
end

function get_branch_to_pm(ix::Int, branch::PSY.HVDCLine)
    PM_branch = Dict{String, Any}(
        "loss1" => PSY.get_loss(branch).l1,
        "mp_pmax" => PSY.get_reactive_power_limits_from(branch).max,
        "model" => 2,
        "shutdown" => 0.0,
        "pmaxt" => PSY.get_active_power_limits_to(branch).max,
        "pmaxf" => PSY.get_active_power_limits_from(branch).max,
        "startup" => 0.0,
        "loss0" => PSY.get_loss(branch).l1,
        "pt" => 0.0,
        "vt" => PSY.get_magnitude(PSY.get_arc(branch).to),
        "qmaxf" => PSY.get_reactive_power_limits_from(branch).max,
        "pmint" => PSY.get_active_power_limits_to(branch).min,
        "f_bus" => PSY.get_number(PSY.get_arc(branch).from),
        "mp_pmin" => PSY.get_reactive_power_limits_from(branch).min,
        "br_status" => Float64(PSY.get_available(branch)),
        "t_bus" => PSY.get_number(PSY.get_arc(branch).to),
        "index" => ix,
        "qmint" => PSY.get_reactive_power_limits_to(branch).min,
        "qf" => 0.0,
        "cost" => 0.0,
        "pminf" => PSY.get_active_power_limits_from(branch).min,
        "qt" => 0.0,
        "qminf" => PSY.get_reactive_power_limits_from(branch).min,
        "vf" => PSY.get_magnitude(PSY.get_arc(branch).from),
        "qmaxt" => PSY.get_reactive_power_limits_to(branch).max,
        "ncost" => 0,
        "pf" => 0.0,
    )
    return PM_branch
end

function get_branches_to_pm(sys::PSY.System)
    PM_ac_branches = Dict{String, Any}()
    PM_dc_branches = Dict{String, Any}()
    PMmap_ac = Dict{
        NamedTuple{(:from_to, :to_from), Tuple{Tuple{Int, Int, Int}, Tuple{Int, Int, Int}}},
        t where t <: PSY.ACBranch,
    }()
    PMmap_dc = Dict{
        NamedTuple{(:from_to, :to_from), Tuple{Tuple{Int, Int, Int}, Tuple{Int, Int, Int}}},
        t where t <: PSY.DCBranch,
    }()

    for (ix, branch) in enumerate(get_available_components(PSY.Branch, sys))
        if isa(branch, PSY.DCBranch)
            PM_dc_branches["$(ix)"] = get_branch_to_pm(ix, branch)
            if PM_dc_branches["$(ix)"]["br_status"] == true
                f = PM_dc_branches["$(ix)"]["f_bus"]
                t = PM_dc_branches["$(ix)"]["t_bus"]
                PMmap_dc[(from_to = (ix, f, t), to_from = (ix, t, f))] = branch
            end
        else
            PM_ac_branches["$(ix)"] = get_branch_to_pm(ix, branch)
            if PM_ac_branches["$(ix)"]["br_status"] == true
                f = PM_ac_branches["$(ix)"]["f_bus"]
                t = PM_ac_branches["$(ix)"]["t_bus"]
                PMmap_ac[(from_to = (ix, f, t), to_from = (ix, t, f))] = branch
            end
        end
    end

    return PM_ac_branches, PM_dc_branches, PMmap_ac, PMmap_dc
end

function get_buses_to_pm(buses::IS.FlattenIteratorWrapper{PSY.Bus})
    PM_buses = Dict{String, Any}()
    PMmap_buses = Dict{Int, PSY.Bus}()

    pm_bustypes = Dict{PSY.BusTypes.BusType, Int}(
        PSY.BusTypes.ISOLATED => 4,
        PSY.BusTypes.PQ => 1,
        PSY.BusTypes.PV => 2,
        PSY.BusTypes.REF => 3,
        PSY.BusTypes.SLACK => 3,
    )

    for bus in buses
        number = PSY.get_number(bus)
        PM_bus = Dict{String, Any}(
            "zone" => 1,
            "bus_i" => number,
            "bus_type" => pm_bustypes[PSY.get_bustype(bus)],
            "vmax" => PSY.get_voltage_limits(bus).max,
            "area" => 1,
            "vmin" => PSY.get_voltage_limits(bus).min,
            "index" => PSY.get_number(bus),
            "va" => PSY.get_angle(bus),
            "vm" => PSY.get_magnitude(bus),
            "base_kv" => PSY.get_base_voltage(bus),
            "pni" => 0.0,
            "qni" => 0.0,
            "name" => PSY.get_name(bus),
        )
        PM_buses["$(number)"] = PM_bus
        if PSY.get_bustype(bus) != PSY.BusTypes.ISOLATED::PSY.BusTypes.BusType
            PMmap_buses[number] = bus
        end
    end
    return PM_buses, PMmap_buses
end

function pass_to_pm(sys::PSY.System, time_periods::Int)

    ac_lines, dc_lines, PMmap_ac, PMmap_dc = get_branches_to_pm(sys)
    buses = PSY.get_components(PSY.Bus, sys)
    pm_buses, PMmap_buses = get_buses_to_pm(buses)
    PM_translation = Dict{String, Any}(
        "bus" => pm_buses,
        "branch" => ac_lines,
        "baseMVA" => PSY.get_base_power(sys),
        "per_unit" => true,
        "storage" => Dict{String, Any}(),
        "dcline" => dc_lines,
        "gen" => Dict{String, Any}(),
        "switch" => Dict{String, Any}(),
        "shunt" => Dict{String, Any}(),
        "load" => Dict{String, Any}(),
    )

    # TODO: this function adds overhead in large number of time_steps
    # We can do better later.

    PM_translation = PM.replicate(PM_translation, time_periods)

    PM_map = PMmap(PMmap_buses, PMmap_ac, PMmap_dc)

    return PM_translation, PM_map
end
