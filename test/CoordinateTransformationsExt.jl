using CoordinateTransformations
const CT = CoordinateTransformations

ctct = canonicalextensiontype(CT.Transformation)

using DomainSets.FunctionMaps: canonicalmap

@testset "CoordinateTransformations.jl" begin
    t = CT.Translation(0.5)
    @test canonicalmap(t) isa FM.Translation
end
