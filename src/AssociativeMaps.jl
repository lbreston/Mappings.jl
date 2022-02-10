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
    f(v) = collect(keys(D))[values(D).==v] |> x->Set((x),) |> x -> length(x) == 1 ? only(x) : x
    return Dict{valtype(D), Union{Set{keytype(D)}, keytype(D)}}((v, f(v)) for v in unique(values(D)))
end


function compose(Outer::AssociativeMap, Inner::AssociativeMap)
    dom(Outer) ∩ codom(Inner) |> x -> preimage(Inner, x) |> x -> AssociativeMap(Dict(zip(x, Outer.(Inner.(x)))))
end

ComposedFunction(Outer::AssociativeMap, Inner::AssociativeMap) = compose(Outer, Inner) 



