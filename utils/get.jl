using DelimitedFiles

function makepath(day)
    "inputs/day$(day).txt"
end

function getinput(day, type; delim = '\n')
    readdlm(makepath(day), delim, type)
end

function getboard(day)
    open(makepath(day), "r") do io
        raw = read(io, String)
        draws, rawboards... =  split(raw, "\n\n")

        draws = parse.(Int64, split(draws, ','))
        rawboards = split.(rawboards, '\n')
        
        boards = Matrix{Int64}[]

        for board in rawboards
            numboard = []
            for row in board
                push!(
                    numboard,
                    parse.(
                        Int64,
                        filter(!isempty, split(row, " "))
                    )
                )
            end
            B = hcat(numboard...)'
            
            push!(boards, B)
        end

        return draws, boards
    end
end