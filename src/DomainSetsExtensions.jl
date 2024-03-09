module DomainSetsExtensions

export canonicalextensiontype

using DomainSets
using DomainSets: canonicalextensiontype

# Canonical types used to express certain functionality

"Supertype of canonical types that have to do with specific functionality."
abstract type CanonicalCapabilityType <: DomainSets.CanonicalType
end

"Canonical domains which are plottable."
abstract type Plotting <: CanonicalCapabilityType end

"Plotting capability with the Makie package."
struct MakiePlotting <: Plotting
end

"Plotting capability with the Plots package."
struct PlotsPlotting <: Plotting
end

include("FunctionMapsExtensions.jl")

end
