include("utils/get.jl")

input = getinput("two", String)
insttuple = split.(input, " ")

t = reduce(
    (acc, inst) -> begin
        dir, value = inst
        value = parse(Int64, value)

        if dir == "forward" 
            acc["depth"] += value * acc["aim"]
            acc["x"] += value
        else
            acc["aim"] += (dir == "up" ? -1 : 1) * value
        end

        return acc
    end,
    insttuple, 
    init = Dict(
        "x" => 0, "depth" => 0, "aim" => 0
    )
)

t["x"] * t["depth"]
