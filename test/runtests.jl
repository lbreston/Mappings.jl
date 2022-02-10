using Mappings
using Test

D1=Dict([("a"=>"1"), ("b"=>"3"), ("c"=>"3")])
m=AssociativeMap(D1)
insert!(m, ("d", "4"))

@testset "Mappings.jl" begin
    # Write your tests here.
end
