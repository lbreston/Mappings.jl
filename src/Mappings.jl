module Mappings

import InverseFunctions: inverse
import Base: inv, one, ComposedFunction

import IntervalSets
export Interval

import DomainSets: Domain
export Domain

#export types
export Mapping, AssociativeMap

#export functions
export dom, image, preimage, codom, inverse, inv, ComposedFunction


abstract type Mapping end
(m::Mapping)(x) = applymap(m, x)
function dom(m::Mapping) end
_image(m::Mapping, x) = reduce(∪, m.(x))
image(m::Mapping, x) = _image(m, x)
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