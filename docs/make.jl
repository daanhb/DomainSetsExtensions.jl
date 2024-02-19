using DomainSetsExtensions
using Documenter

DocMeta.setdocmeta!(DomainSetsExtensions, :DocTestSetup, :(using DomainSetsExtensions); recursive=true)

makedocs(;
    modules=[DomainSetsExtensions],
    authors="Daan Huybrechs <daan.huybrechs@kuleuven.be> and contributors",
    sitename="DomainSetsExtensions.jl",
    format=Documenter.HTML(;
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
