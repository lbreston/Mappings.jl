using Mappings
using Test

D1 = Dict([("a" => "1"), ("b" => "3"), ("c" => "3")])|>x->Dict{keytype(x), valtype(x)}(x)
m = AssociativeMap(D1)
inverse(m)




@testset "Mappings.jl" begin
    # Write your tests here.
end

