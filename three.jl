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

Base.iterate(a::Binary) =  Base.iterate(a.value)

binvectoint(arr) = sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))

input = map(Binary, getinput("three", String)) |> vec

res = reduce(+, input).value .≥ length(input) ÷ 2
gamma = binvectoint(res)
epsilon = binvectoint(.~res)
power = gamma * epsilon

function fromcriteria(input::Vector{Binary}, operation)
    bitsize = first(input).value |> length
    valid = copy(input)

    for i in 1:bitsize
        keep = []

        byte = operation.(reduce(+, valid).value, length(valid) / 2)[i]

        for (j, row) in enumerate(valid)
            if byte == row.value[i]
                push!(keep, j)
            end
        end

        valid = valid[keep]

        if length(valid) == 1
            return first(valid)
        end
    end
end

o = fromcriteria(input, ≥)
c = fromcriteria(input, <)
power = binvectoint(o.value) * binvectoint(c.value)