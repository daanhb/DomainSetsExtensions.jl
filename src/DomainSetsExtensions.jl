module DomainSetsExtensions

export canonicalextensiontype

using DomainSets
using DomainSets: CanonicalType

# Until this function is in DomainSets
equaldomain(d) = canonicaldomain(DomainSets.Equal(), d)

"Canonical types used to translate between packages."
abstract type CanonicalExtensionType <: CanonicalType
end

"Return the extension type associated with the given domain."
canonicalextensiontype(d) = canonicalextensiontype(typeof(d))


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
