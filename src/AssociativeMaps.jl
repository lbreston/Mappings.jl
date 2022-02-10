struct AssociativeMap <: Mapping
    amap::Dict
    inv_amap::Dict
end

function AssociativeMap(amap::Dict{S,T}) where {S,T}
    f(x) = Set((x,))
    if !(S <: Set)
        if !(T <: Set)
            amap = Dict((f.(keys(amap)) .=> f.(values(amap))))
            AssociativeMap(amap, invert(amap))
        else
            amap = Dict((f.(keys(amap)) .=> values(amap)))
            AssociativeMap(amap, invert(amap))
        end
    else
        if !(T <: Set)
            amap = Dict((keys(amap) .=> f.(values(amap))))
            AssociativeMap(amap, invert(amap))
        else
            amap = Dict((keys(amap) .=> values(amap)))
            AssociativeMap(amap, invert(amap))
        end
    end
end


AssociativeMap(keys::Union{AbstractSet}, vals::Union{AbstractSet}) = AssociativeMap(Dict(zip(keys, vals)))
AssociativeMap(f::Function, d) = AssociativeMap(Dict([(x, f(x)) for x in d]))


dom(m::AssociativeMap) = reduce(∪, keys(m.amap))
inverse(m::AssociativeMap) = AssociativeMap(m.inv_amap, m.amap)
inv(m::AssociativeMap) = inverse(m)
applymap(m::AssociativeMap, x) = m.amap[Set((x,))]



function invert(D::Dict)
    invD = Dict()
    for k in keys(D)
        if D[k] in keys(invD)
            push!(invD[D[k]], k)
        else
            invD[D[k]] = [k]
        end
    end
    return invD
end

Base.ComposedFunction{AssociativeMap, AssociativeMap} <: Core.Function
Base.ComposedFunction{AssociativeMap, Funcation} <: Core.Function
Base.ComposedFunction{Function, AssociativeMap} <: Core.Function


# function Base.insert!(m::AssociativeMap, newpair)
#     k = newpair[1]
#     v = newpair[2]
#     if k in keys(m.amap)
#         m.amap[k] = m.amap[k] ∪ Set((v,))
#     else
#         m.amap[k] = v
#     end
#     if m.amap[k] in keys(m.inv_amap)
#         m.inv_amap[m.amap[k]] = m.amap[k] ∪ Set((v,))
#     else
#         m.inv_amap[m.amap[k]] = Set((k,))
#     end
#     return m
# end
