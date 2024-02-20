
using GeometryBasics
const GB = GeometryBasics

using DomainSets: SVector

gbct = canonicalextensiontype(GB.AbstractGeometry)

@testset "GeometryBasics.jl" begin

@testset "interface" begin
    d = GB.Rect(0.0, 1.0, 1.0, 2.0)
    @test canonicalextensiontype(d) == gbct
    @test DomainStyle(d) == IsDomain()
    @test domaineltype(d) == SVector{2,Float64}
end

@testset "points" begin
    d1 = GB.Point(0.4, 0.5)
    d1c = DS.Point(SVector(0.4,0.5))
    @test equaldomain(d1) isa DS.Point{SVector{2,Float64}}
    @test canonicaldomain(d1) == canonicaldomain(d1c)
    @test isequaldomain(d1, d1c)
    @test isequaldomain(d1c, d1)
    @test canonicaldomain(gbct, d1c) isa GB.Point2
    @test canonicaldomain(gbct, d1c) == d1
end

@testset "rectangles" begin
    d1 = GB.Rect(0.0, 1.0, 2.0, 3.0)
    d1c = DS.Rectangle(SVector(0.0,1.0), SVector(2.0, 4.0))
    @test equaldomain(d1) isa DS.Rectangle{SVector{2,Float64}}
    @test canonicaldomain(d1) == canonicaldomain(d1c)
    @test isequaldomain(d1, d1c)
    @test isequaldomain(d1c, d1)
    @test canonicaldomain(gbct, d1c) isa GB.Rect2
    @test canonicaldomain(gbct, d1c) == d1
end

@testset "spheres" begin
    d1 = GB.HyperSphere(GB.Point(0.0, 0.0, 0.0), 1.0)
    d1c = DS.UnitBall()
    @test equaldomain(d1) isa DS.Ball{SVector{3,Float64}}
    @test canonicaldomain(d1) == canonicaldomain(d1c)
    @test isequaldomain(d1, d1c)
    @test isequaldomain(d1c, d1)
    @test canonicaldomain(gbct, d1c) isa GB.HyperSphere{3,Float64}
    @test canonicaldomain(gbct, d1c) == d1
end

end
