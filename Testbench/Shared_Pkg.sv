///////////////////////////////////////////////////////////////////////////////
// Shared Package: Global parameters and variables for FIFO verification
// - Contains design configuration parameters
// - Defines verification controls and metrics
// - Shared across all testbench components
///////////////////////////////////////////////////////////////////////////////
package Shared_Pkg;
    //=============================================================================
    // Design Configuration
    //=============================================================================
    parameter FIFO_WIDTH = 16;          // Data width in bits
    parameter FIFO_DEPTH = 8;           // Number of FIFO entries
    localparam max_fifo_addr = $clog2(FIFO_DEPTH);  // Address width calculation

    bit test_finished = 0;              // Test termination flag
    
    int error_count = 0;          
    int correct_count = 0;              

    // Randomization Weights
    int RD_EN_ON_DIST = 30;             // Default read enable
    int WR_EN_ON_DIST = 70;             // Default write enable
    int rst_on = 2;                     // Reset assertion
    int rst_off = 98;                   // Normal operation
endpackage