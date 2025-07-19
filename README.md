# Four-Step Reaction Network Simulation

A Julia-based simulation of a four-step chemical reaction network using Catalyst.jl, DifferentialEquations.jl, and Plots.jl.

## Overview

This project simulates a four-step reversible chemical reaction network with an irreversible exit reaction:

```
A ⇄ B ⇄ C ⇄ D → ∅
```

The system models the sequential conversion of species A through intermediate species B and C to final product D, which then exits the system irreversibly.

## Reaction Network

The reaction network consists of four reactions:

1. **A ⇄ B**: Reversible conversion with rate constants k₁ and k₋₁
2. **B ⇄ C**: Reversible conversion with rate constants k₂ and k₋₂  
3. **C ⇄ D**: Reversible conversion with rate constants k₃ and k₋₃
4. **D → ∅**: Irreversible exit reaction with rate constant k_ex

## Mathematical Model

The system is described by a set of ordinary differential equations (ODEs):

```
d[A]/dt = -k₁[A] + k₋₁[B]
d[B]/dt = k₁[A] - k₋₁[B] - k₂[B] + k₋₂[C]
d[C]/dt = k₂[B] - k₋₂[C] - k₃[C] + k₋₃[D]
d[D]/dt = k₃[C] - k₋₃[D] - k_ex[D]
```

## Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| k₁        | 45.0  | Forward rate constant for A→B |
| k₋₁       | 36.0  | Reverse rate constant for B→A |
| k₂        | 10.0  | Forward rate constant for B→C |
| k₋₂       | 1.0   | Reverse rate constant for C→B |
| k₃        | 21.0  | Forward rate constant for C→D |
| k₋₃       | 12.0  | Reverse rate constant for D→C |
| k_ex      | 1.0   | Exit rate constant for D→∅ |

## Initial Conditions

- [A]₀ = 10.0 (initial concentration of species A)
- [B]₀ = 0.0 (initial concentration of species B)
- [C]₀ = 0.0 (initial concentration of species C)
- [D]₀ = 0.0 (initial concentration of species D)

## Simulation Details

- **Time span**: 0.0 to 10.0 minutes
- **Solver**: Tsit5 (5th order Tsitouras method)
- **Integration**: Automatic step size control with adaptive error estimation

## Output

The simulation generates two visualization plots:

1. **Species Concentrations vs Time** (`concentration.svg`)
   - Shows the temporal evolution of all species concentrations
   - Demonstrates the sequential conversion and eventual steady state

2. **Net Flux of Each Reaction** (`flux.svg`)
   - Shows the net reaction flux for each reversible reaction
   - Calculated as: Net Flux = Forward Rate - Reverse Rate
   - Helps understand the direction and magnitude of each reaction

## Dependencies

This project requires the following Julia packages:

- **Catalyst.jl**: For defining and manipulating reaction networks
- **DifferentialEquations.jl**: For solving the ODE system
- **Plots.jl**: For creating visualizations

## Installation and Usage

1. **Install Julia** (version 1.6 or later recommended)

2. **Install required packages**:
   ```julia
   using Pkg
   Pkg.add("Catalyst")
   Pkg.add("DifferentialEquations")
   Pkg.add("Plots")
   ```

3. **Run the simulation**:
   ```bash
   julia main.jl
   ```

4. **View results**: The script generates two SVG files:
   - `concentration.svg`: Species concentration profiles
   - `flux.svg`: Reaction flux profiles

## Code Structure

The main script (`main.jl`) is organized into several sections:

1. **Package imports and reaction network definition**
2. **Parameter and initial condition setup**
3. **ODE problem construction and solution**
4. **Concentration profile visualization**
5. **Flux calculation and visualization**

## Scientific Applications

This type of reaction network is commonly found in:

- **Biochemical pathways**: Enzyme-catalyzed reaction cascades
- **Chemical synthesis**: Multi-step synthetic processes
- **Metabolic networks**: Cellular metabolism modeling
- **Pharmaceutical kinetics**: Drug metabolism and elimination

## Analysis Features

The simulation provides insights into:

- **Kinetic behavior**: How species concentrations evolve over time
- **Steady-state analysis**: Final equilibrium concentrations
- **Flux analysis**: Understanding reaction direction and magnitude
- **Parameter sensitivity**: How rate constants affect system behavior

## Extending the Model

The modular structure allows easy modifications:

- **Add more species**: Extend the reaction network
- **Modify rate constants**: Study parameter sensitivity
- **Change initial conditions**: Explore different starting states
- **Add external inputs**: Model time-dependent perturbations

## License

This project is open source and available under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests to improve the simulation or documentation.
