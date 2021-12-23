include("utils/get.jl")

draws, boards = getboard("four")

function addmark(draw, board)
    (board .== draw)
end

function computewinningboard(draws, boards)
    N = size(first(boards), 1)
    marked = [zeros(Int64, size(first(boards))) for _ in 1:length(boards)]

    for draw in draws

        for (i, board) in enumerate(boards)
            marked[i] += addmark(draw, board)

            colwin = any(sum(marked[i], dims = 1) .== N)
            rolwin = any(sum(marked[i], dims = 2) .== N)

            if colwin || rolwin 
                return marked[i], board, draw
            end

        end
    end
end

function computelastwinningboard(draws, boards)
    N = size(first(boards), 1)
    marked = [zeros(Int64, size(first(boards))) for _ in 1:length(boards)]
    activeboards = ones(Int64, length(boards))

    for draw in draws

        for (i, board) in enumerate(boards)
            if activeboards[i] == 1
                marked[i] += addmark(draw, board)
                
                colwin = any(sum(marked[i], dims = 1) .== N)
                rolwin = any(sum(marked[i], dims = 2) .== N)
                
                if colwin || rolwin
                    if sum(activeboards) > 1
                        activeboards[i] = 0
                    else
                        j = findfirst(==(1), activeboards)
                        return marked[j], boards[j], draw
                    end
                end


            end

        end
    end
end

function computescore(mark, board, draw)
    sum(board[mark .== 0]) * draw
end

marked, board, draw = computelastwinningboard(draws, boards)
computescore(marked, board, draw)
