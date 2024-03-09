module DomainSetsIntervalsExt

using DomainSetsExtensions

using DomainSetsExtensions: DomainSets
const DS = DomainSets

import DomainSets:
    todomainset,
    DomainStyle,
    domaineltype,
    convert_eltype,
    canonicaldomain,
    mapfrom_canonical

using DomainSets:
    equaldomain,
    TypedEndpointsInterval,
    leftendpoint,
    rightendpoint

using Intervals
const IV = Intervals

"Canonical type associated with Intervals.jl"
struct IntervalsExtCType <: DomainSets.CanonicalExtensionType
end

DomainSets.canonicalextensiontype(::Type{<:IV.AbstractInterval}) = IntervalsExtCType()
DomainSets.canonicalextensiontype(::Type{<:IV.IntervalSet}) = IntervalsExtCType()

## The Intervals.Interval type

DomainStyle(d::IV.AbstractInterval) = DS.IsDomain()
domaineltype(d::IV.Interval) = eltype(d)
domaineltype(d::IV.Interval{T}) where {T <: Integer} = float(T)

convert_eltype(::Type{T}, d::IV.Interval{T}) where {T} = d
convert_eltype(::Type{T}, d::IV.Interval{S,L,R}) where {T,S,L,R} =
    IV.Interval{T,L,R}(first(d), last(d))

todomainset(d::IV.Interval{T,Closed,Closed}) where T =
    DS.Interval{:closed,:closed,T}(d.first, d.last)
todomainset(d::IV.Interval{T,Closed,Open}) where T =
    DS.Interval{:closed,:open,T}(d.first, d.last)
todomainset(d::IV.Interval{T,Open,Closed}) where T =
    DS.Interval{:open,:closed,T}(d.first, d.last)
todomainset(d::IV.Interval{T,Open,Open}) where T =
    DS.Interval{:open,:open,T}(d.first, d.last)

canonicaldomain(::DS.Equal, d::IV.Interval) =
    todomainset(d)

canonicaldomain(d::IV.Interval) =
    canonicaldomain(todomainset(d))
mapfrom_canonical(d::IV.Interval) =
    mapfrom_canonical(todomainset(d))


# translation in the other direction
fromdomainset(d::TypedEndpointsInterval{:closed, :closed, T}) where T =
    IV.Interval{T,Closed,Closed}(leftendpoint(d), rightendpoint(d))
fromdomainset(d::TypedEndpointsInterval{:closed, :open, T}) where T =
    IV.Interval{T,Closed,Open}(leftendpoint(d), rightendpoint(d))
fromdomainset(d::TypedEndpointsInterval{:open, :closed, T}) where T =
    IV.Interval{T,Open,Closed}(leftendpoint(d), rightendpoint(d))
fromdomainset(d::TypedEndpointsInterval{:open, :open, T}) where T =
    IV.Interval{T,Open,Open}(leftendpoint(d), rightendpoint(d))

canonicaldomain(::IntervalsExtCType, d::TypedEndpointsInterval) =
    fromdomainset(d)
mapfrom_canonical(::IntervalsExtCType, d::TypedEndpointsInterval) =
    mapfrom_canonical(DS.Equal(), d)


## The Intervals.IntervalSet type

DomainStyle(d::IV.IntervalSet) = IsDomain()
domaineltype(d::IV.IntervalSet) = domaineltype(d.items[1])

convert_eltype(::Type{T}, d::IV.IntervalSet) where T =
    IV.IntervalSet(map(d->convert_eltype(T, d), d.items))

todomainset(d::IV.IntervalSet) = UnionDomain(map(todomainset, d.items))

canonicaldomain(::DS.Equal, d::IV.IntervalSet) =
    todomainset(d)

canonicaldomain(d::IV.IntervalSet) =
    canonicaldomain(todomainset(d))
mapfrom_canonical(d::IV.IntervalSet) =
    mapfrom_canonical(todomainset(d))

end # module
