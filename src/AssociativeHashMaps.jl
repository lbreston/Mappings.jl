
struct AssociativeHashMap{T,::N} where {T<:ID, N<:{Union{T,Vector{T}}}}
    amap::Dict{T, N}
    inv_amap::Dict{N, T}
end

AssociativeHashMap(amap::Dict) = AssociativeHashMap(amap, invert(amap))
AssociativeHashMap(keys::T, vals) where T<:Vector = AssociativeHashMap(Dict(zip(keys, vals)))

(m::AssociativeHashMap)(x) = applymap(m, x)
applymap(m::AssociativeHashMap, x) = m.amap[x]
inverse(m::AssociativeHashMap) = AssociativeHashMap(m.inv_amap, m.amap)
inv(m::AssociativeHashMap) = inverse(m)


image(m::AssociativeHashMap, x) =  unique(m.(x))
image(m::AssociativeHashMap) =      codom(m)
preimage(m::AssociativeHashMap) =    dom(m)
preimage(m::AssociativeHashMap, x) = image(inverse(m), x)
codom(m::AssociativeHashMap) = dom(inverse(m))


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



# Base.ComposedFunction{AssociativeHashMap, AssociativeHashMap} <: Core.Function
# Base.ComposedFunction{AssociativeHashMap, Function} <: Core.Function
# Base.ComposedFunction{Function, AssociativeHashMap} <: Core.Function


# function Base.insert!(m::AssociativeHashMaps, newpair)
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
