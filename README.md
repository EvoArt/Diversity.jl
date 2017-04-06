# Diversity

*Package for measuring and partitioning diversity*

| **Documentation**                               | **PackageEvaluator**            | **Build Status**                                                    |
|:-----------------------------------------------:|:-------------------------------:|:-------------------------------------------------------------------:|
| [![][docs-stable-img]][docs-stable-url] | [![][pkg-0.5-img]][pkg-0.5-url] | [![][travis-img]][travis-url] [![][appveyor-img]][appveyor-url]     |
| [![][docs-latest-img]][docs-latest-url]         | [![][pkg-0.6-img]][pkg-0.6-url] | [![][codecov-img]][codecov-url] [![][coveralls-img]][coveralls-url] |

**Diversity** is a [Julia](http://www.julialang.org) package that
provides functionality for measuring alpha, beta and gamma diversity
of metacommunities (e.g. ecosystems) and their constituent
subcommunities. It uses the diversity measures described in the arXiv
paper [arXiv:1404.6520 (q-bio.QM)](http://arxiv.org/abs/1404.6520),
*How to partition diversity*. It also provides a series of other
related and older diversity measures through sub-modules. Currently
these are all ecological diversity measures, but this will be
expanded, possibly through interfacing to BioJulia.

This package is still in alpha and under heavy development, and so we
do not guarantee its correctness, although we are aware of no problems
with it. Please [raise an issue][issues-url] if you find any problems.

**Version 0.3, which has just been released, has significant breaking
changes to the standard interface for calculating diversity and
especially to the output format to provide consistency with our R
package [rdiversity](https://github.com/boydorr/rdiversity).** In
particular, we now use a DataFrame as the common output format for all
of the diversity calculations. The code is certainly not optimised for
speed at the moment due to the substantial changes that have happened
to it under the hood.

Older interfaces have been deprecated, and will be removed in v0.4.

## Install

*Diversity* is in `METADATA` and can be installed via `Pkg.add("Diversity")`.

## Usage

#### Diversity

The main package provides basic numbers-equivalent diversity measures
(described in [Hill, 1973](http://www.jstor.org/stable/1934352)),
similarity-sensitive diversity measures (generalised from Hill, and
described in
[Leinster and Cobbold, 2012](http://www.esajournals.org/doi/abs/10.1890/10-2402.1)),
and related alpha, beta and gamma diversity measures at the level of
the metacommunity and its component subcommunities (generalised in
turn from Leinster and Cobbold, and described in
[Reeve et al, 2014](http://arxiv.org/abs/1404.6520)). The diversity
functions exist both with unicode names (e.g. ᾱ()), which are not
automatically exported as we feel they are too short and with matching
ascii names (e.g. NormalisedAlpha()), which are. We also provide a
general function for extract any diversity measure for a series of
subcommunity relative abundances.

Accessing the main functionality in the package is simple:

```julia_skip
using Diversity
...
diversities = metadiv(NormalisedAlpha(Metacommunity(proportions, Z)), [0, 1, 2, Inf])
diversity = subdiv(RawRho(Metacommunity(proportions, Z)), 2)
```

The package also provides sub-modules with other diversity measures:

#### Diversity.Ecology

Many existing ecological diversity measures can be derived from our
diversity measures, and so we provide them in the Diversity.Ecology
submodule along with generalised versions of them that relate to our
general measures of alpha, beta and gamma diversity at subcommunity
and metacommunity levels. The generalisations of species richness,
Shannon entropy and Simpson's index are the only standard measures we
are aware of whose subcommunity components sum directly to the
corresponding metacommunity measure (although note that Simpson's
index decreases for increased diversity, so small components are more
diverse). Documentation for these diversity measures can be found
[here](http://diversityjl.readthedocs.org/en/stable/ecology/).

#### Diversity.Hill

[Hill numbers](http://www.jstor.org/stable/1934352) are found in the
Diversity.Hill sub-module.
Documentation for these diversity measures can be found
[here](http://diversityjl.readthedocs.org/en/stable/hill/).

#### Diversity.Jost

Lou Jost's
[diversity](http://dx.doi.org/10.1111/j.2006.0030-1299.14714.x)
[measures](http://www.esajournals.org/doi/abs/10.1890/06-1736.1) are
found in the Diversity.Jost sub-module.
Documentation for these diversity measures is
[here](http://diversityjl.readthedocs.org/en/stable/jost/).

## Documentation

Documentation is generated by the Base documentation in Julia and
online via the
[Documenter](https://github.com/JuliaDocs/Documenter.jl) package.

### Usage

Accessing the documentation in Julia is easy in v0.5 onwards:

```julia
using Diversity

# Returns any documentation for the qDZ function and all qDZ methods
?qDZ

# Returns the specific documentation for that qD method call
?qD([0.1, 0.2, 0.7], 2)
```

The documentation is also available online.

### Stable branch

The online documentation for the current stable branch is
[here][docs-stable-url].

### Master branch

The online documentation for the latest master (unreleased) branch is
[here][docs-latest-url].

[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://richardreeve.github.io/Diversity.jl/latest

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://richardreeve.github.io/Diversity.jl/stable

[travis-img]: https://travis-ci.org/richardreeve/Diversity.jl.svg?branch=master
[travis-url]: https://travis-ci.org/richardreeve/Diversity.jl?branch=master

[appveyor-img]: https://ci.appveyor.com/api/projects/status/github/richardreeve/Diversity.jl?svg=true&branch=master
[appveyor-url]: https://ci.appveyor.com/project/richardreeve/diversity-jl/branch/master

[coveralls-img]: https://img.shields.io/coveralls/richardreeve/Diversity.jl.svg
[coveralls-url]: https://coveralls.io/r/richardreeve/Diversity.jl?branch=master

[codecov-img]: https://codecov.io/gh/richardreeve/Diversity.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/richardreeve/Diversity.jl

[issues-url]: https://github.com/richardreeve/Diversity.jl/issues

[pkg-0.5-img]: http://pkg.julialang.org/badges/Diversity_0.5.svg
[pkg-0.5-url]: http://pkg.julialang.org/?pkg=Diversity&ver=0.5
[pkg-0.6-img]: http://pkg.julialang.org/badges/Diversity_0.6.svg
[pkg-0.6-url]: http://pkg.julialang.org/?pkg=Diversity&ver=0.6
