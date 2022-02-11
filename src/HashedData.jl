const ID = UInt 

id(x) = hash(x)
id(x::ID) = x

struct IDmap
    objects::Dict{ID, Any}
end

IDmap(vals) = IDmap(Dict(hash.(vals).=>vals)) 

hasobj(d::IDmap, i::ID) = haskey(d.objects, i)
getobj(d::IDMap, i::ID) = @assert hasobj(d, i)  d.objects[i]



