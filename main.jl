using Catalyst, DifferentialEquations, Plots


rn = @reaction_network begin
    (k1, k₋1), A <--> B
    (k2, k₋2), B <--> C
    (k3, k₋3), C <--> D
    # k_ex, D --> ∅
end

u0 = [:A => 10.0, :B => 0.0, :C => 0.0, :D => 0.0]
tspan = (0.0, 10.0)
p = [45.0, 36.0, 10.0, 1.0, 21.0, 12.0]  # [k1, k₋1, k2, k₋2, k3, k₋3, k_ex]


prob = ODEProblem(rn, u0, tspan, p)
sol = solve(prob, Tsit5())


plot(sol, xlabel="Time (min)", ylabel="Concentration", 
     title="Species Concentrations vs Time", 
     label=["[A]" "[B]" "[C]" "[D]"])

savefig("concentration.png")

t = sol.t
A_vals = sol[:A]; B_vals = sol[:B]; C_vals = sol[:C]; D_vals = sol[:D]
flux_AB = p[1] .* A_vals .- p[2] .* B_vals
flux_BC = p[3] .* B_vals .- p[4] .* C_vals
flux_CD = p[5] .* C_vals .- p[6] .* D_vals

plot(t, flux_AB, label="A⇄B", xlabel="Time (min)", ylabel="Net Flux",
     title="Net Flux of Each Reaction")
plot!(t, flux_BC, label="B⇄C")
plot!(t, flux_CD, label="C⇄D")

savefig("flux.png")