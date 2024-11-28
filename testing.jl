# This file is used to test the parallelism in Julia using cases from 'julia-threads.ipynb' file

###### TEST 1
# x = Threads.@spawn begin
#     print("thread ", Threads.threadid(), " somou: " ) #apenas uma thread irá realizar a soma
#     sum(1:1_000_000)
# end

# print(fetch(x))


###### TEST 2
# tasks = []
# for i in 1:4
#     push!(tasks, Threads.@spawn begin
#             println(Threads.threadid())
#             sum((i-1)*1_000+1:i*1_000)
#         end)
# end

# total = sum(fetch.(tasks)) # o ponto é para aplicar a função fetch a cada elemento do vetor tasks
# print(total)


###### TEST 3
# Threads.@threads for i in 1:4
#     println("Thread $(Threads.threadid()) executando iteração $i")
# end


###### TEST 4
# using Base.Threads

# soma = Atomic{Int}(0)

# @threads for i in 1:10
#     atomic_add!(soma, i) # a função atomic_add! garante que a operação de soma seja feita de forma atômica
# end

# println(soma[])

###### TEST 5
using Base.Threads

my_lock = ReentrantLock()  # Cria a trava
soma = 0

Threads.@threads for i in 1:10
    @lock my_lock global soma += i
end

println(soma)