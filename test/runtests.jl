using CartesianDomains
using Test

@testset "CartesianDomains.jl" begin
  domain = CartesianIndices((1:10, 4:8))

  @test lower_boundary_indices(domain, 1, +1) == CartesianIndices((2:2, 4:8))
  @test lower_boundary_indices(domain, 1, 0) == CartesianIndices((1:1, 4:8))
  @test lower_boundary_indices(domain, 1, -1) == CartesianIndices((0:0, 4:8))

  @test upper_boundary_indices(domain, 2, +1) == CartesianIndices((1:10, 9:9))
  @test upper_boundary_indices(domain, 2, 0) == CartesianIndices((1:10, 8:8))
  @test upper_boundary_indices(domain, 2, -1) == CartesianIndices((1:10, 7:7))

  @test expand(domain, 2, -1) == CartesianIndices((1:10, 5:7))
  @test expand(domain, 2, 0) == CartesianIndices((1:10, 4:8))
  @test expand(domain, 2, 2) == CartesianIndices((1:10, 2:10))

  @test expand(domain, 2) == CartesianIndices((-1:12, 2:10))

  @test expand_lower(domain, 2) == CartesianIndices((-1:10, 2:8))
  @test expand_upper(domain, 2) == CartesianIndices((1:12, 4:10))

  @test shift(CartesianIndex((4, 5, 6)), 3, +2) == CartesianIndex(4, 5, 8)
  @test shift(CartesianIndex((4, 5, 6)), +1) == CartesianIndex(5, 6, 7)
  @test shift(CartesianIndex((4, 5, 6)), 1, -2) == CartesianIndex(2, 5, 6)
  @test shift(CartesianIndex((4, 5, 6)), 0, +2) == CartesianIndex(4, 5, 6)
  @test shift(CartesianIndices((4, 5, 6)), +1) == CartesianIndices((2:5, 2:6, 2:7))

  # δ isn't exported...
  @test CartesianDomains.δ(1, CartesianIndex((4, 5, 6))) == CartesianIndex((1, 0, 0))

  nhalo = 2
  halo, edge = haloedge_regions(domain, 1, nhalo)

  @test halo == (lo=CartesianIndices((1:2, 6:6)), hi=CartesianIndices((9:10, 6:6)))
  @test edge == (lo=CartesianIndices((3:4, 6:6)), hi=CartesianIndices((7:8, 6:6)))
end
