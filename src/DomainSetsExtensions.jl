module DomainSetsExtensions

using DomainSets
using DomainSets: CanonicalType


# Canonical types used to translate between packages

abstract type CanonicalExtensionType <: CanonicalType
end

"Canonical type associated with GeometryBasics.jl"
struct GeometryBasicsExtCType <: CanonicalExtensionType
end

"Canonical type associated with Intervals.jl"
struct IntervalsExtCType <: CanonicalExtensionType
end

"Canonical type associated with Meshes.jl"
struct MeshesExtCType <: CanonicalExtensionType
end


# Canonical types used to express certain functionality

"Supertype of canonical types that have to do with specific functionality."
abstract type CanonicalCapabilityType <: CanonicalType
end

"Canonical domains which are plottable."
abstract type Plotting <: CanonicalCapabilityType end

"Plotting capability with the Makie package."
struct MakiePlotting <: Plotting
end

"Plotting capability with the Plots package."
struct PlotsPlotting <: Plotting
end

end
