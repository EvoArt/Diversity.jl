module TestIterators
using Base.Test
using Phylo
using Diversity
using Diversity.Phylogenetics

@testset "Iterators" begin
    species = 10
    sc = 5
    abund = rand(species, sc)
    abund ./= sum(abund)
    ru = rand(Ultrametric(species))
    m = Metacommunity(abund, PhyloTypes(ru))
    @test length(TypeIterator(m)) == counttypes(PhyloTypes(ru))
    @test length(SubcommunityIterator(m)) == sc
    @test all(broadcast(≈, reduce(+, SubcommunityIterator(m)),
                        getmetaabundance(m)))
    @test all(broadcast(≈, reduce(+, TypeIterator(m)), getweight(m)))
end

end