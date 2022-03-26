import BenchmarkTools: @benchmark

function f1(x, y)
    X = repeat(x, outer=length(y))
    Y = repeat(y, inner=length(x))
    return [X Y]
end

function f2(x, y)
    f(x,y) = [x y]
    return reduce(vcat, f.(x,y'))
end

function f3(x, y)
    f(x,y) = [x y]
    return vcat(f.(x,y')...)
end

g(x,y) = [x y]

f4(x, y) = reduce(vcat, g.(x,y'))
f5(x, y) = vcat(g.(x,y')...)

begin # if abspath(PROGRAM_FILE) == @__FILE__
    x = -2:2
    y = -2:2
    
    val = f1(x, y)

    @assert val == f2(x, y) "Error in  f2(x, y)"
    @assert val == f3(x, y) "Error in  f3(x, y)"
    @assert val == f4(x, y) "Error in  f4(x, y)"
    @assert val == f5(x, y) "Error in  f5(x, y)"

    display(val)
    println("\n"^3)

    display(@benchmark f1(x, y)); println("\n"^3)
    display(@benchmark f2(x, y)); println("\n"^3)
    display(@benchmark f3(x, y)); println("\n"^3)
    display(@benchmark f4(x, y)); println("\n"^3)
    display(@benchmark f5(x, y))
end
