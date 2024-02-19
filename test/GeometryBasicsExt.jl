
using GeometryBasics
const GB = GeometryBasics

using DomainSets: SVector

gbct = DomainSetsExtensions.GeometryBasicsExtCType()

@testset "interface" begin
    d = GB.Rect(0.0, 1.0, 1.0, 2.0)
    @test DomainStyle(d) == IsDomain()
    @test domaineltype(d) == SVector{2,Float64}
end

@testset "canonical intervals" begin
    d1 = GB.Point(0.4, 0.5)
    d1c = DS.Point(SVector(0.4,0.5))
    @test canonicaldomain(equal, d1) isa DS.Point{SVector{2,Float64}}
    @test canonicaldomain(d1) == canonicaldomain(d1c)
    @test isequaldomain(d1, d1c)
    @test isequaldomain(d1c, d1)
    @test canonicaldomain(gbct, d1c) isa GB.Point2
    @test canonicaldomain(gbct, d1c) == d1
end
