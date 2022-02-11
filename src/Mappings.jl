module Mappings

import InverseFunctions: inverse
import Base: HasLength, inv


#export types
export Mapping, AssociativeMap

#export functions
export dom, image, preimage, codom, inverse, inv


abstract type Mapping end
(m::Mapping)(x) = applymap(m, x)
function dom(m::Mapping) end
function image(m::Mapping, x) 
    if HasLength(x) || length(x) <=1
        return m(x)
    else
        return Set(unique(m.(x)))
    end
end

image(m::Mapping) = image(m, dom(m))
preimage(m::Mapping) = image(inverse(m))
preimage(m::Mapping, x) = image(inverse(m), x)
codom(m::Mapping) = dom(inverse(m))

#maptypes 

#Identity map
# struct IDmap <: Mapping end
# applymap(m::IDmap, x) = x
# one(m::Mapping) = IDmap()

include("AssociativeMaps.jl")



end