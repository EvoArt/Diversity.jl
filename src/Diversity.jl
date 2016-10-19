__precompile__()

"""
The main **Diversity** module provides basic numbers-equivalent
diversity measures (described in
[Hill, 1973](http://www.jstor.org/stable/1934352)),
similarity-sensitive diversity measures (generalised from Hill, and
described in
[Leinster and Cobbold, 2012](http://www.esajournals.org/doi/abs/10.1890/10-2402.1)),
and related alpha, beta and gamma diversity measures at the level of
the metacommunity and its component subcommunities (generalised in
turn from Leinster and Cobbold, and described in
[Reeve et al, 2014](http://arxiv.org/abs/1404.6520)). The diversity
functions exist both with unicode names (e.g. ```ᾱ()```), which are
not automatically exported (as we feel they are too short) and with
matching longer ASCII names (e.g. ```NormalisedAlpha()```), which are.
We also provide functions to calculate appropriate
```subcommunityDiversity()``` and ```metacommunityDiversity()```
values for each measure, a general ```diversity()``` function for
extract any diversity measure at a series of scales.
"""
module Diversity

include("Metacommunity.jl")
export Subcommunities, Onecommunity
export Similarity, Unique, Species, Taxonomy, MatrixSimilarity
export Metacommunity
export getabundance, getweight
export getsimilarity, getordinariness!, getmetaordinariness!
export inddiv, subdiv, metadiv

include("EffectiveNumbers.jl")
export qD, qDZ

include("DiversityMeasure.jl")
export DiversityLevel
export individualDiversity, subcommunityDiversity, metacommunityDiversity

export RawAlpha, NormalisedAlpha
export RawBeta, NormalisedBeta, RawRho, NormalisedRho
export Gamma
## We do not export ᾱ, α, β̄, β, ρ̄, ρ, γ̄, γ as they're too short

export getName, getASCIIName, getFullName

include("GeneralisedDiversities.jl")
export diversity

## Deprecate short names as too ambiguous
@deprecate(Dᾱ, subcommunityalphabar)
@deprecate(Dα, subcommunityalpha)
@deprecate(Dβ̄, subcommunitybetabar)
@deprecate(Dβ, subcommunitybeta)
@deprecate(Dρ̄, subcommunityrhobar)
@deprecate(Dρ, subcommunityrho)
@deprecate(Dγ̄, subcommunitygammabar)
@deprecate(Dγ, subcommunitygamma)
@deprecate(DĀ, metacommunityAbar)
@deprecate(DA, metacommunityA)
@deprecate(DB̄, metacommunityBbar)
@deprecate(DB, metacommunityB)
@deprecate(DR̄, metacommunityRbar)
@deprecate(DR, metacommunityR)
@deprecate(DḠ, metacommunityGbar)
@deprecate(DG, metacommunityG)

## Deprecate ecosystem-related names
@deprecate(ecosystemA, metacommunityA)
@deprecate(ecosystemAbar, metacommunityAbar)
@deprecate(ecosystemB, metacommunityB)
@deprecate(ecosystemBbar, metacommunityBbar)
@deprecate(ecosystemR, metacommunityR)
@deprecate(ecosystemRbar, metacommunityRbar)
@deprecate(ecosystemG, metacommunityG)
@deprecate(ecosystemGbar, metacommunityGbar)

## Deprecate all-in-one names, as we divide calculation into type of
## diversity and scale
@deprecate(subcommunityalphabar(pop, Z, qs),
           subcommunityDiversity(ᾱ(Metacommunity(pop, Z)), qs))
@deprecate(subcommunityalpha(pop, Z, qs),
           subcommunityDiversity(α(Metacommunity(pop, Z)), qs))
@deprecate(subcommunitybetabar(pop, Z, qs),
           subcommunityDiversity(β̄(Metacommunity(pop, Z)), qs))
@deprecate(subcommunitybeta(pop, Z, qs),
           subcommunityDiversity(β(Metacommunity(pop, Z)), qs))
@deprecate(subcommunityrhobar(pop, Z, qs),
           subcommunityDiversity(ρ̄(Metacommunity(pop, Z)), qs))
@deprecate(subcommunityrho(pop, Z, qs),
           subcommunityDiversity(ρ(Metacommunity(pop, Z)), qs))
@deprecate(subcommunitygammabar(pop, Z, qs),
           subcommunityDiversity(γ̄(Metacommunity(pop, Z)), qs))
@deprecate(subcommunitygamma(pop, Z, qs),
           subcommunityDiversity(γ(Metacommunity(pop, Z)), qs))
@deprecate(metacommunityAbar(pop, Z, qs),
           metacommunityDiversity(ᾱ(Metacommunity(pop, Z)), qs))
@deprecate(metacommunityA(pop, Z, qs),
           metacommunityDiversity(α(Metacommunity(pop, Z)), qs))
@deprecate(metacommunityBbar(pop, Z, qs),
           metacommunityDiversity(β̄(Metacommunity(pop, Z)), qs))
@deprecate(metacommunityB(pop, Z, qs),
           metacommunityDiversity(β(Metacommunity(pop, Z)), qs))
@deprecate(metacommunityRbar(pop, Z, qs),
           metacommunityDiversity(ρ̄(Metacommunity(pop, Z)), qs))
@deprecate(metacommunityR(pop, Z, qs),
           metacommunityDiversity(ρ(Metacommunity(pop, Z)), qs))
@deprecate(metacommunityG(pop, Z, qs),
           metacommunityDiversity(γ(Metacommunity(pop, Z)), qs))

@deprecate(subcommunityalphabar(pop, qs),
           subcommunityDiversity(ᾱ(Metacommunity(pop)), qs))
@deprecate(subcommunityalpha(pop, qs),
           subcommunityDiversity(α(Metacommunity(pop)), qs))
@deprecate(subcommunitybetabar(pop, qs),
           subcommunityDiversity(β̄(Metacommunity(pop)), qs))
@deprecate(subcommunitybeta(pop, qs),
           subcommunityDiversity(β(Metacommunity(pop)), qs))
@deprecate(subcommunityrhobar(pop, qs),
           subcommunityDiversity(ρ̄(Metacommunity(pop)), qs))
@deprecate(subcommunityrho(pop, qs),
           subcommunityDiversity(ρ(Metacommunity(pop)), qs))
@deprecate(subcommunitygammabar(pop, qs),
           subcommunityDiversity(γ̄(Metacommunity(pop)), qs))
@deprecate(subcommunitygamma(pop, qs),
           subcommunityDiversity(γ(Metacommunity(pop)), qs))
@deprecate(metacommunityAbar(pop, qs),
           metacommunityDiversity(ᾱ(Metacommunity(pop)), qs))
@deprecate(metacommunityA(pop, qs),
           metacommunityDiversity(α(Metacommunity(pop)), qs))
@deprecate(metacommunityBbar(pop, qs),
           metacommunityDiversity(β̄(Metacommunity(pop)), qs))
@deprecate(metacommunityB(pop, qs),
           metacommunityDiversity(β(Metacommunity(pop)), qs))
@deprecate(metacommunityRbar(pop, qs),
           metacommunityDiversity(ρ̄(Metacommunity(pop)), qs))
@deprecate(metacommunityR(pop, qs),
           metacommunityDiversity(ρ(Metacommunity(pop)), qs))
@deprecate(metacommunityG(pop, qs),
           metacommunityDiversity(γ(Metacommunity(pop)), qs))

## Deprecate anything related to ϵ as it has been replaced by ρ̄
@deprecate(subcommunityepsilon, Dρ̄)
@deprecate(Dϵ, Dρ̄)
@deprecate(ecosystemE, metacommunityRbar)
@deprecate(metacommunityE, metacommunityRbar)
@deprecate(DE, metacommunityRbar)

"""
The **Diversity.Ecology** module replicates old ecological
diversity measures and generalised versions of them that relate to our
general measures of alpha, beta and gamma diversity at subcommunity
and metacommunity levels. The generalisations of the richness, Shannon
and Simpson are the only standard measures we are aware of whose
subcommunity components sum directly to the corresponding ecosystem
measure (although note that Simpson's index decreases for increased
diversity, so small components are more diverse).
"""
module Ecology

include("Ecology.jl")
export generalisedrichness, richness
export generalisedshannon, shannon
export generalisedsimpson, simpson
export generalisedjaccard, jaccard

end # sub-module Ecology

"""
Lou Jost's
[diversity](http://dx.doi.org/10.1111/j.2006.0030-1299.14714.x)
[measures](http://www.esajournals.org/doi/abs/10.1890/06-1736.1) are
found in the **Diversity.Jost** module.
"""
module Jost

include("Jost.jl")
export jostbeta, jostalpha
@deprecate(jostα, jostalpha)
@deprecate(jostβ, jostbeta)

end # sub-module Jost

"""
[Hill numbers](http://www.jstor.org/stable/1934352) are found in the
**Diversity.Hill** package.
"""
module Hill

include("Hill.jl")
export hillnumber

end # sub-module Hill

end # module
