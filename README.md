# Gradient Elution Finite Volume LKM

MATLAB implementation of a high-resolution finite-volume solver for nonlinear and non-equilibrium gradient elution chromatography using the lumped kinetic model (LKM).

## Main Features

- Nonlinear lumped kinetic model for gradient elution chromatography
- Langmuir adsorption isotherm
- Linear Solvent Strength (LSS) parameter dependence
- High-resolution finite-volume discretization
- Koren TVD flux limiter
- Temporal moment analysis
- Core-shell particle parameter support through the core-radius fraction

## Repository Structure

```text
gradient-elution-finite-volume-lkm/
├── README.md
├── LICENSE
├── CITATION.cff
├── matlab/
│   ├── run_gradient_elution_lkm.m
│   ├── gradient_elution_lkm_solver.m
│   ├── schemes/
│   ├── flux_limiters/
│   ├── models/
│   ├── analysis/
│   └── plotting/
├── papers/
├── figures/
└── examples/
```

## Quick Start

From MATLAB:

```matlab
cd matlab
results = run_gradient_elution_lkm();
```

or from the `examples` folder:

```matlab
example_single_component
```

## Main Files

- `run_gradient_elution_lkm.m`: main driver script/function
- `gradient_elution_lkm_solver.m`: ODE right-hand side for the semi-discrete LKM system
- `schemes/fv_koren_tvd.m`: Koren high-resolution TVD finite-volume scheme
- `schemes/fv_backward_difference.m`: first-order backward finite-volume scheme
- `models/langmuir_isotherm.m`: nonlinear Langmuir equilibrium model
- `models/lss_parameter_model.m`: solvent-strength-dependent parameter model
- `analysis/compute_temporal_moments.m`: outlet temporal moment calculations

## Citation

If you use this code, please cite the associated publications listed in `CITATION.cff`.
