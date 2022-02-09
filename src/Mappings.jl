module Mappings

import InverseFunctions: inverse
import Base: inv, one, ComposedFunction

#export types
export Mapping, AssociativeMap

#export functions
export dom, image, preimage, codom, inverse, inv, ComposedFunction


abstract type Mapping end

(m::Mapping)(x) = applymap(m, x)
function dom(m::Mapping) end
image(m::Mapping) = image(m, dom(m))
image(m::Mapping, x) = mapreduce(m, ∪, x)
preimage(m::Mapping) = image(inverse(m))
preimage(m::Mapping, x) = image(inverse(m), x)
codom(m::Mapping) = dom(inverse(m))

struct IDmap <: Mapping end
applymap(m::IDmap, x) = x
one(m::Mapping) = IDmap()

struct AssociativeMap <: Mapping
    amap::Dict
    inv_amap::Dict
end

AssociativeMap(amap) = AssociativeMap(amap, invert(amap))
dom(m::AssociativeMap) = Set(keys(m.amap))
inverse(m::AssociativeMap) = AssociativeMap(m.inv_amap, m.amap)
inv(m::AssociativeMap) = inverse(m)
applymap(m::AssociativeMap, x) = m.amap[x]

function invert(D::Dict)
    invD = Dict{valtype(D),Set{keytype(D)}}()
    for k in keys(D)
        if D[k] in keys(invD)
            push!(invD[D[k]], k)
        else
            invD[D[k]] = Set((k,))
        end
    end
    return invD
end

function compose(Outer::AssociativeMap, Inner::AssociativeMap)
    jointdom = dom(Outer) ∩ codom(Inner) |> x->preimage(Inner, x)
    AssociativeMap(Dict(zip(jointdom, Outer.(Inner.(jointdom)))))
end

ComposedFunction(Outer::AssociativeMap, Inner::AssociativeMap) = compose(Outer, Inner) 

end
