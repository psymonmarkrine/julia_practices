using BenchmarkTools


function f1(A::M, X::V) where {T, M <: Matrix{T}, V <: Vector{T}}
    b = A * X
    return b
end

function f2(A::M, X::V) where {T, M <: Matrix{T}, V <: Vector{T}}
    n, m = size(A)
    b = zeros(n)
    for i = 1:n
        for j = 1:m
            b[i] += A[i, j] * X[j]
        end
    end
    return b
end

function f3(A::M, X::V) where {T, M <: Matrix{T}, V <: Vector{T}}
    n, m = size(A)
    b = [sum([A[i, j] * X[j] for j = 1:m]) for i = 1:n]
    return b
end

function main(n)
    A = randn(n, n)
    x = randn(n)
    
    println(f1(A, x))
    println(f2(A, x))
    println(f3(A, x))
    println("\n"^3)

    display(@benchmark f1($A, $x)); println("\n"^3)
    display(@benchmark f2($A, $x)); println("\n"^3)
    display(@benchmark f3($A, $x));
end

if abspath(PROGRAM_FILE) == @__FILE__
main(100)
end