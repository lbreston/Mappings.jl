struct AssociativeMap <: Mapping
    amap::Dict
    inv_amap::Dict
end

AssociativeMap(amap::Dict) = AssociativeMap(amap, invert(amap))
AssociativeMap(keys::Union{Array,Set}, vals::Union{Array,Set}) = AssociativeMap(Dict(zip(keys, vals)))
AssociativeMap(f::Function, d) = AssociativeMap(Dict([(x, f(x)) for x in d]))


dom(m::AssociativeMap) = Set(keys(m.amap))
inverse(m::AssociativeMap) = AssociativeMap(m.inv_amap, m.amap)
inv(m::AssociativeMap) = inverse(m)
applymap(m::AssociativeMap, x) = m.amap[x]


function invert(D::Dict)
    invD = Dict{valtype(D), Union{keytype(D), Set{keytype(D)}}}()
    for k in keys(D)
        if D[k] in keys(invD)
            invD[D[k]] = isa(invD[D[k]], Set) ? (invD[D[k]],) ∪ Set((k,)) : Set((invD[D[k]],)) ∪ Set((k,))
        else
            invD[D[k]] = k
        end
    end
    return invD
end

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


function compose(Outer::AssociativeMap, Inner::AssociativeMap)
    dom(Outer) ∩ codom(Inner) |> x -> preimage(Inner, x) |> x -> AssociativeMap(Dict(zip(x, Outer.(Inner.(x)))))
end

ComposedFunction(Outer::AssociativeMap, Inner::AssociativeMap) = compose(Outer, Inner) 



