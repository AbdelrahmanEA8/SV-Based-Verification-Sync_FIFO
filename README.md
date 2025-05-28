# SV-Based-Verification-Sync_FIFO

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

### Excutive Summary

![Excutive Summary](./Docs/Executive%20Summary.png)

### Code Coverage

![Code Coverage](./Docs/Code%20Coverage%20Analysis.png)

### Functional Coverage

![Functional Coverage](./Docs/Functional%20Coverage%20Analysis.png)

## Assertions

![Assertions Coverage](./Docs/Assertion%20Coverage.png)

### Verification Conclusion

![Verification Conclusion](./Docs/Verification%20Conclusion.png)

