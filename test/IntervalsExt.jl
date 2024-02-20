
using Intervals
const IV = Intervals

.. = DomainSets.IntervalSets.:..

ivct = DomainSetsExtensions.IntervalsExtCType()

@testset "Intervals.jl" begin

@testset "interface" begin
    d = IV.Interval{Float64, Closed, Closed}(0,1)
    @test DomainStyle(d) == IsDomain()
    @test domaineltype(d) == Float64

    d2 = IV.Interval{Int, Closed, Closed}(0,1)
    @test domaineltype(d2) == Float64
    @test eltype(DS.convert_eltype(Float64, d2)) == Float64
end


@testset "canonical intervals" begin
    d1 = IV.Interval{Float64, Closed, Closed}(0,1)
    d1c = DS.IntervalSets.Interval{:closed,:closed}(0.0,1.0)
    @test canonicaldomain(equal, d1) isa DS.IntervalSets.AbstractInterval{Float64}
    @test canonicaldomain(d1) == canonicaldomain(d1c)
    @test isequaldomain(d1, d1c)
    @test isequaldomain(d1c, d1)
    @test canonicaldomain(ivct, d1c) isa IV.Interval
    @test canonicaldomain(ivct, d1c) == d1

    d2 = IV.Interval{Float64, Closed, Open}(0,1)
    d2c = DS.IntervalSets.Interval{:closed,:open}(0.0,1.0)
    @test canonicaldomain(equal, d2) isa DS.IntervalSets.AbstractInterval{Float64}
    @test canonicaldomain(d2) == canonicaldomain(d2c)
    @test isequaldomain(d2, d2c)
    @test isequaldomain(d2c, d2)
    @test canonicaldomain(ivct, d2c) isa IV.Interval
    @test canonicaldomain(ivct, d2c) == d2

    d3 = IV.Interval{Float64, Open, Closed}(0,1)
    d3c = DS.IntervalSets.Interval{:open,:closed}(0.0,1.0)
    @test canonicaldomain(equal, d3) isa DS.IntervalSets.AbstractInterval{Float64}
    @test canonicaldomain(d3) == canonicaldomain(d3c)
    @test isequaldomain(d3, d3c)
    @test isequaldomain(d3c, d3)
    @test canonicaldomain(ivct, d3c) isa IV.Interval
    @test canonicaldomain(ivct, d3c) == d3

    d4 = IV.Interval{Float64, Open, Open}(0,1)
    d4c = DS.IntervalSets.Interval{:open,:open}(0.0,1.0)
    @test canonicaldomain(equal, d4) isa DS.IntervalSets.AbstractInterval{Float64}
    @test canonicaldomain(d4) == canonicaldomain(d4c)
    @test isequaldomain(d4, d4c)
    @test isequaldomain(d4c, d4)
    @test canonicaldomain(ivct, d4c) isa IV.Interval
    @test canonicaldomain(ivct, d4c) == d4
end

@testset "set operations" begin
    d1 = IV.Interval(1.0, 2.0)
    d2 = DS.Interval(0.0, 3.0)
    @test issubset(DomainRef(d1), d2)
    @test !issubset(d2, DomainRef(d1))
    @test isequaldomain(DomainRef(d1) ∩ d2, d1)
    @test isequaldomain(d2 ∩ DomainRef(d1), d1)
    @test isequaldomain(DomainRef(d1) ∪ d2, d2)
    @test isequaldomain(d2 ∪ DomainRef(d1), d2)
    @test isempty(DomainRef(d1) \ d2)
    @test d2 \ DomainRef(d1) == uniondomain(DS.Interval{:closed,:open}(0,1), DS.Interval{:open,:closed}(2,3))
end

@testset "interoperability" begin
    d1 = IV.Interval{Float64, Closed, Closed}(0,1)
    d2 = DS.IntervalSets.Interval{:closed,:closed}(0.0,1.0)
    @test productdomain(d1,d2) isa DS.VcatDomain{2,Float64}

    d1int = IV.Interval{Int, Closed, Closed}(0,1)
    @test productdomain(d1int,d2) isa DS.VcatDomain{2,Float64}
end

end
