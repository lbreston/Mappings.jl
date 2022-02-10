using Mappings
using Test

D1 = Dict([(x, rand(1000)) for x in 'A':'Z'])
m = AssociativeMap(D1)
inverse(m)



using BenchmarkTools
m.(Set(('A', 'B', 'C')))
Set(m.(['A', 'B', 'C']))

@benchmark (collect(D1))







@testset "Mappings.jl" begin
    # Write your tests here.
end

