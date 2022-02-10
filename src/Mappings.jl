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
export dom, image, preimage, codom, inverse, inv, ComposedFunction, compose


abstract type Mapping <: Function end
(m::Mapping)(x) = applymap(m, x)
function dom(m::Mapping) end
image(m::Mapping) = image(m, dom(m))
image(m::Mapping, x) = Set(m.(x))

#optional
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
