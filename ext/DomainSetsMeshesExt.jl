module DomainSetsMeshesExt

using DomainSetsExtensions
using DomainSetsExtensions:
    MeshesExtCType,
    MakiePlotting

using DomainSetsExtensions: DomainSets
const DS = DomainSets

using DomainSets:
    SVector,
    HyperRectangle,
    components,
    leftendpoint,
    rightendpoint

import DomainSets:
    todomainset,
    DomainStyle,
    domaineltype,
    convert_eltype,
    canonicaldomain,
    mapfrom_canonical

using Meshes

equaldomain(d) = canonicaldomain(DS.Equal(), d)


DomainStyle(d::Meshes.Geometry) = DS.IsDomain()
domaineltype(d::Meshes.Geometry{Dim,T}) where {Dim,T} = SVector{Dim,T}


## The box type

todomainset(d::Meshes.Box) =
    DS.Rectangle(Tuple(coordinates(minimum(d))), Tuple(coordinates(maximum(d))))
fromdomainset(d::DS.HyperRectangle{SVector{N,T}}) where {N,T} =
    Meshes.Box(Tuple(map(leftendpoint, components(d))),
        Tuple(map(rightendpoint, components(d))))

canonicaldomain(::DS.Equal, d::Meshes.Box) = todomainset(d)

canonicaldomain(d::Meshes.Box) = canonicaldomain(todomainset(d))
mapfrom_canonical(d::Meshes.Box) = mapfrom_canonical(todomainset(d))

canonicaldomain(::MeshesExtCType, d::DS.HyperRectangle{SVector{N,T}}) where {N,T} =
    fromdomainset(d)

## Plotting with Makie

canonicaldomain(::MakiePlotting, d::DS.HyperRectangle{SVector{N,T}}) where {N,T} =
    canonicaldomain(MeshesExtCType(), d)

Meshes.viz(d::DomainSets.Domain) = Meshes.viz(fromdomainset(d))

end # module
