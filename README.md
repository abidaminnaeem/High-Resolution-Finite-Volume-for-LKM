# High-Resolution Finite Volume for LKM

A MATLAB framework for the numerical simulation of nonlinear and non-equilibrium gradient elution chromatography using high-resolution finite volume methods (HR-FVM) and Lumped Kinetic Models (LKM).

---

## Overview

This repository provides a modular MATLAB implementation for solving nonlinear chromatographic transport models arising in liquid chromatography. The framework is based on:

* Lumped Kinetic Models (LKM)
* Gradient elution chromatography
* Nonlinear Langmuir adsorption isotherms
* High-resolution finite volume methods (HR-FVM)
* TVD flux limiting schemes
* Koren limiter discretization
* Semi-discrete PDE formulations
* Temporal moment analysis

The implementation is designed for reproducible scientific computing research in chromatographic process modeling and numerical PDEs.

---

## Features

* High-resolution finite volume schemes
* Koren TVD flux limiter implementation
* Nonlinear Langmuir adsorption modeling
* Linear Solvent Strength (LSS) theory
* Gradient elution chromatography simulation
* Axial dispersion and mass transfer modeling
* Single and multicomponent simulations
* Temporal moment analysis
* Modular MATLAB implementation
* Reproducible computational framework

---

## Repository Structure

```text
High-Resolution-Finite-Volume-for-LKM/
│
├── README.md
├── LICENSE
├── CITATION.cff
│
├── matlab/
│   │
│   ├── run_gradient_elution_lkm.m
│   ├── gradient_elution_lkm_solver.m
│   │
│   ├── schemes/
│   │   ├── fv_koren_tvd.m
│   │   ├── fv_backward_difference.m
│   │   └── fv_leveque_tvd.m
│   │
│   ├── flux_limiters/
│   │   └── koren_flux_limiter.m
│   │
│   ├── models/
│   │   ├── langmuir_isotherm.m
│   │   └── lss_parameter_model.m
│   │
│   ├── analysis/
│   │   └── compute_temporal_moments.m
│   │
│   └── plotting/
│       ├── plot_single_component.m
│       ├── plot_two_component.m
│       └── plot_temporal_moments.m
│
├── papers/
└── examples/
```

---

## Mathematical Model

The governing nonlinear lumped kinetic model can be written as:

$$
\frac{\partial c_i}{\partial t}

* u \frac{\partial c_i}{\partial z}
  =
  D_{z,i}\frac{\partial^2 c_i}{\partial z^2}

-

F K_{L,i}(q_i^* - q_i)
$$

with adsorption kinetics:

$$
\frac{\partial q_i}{\partial t}
===============================

K_{L,i}(q_i^* - q_i)
$$

and nonlinear Langmuir equilibrium relation:

$$
q_i^* =
\frac{K_{H,i} c_i}
{1 + \sum_j b_j c_j}
$$

The framework incorporates Linear Solvent Strength (LSS) theory for solvent-dependent model parameters.

---

## Numerical Method

The numerical framework uses:

* Semi-discrete finite volume methods
* High-resolution TVD discretization
* Koren flux limiter
* Backward difference discretization
* ODE45 time integration
* Conservative flux formulations

The method is designed to:

* reduce numerical diffusion,
* avoid spurious oscillations,
* accurately capture sharp chromatographic fronts,
* preserve numerical stability.

---

## Example Applications

This repository can be used for:

* Single-component chromatography
* Multicomponent chromatography
* Gradient elution analysis
* Core-shell particle studies
* Temporal moment calculations
* Mass transfer studies
* Dispersion analysis
* Nonlinear adsorption analysis

---

## Running the Code

Run the main simulation script:

```matlab
run_gradient_elution_lkm
```

Example scripts are provided in:

```text
examples/
```

---

## Requirements

* MATLAB R2018a or newer
* MATLAB ODE Suite

---

## Future Extensions

Potential future developments include:

* GPU acceleration
* Adaptive mesh refinement
* Bayesian parameter estimation
* Data assimilation methods
* DeepONet/FNO surrogate modeling
* Neural operator extensions
* Physics-informed machine learning
* Multi-column chromatography systems

---

## Citation

If you use this repository in your research, please cite the associated publications.

### Paper 1

```bibtex
@article{rehman2021numerical,
  title={Numerical approximation of nonlinear and non-equilibrium model of gradient elution chromatography},
  author={Rehman, Nazia and Abid, Muhammad and Qamar, Shamsul},
  journal={Journal of Liquid Chromatography \& Related Technologies},
  volume={44},
  number={7-8},
  pages={382--394},
  year={2021},
  publisher={Taylor \& Francis}
}
```

### Paper 2

```bibtex
@article{ahmad2022novel,
  title={A Novel Numerical Treatment of Nonlinear and Nonequilibrium Model of Gradient Elution Chromatography considering Core-Shell Particles in the Column},
  author={Ahmad, Abdulaziz Garba and Kaabar, Mohammed K. A. and Rashid, Saima and Abid, Muhammad},
  journal={Mathematical Problems in Engineering},
  volume={2022},
  pages={1--14},
  year={2022},
  publisher={Hindawi}
}
```
