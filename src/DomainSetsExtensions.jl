module DomainSetsExtensions

using DomainSets
using DomainSets: CanonicalType

"Canonical type associated with Intervals.jl"
struct IntervalsExtCType <: CanonicalType
end

"Canonical type associated with GeometryBasics.jl"
struct GeometryBasicsExtCType <: CanonicalType
end

ext_ctypes = Dict{String,CanonicalType}()
ext_ctypes["Intervals.jl"] = IntervalsExtCType()
ext_ctypes["GeometryBasics.jl"] = GeometryBasicsExtCType()

end
