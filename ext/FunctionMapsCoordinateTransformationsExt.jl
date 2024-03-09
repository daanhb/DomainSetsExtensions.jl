module FunctionMapsCoordinateTransformationsExt

using CoordinateTransformations
const CT = CoordinateTransformations

using DomainSetsExtensions:
    DomainSets,
    FunctionMapsExtensions

const DS = DomainSets
const FME = FunctionMapsExtensions
const FM = DomainSets.FunctionMaps

import DomainSets.FunctionMaps:
    tofunctionmap,
    MapStyle,
    domaintype,
    convert_domaintype,
    canonicalmap,
    canonicalextensiontype

"Canonical type associated with CoordinateTransformations.jl"
struct CoordinateTransformationsExtCType <: FM.CanonicalExtensionType
end

canonicalextensiontype(::Type{<:CT.Transformation}) = CoordinateTransformationsExtCType()
MapStyle(m::CT.Transformation) = FM.IsMap()

canonicalmap(m::CT.Transformation) = canonicalmap(tofunctionmap(m))
canonicalmap(::FM.Equal, m::CT.Transformation) = tofunctionmap(m)

canonicalmap(::CoordinateTransformationsExtCType, m::FM.Map) = fromfunctionmap(m)

domaintype(m::CT.Transformation) = domaintype(tofunctionmap(m))
convert_domaintype(::Type{T}, m::CT.Transformation) where T =
    fromfunctionmap(convert_domaintype(T, tofunctionmap(m)))


## Affine maps

# - Translation
tofunctionmap(m::CT.Translation) = FM.Translation(m.translation)
fromfunctionmap(m::FM.Translation) = CT.Translation(m.b)

end
