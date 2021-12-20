import Base

include("utils/get.jl")

struct Binary
    value::Vector{Int64}
    function Binary(v::Vector{Int64})
        return new(v)
    end
    function Binary(s::String)
        value = parse.(Int64, split(s, ""))
        row = new(value)
        return row
    end
end

function Base.:+(a::Binary, b::Binary)
    return Binary(Base.:+(a.value, b.value))
end

binvectoint(arr) = sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))

input = map(Binary, getinput("three", String))

res = reduce(+, input).value .≥ length(input) ÷ 2
gamma = binvectoint(res)
epsilon = binvectoint(.~res)
power = gamma * epsilon

function oxygen(input::Vector{Binary})
    

end