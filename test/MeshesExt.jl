
using Meshes

mshct = canonicalextensiontype(Meshes.Geometry)

@testset "Meshes.jl" begin

@testset "interface" begin
    d = Meshes.Box((0.0, 0.0, 0.0), (1.0, 1.0, 1.0))
    @test canonicalextensiontype(d) == mshct
    @test DomainStyle(d) == IsDomain()
    @test domaineltype(d) == SVector{3,Float64}
end

@testset "canonical domains" begin
    d1 = Meshes.Box((0.0, 0.0, 0.0), (1.0, 1.0, 1.0))
    d1c = ProductDomain(0..1.0, 0..1.0, 0..1.0)
    @test equaldomain(d1) isa DomainSets.HyperRectangle{SVector{3,Float64}}
    @test canonicaldomain(d1) == canonicaldomain(d1c)
end

end
