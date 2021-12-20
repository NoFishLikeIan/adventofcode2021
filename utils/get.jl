using DelimitedFiles

function getinput(day, type; delim = '\n')
    readdlm("inputs/day$(day).txt", delim, type)
end
