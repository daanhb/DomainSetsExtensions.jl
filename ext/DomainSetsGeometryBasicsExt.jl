module DomainSetsGeometryBasicsExt

using DomainSetsExtensions
using DomainSetsExtensions:
    equaldomain

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
    SVector,
    leftendpoint,
    rightendpoint

using GeometryBasics
const GB = GeometryBasics

"Canonical type associated with GeometryBasics.jl"
struct GeometryBasicsExtCType <: DomainSetsExtensions.CanonicalExtensionType
end

DomainSetsExtensions.canonicalextensiontype(::Type{<:GB.AbstractGeometry}) =
    GeometryBasicsExtCType()

DomainStyle(d::GB.AbstractGeometry) = DS.IsDomain()
domaineltype(d::GB.AbstractGeometry{DIM,T}) where {DIM,T} = SVector{DIM,T}

## The Point type

# repeat because AbstractPoint does not inherit from AbstractGeometry, it is a vector
DomainStyle(d::GB.AbstractPoint) = IsDomain()
domaineltype(d::GB.AbstractPoint{DIM,T}) where {DIM,T} = SVector{DIM,T}

convert_eltype(::Type{SVector{N,T}}, d::GB.Point{N,T}) where {N,T} = d
convert_eltype(::Type{SVector{N,T}}, d::GB.Point{N}) where {N,T} = GB.Point{N,T}(d.data)

todomainset(d::GB.AbstractPoint{N,T}) where {N,T} = DS.Point{SVector{N,T}}(d)
fromdomainset(d::DS.Point{SVector{N,T}}) where {N,T} = GB.Point{N,T}(d.x)

canonicaldomain(::DS.Equal, d::GB.AbstractPoint) = todomainset(d)

canonicaldomain(d::GB.AbstractPoint) = canonicaldomain(todomainset(d))
mapfrom_canonical(d::GB.AbstractPoint) = mapfrom_canonical(todomainset(d))

canonicaldomain(::GeometryBasicsExtCType, d::DS.Point{SVector{N,T}}) where {N,T} =
    fromdomainset(d)


## The HyperRectangle primitive

convert_eltype(::Type{SVector{N,T}}, d::GB.HyperRectangle{N,T}) where {N,T} = d
convert_eltype(::Type{SVector{N,T}}, d::GB.HyperRectangle{N}) where {N,T} =
    GB.HyperRectangle{N,T}(d.origin, d.widths)

todomainset(d::GB.HyperRectangle{N,T}) where {N,T} =
    DS.Rectangle{SVector{N,T}}(d.origin, d.origin+d.widths)
function fromdomainset(d::DS.HyperRectangle{SVector{N,T}}) where {N,T}
    a,b = leftendpoint(d), rightendpoint(d)
    GB.HyperRectangle{N,T}(a..., (b .- a)...)
end

canonicaldomain(::DS.Equal, d::GB.HyperRectangle) = todomainset(d)
canonicaldomain(::GeometryBasicsExtCType, d::DS.HyperRectangle{SVector{N,T}}) where {N,T} =
    fromdomainset(d)

canonicaldomain(d::GB.HyperRectangle) = canonicaldomain(todomainset(d))
mapfrom_canonical(d::GB.HyperRectangle) = mapfrom_canonical(todomainset(d))


## The HyperSphere primitive

convert_eltype(::Type{SVector{N,T}}, d::GB.HyperSphere{N,T}) where {N,T} = d
convert_eltype(::Type{SVector{N,T}}, d::GB.HyperSphere{N}) where {N,T} =
    GB.Sphere{N,T}(d.center, d.r)

todomainset(d::GB.HyperSphere{N,T}) where {N,T} = DS.Ball{SVector{N,T}}(d.r, d.center)
fromdomainset(d::DS.Ball{SVector{N,T}}) where {N,T} =
    GB.HyperSphere{N,T}(GB.Point(DS.center(d)), DS.radius(d))

canonicaldomain(::DS.Equal, d::GB.HyperSphere) = todomainset(d)
canonicaldomain(::GeometryBasicsExtCType, d::DS.Ball{SVector{N,T}}) where {N,T} =
    fromdomainset(d)

canonicaldomain(d::GB.HyperSphere) = canonicaldomain(todomainset(d))
mapfrom_canonical(d::GB.HyperSphere) = mapfrom_canonical(todomainset(d))

end # module
