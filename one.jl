include("utils/get.jl")

input = getinput("one", Int64)

npos = sum(input[2:end] .- input[1:end-1] .> 0)

threegroups = sum(input[(3:end) .- i] for i in 0:2)

npos = sum(threegroups[2:end] .- threegroups[1:end-1] .> 0)