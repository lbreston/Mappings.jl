
using Mappings

using Test
v = collect(1:1:26)
v
D1 = Dict(zip('A':'Z',v))
D2 = Dict(zip(v,rand(26)))
m1 = AssociativeMap(D1)
m2 = AssociativeMap(D2)

import Base.HasLength
m1.amap
image(m1,'A')
codom(m1)
dom(m2)
dom(m2)
codom(m1)
inverse(m1)
inverse(inverse(m1))

m1('A')

m1 ∘ m2

image(d)

image(m1,'A')

inverse(m)
preimage(m1)


invert(m.amap)

D1
using BenchmarkTools
m.(Set(('A', 'B', 'C')))
Set(m.(['A', 'B', 'C']))
[(k, v) for (k, v) in collect(D1)]

dict = Dict(1:10 .=> repeat(1:5, 2))
rdict = Dict(values(dict) .=> keys(dict))

D = invD

invD


@testset "Mappings.jl" begin
    # Write your tests here.
end

