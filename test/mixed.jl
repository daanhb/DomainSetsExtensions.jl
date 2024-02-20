
using Meshes, GeometryBasics, Intervals

@testset "Mixed domain types" begin
    d1 = Meshes.Box((0.0, 1.0), (2.0, 4.0))
    d2 = GeometryBasics.Rect(0.0, 1.0, 2.0, 3.0)
    @test canonicaldomain(d1) == canonicaldomain(d2)
    @test isequaldomain(d1, d2)
    @test DomainRef(d1) == DomainRef(d2)

    d3 = Intervals.Interval(0.0, 1.0)
    d4 = DomainSets.IntervalSets.Interval(2.0, 3.0)
    d34 = productdomain(d3, d4)
    @test isequaldomain(d34, DomainSets.Rectangle([0.0, 2.0], [1.0, 3.0]))
    @test isequaldomain(d34, Meshes.Box((0.0, 2.0), (1.0, 3.0)))
end
