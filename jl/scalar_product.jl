using BenchmarkTools


function f1(X::V, Y::V) where {T, V <: Vector{T}}
    S = X' * Y
    return S
end

function f2(X::V, Y::V) where {T, V <: Vector{T}}
    S = sum(X .* Y)
    return S
end

function f3(X::V, Y::V) where {T, V <: Vector{T}}
    S = sum([x*y for (x,y) = zip(X, Y)])
    return S
end

function f4(X::V, Y::V) where {T, V <: Vector{T}}
    S = 0
    for (x,y) = zip(X,Y)
        S += x * y
    end
    return S
end

function f5(X::V, Y::V) where {T, V <: Vector{T}}
    len = length(X)
    S = 0
    for i = 1:len
        S += X[i] * Y[i]
    end
    return S
end


function main(n)
        x = randn(n)
        y = randn(n)
        
        println(f1(x, y))
        println(f2(x, y))
        println(f3(x, y))
        println(f4(x, y))
        println(f5(x, y))
        println("\n"^3)
    
        display(@benchmark f1($x, $y)); println("\n"^3)
        display(@benchmark f2($x, $y)); println("\n"^3)
        display(@benchmark f3($x, $y)); println("\n"^3)
        display(@benchmark f4($x, $y)); println("\n"^3)
        display(@benchmark f5($x, $y))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main(100)
end