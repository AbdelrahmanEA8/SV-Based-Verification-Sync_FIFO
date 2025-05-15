# SV_based_verification_Sync_FIFO

SystemVerilog-based functional verification project for a **Synchronous FIFO** design using UVM-inspired techniques and industry best practices. This project demonstrates constrained-random stimulus generation, assertion-based verification, and functional + code coverage closure.

## Overview

This verification environment validates a parameterized synchronous FIFO design using:
- Constrained random stimulus
- Reference (golden) model comparison
- SystemVerilog Assertions (SVA)
- Functional and code coverage
- Scoreboard-based checks
- Functional coverage points tied to verification plan

## Verification Features

- **Verification Methodology**: SystemVerilog + UVM-style architecture  
- **Stimulus Generation**: Constrained Random  
- **Checker**: Scoreboard with reference model  
- **Assertions**: Inline & interface-bound SVA  
- **Coverage**:
  - Code Coverage (Statement, Branch, Toggle)
  - Functional Coverage

## Project Structure
```text SV_based_verification_Sync_FIFO/
├── docs/                 # Coverage and Assertion reports (images)
├── rtl/                  # FIFO RTL design files
├── tb/                   # Testbench components (pkg, interfaces, modules)
├── sim/                  # Do files, logs, waveforms
├── scripts/              # Compilation and run scripts
├── README.md
```
## Coverage Results

### Code Coverage

![Code Coverage](docs/code_coverage.png)

### Functional Coverage

![Functional Coverage](docs/functional_coverage.png)

## Assertions

SystemVerilog assertions were used to validate protocol behavior and design correctness. Key assertions include:
- FIFO full/empty behavior
- Read/write enable control
- Reset behavior

### Assertion Dashboard

![Assertions](docs/assertion_dashboard.png)

## How to Run

1. Clone the repository  
   ```bash
   git clone https://github.com/AbdelrahmanEA8/SV_based_verification_Sync_FIFO.git
   cd SV_based_verification_Sync_FIFO
