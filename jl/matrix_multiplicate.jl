using BenchmarkTools

function f1(A::M, B::M) where {T, M <: Matrix{T}}
    C = A * B
    return C
end

function f2(A, B)
    N, K = size(A)
    K, M = size(B)
    C = zeros(N, M)
    for i = 1:N
        for j = 1:M
            for k = 1:K
                C[i, j] += A[i, k] * B[k, j]
            end
        end
    end
    return C
end

function f3(A, B)
    N, K = size(A)
    K, M = size(B)
    C = [sum([A[i, k] * B[k, j] for k = 1:K]) for i = 1:N for j = 1:M]
    return C
end

function main(n)
    A = randn(n, n)
    B = randn(n, n)
    
    println(f1(A, B))
    println(f2(A, B))
    println(f3(A, B))
    println("\n"^3)

    display(@benchmark f1($A, $B)); println("\n"^3)
    display(@benchmark f2($A, $B)); println("\n"^3)
    display(@benchmark f3($A, $B));
end

if abspath(PROGRAM_FILE) == @__FILE__
main(10)
end