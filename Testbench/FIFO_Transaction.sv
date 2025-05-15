///////////////////////////////////////////////////////////////////////////////
// FIFO Transaction Class: Models DUT interface and reference model for verification
// - Configurable read/write probability distributions
// - Supports constrained randomization of all input signals
// - Includes golden model outputs for scoreboarding
///////////////////////////////////////////////////////////////////////////////\

package Transaction_Pkg;
import Shared_Pkg::*;

class FIFO_transaction;
    //------------------------- Design Signals --------------------------------                        
    rand logic [FIFO_WIDTH-1:0] data_in;
    rand logic rst_n;                   // Active-low reset
    rand logic wr_en;                   // Write enable
    rand logic rd_en;                   // Read enable
    
    logic [FIFO_WIDTH-1:0] data_out;  // Read data port
    logic wr_ack;                     // Write success indicator
    logic overflow, underflow;        // Error conditions
    logic full, empty;                // Capacity status
    logic almostfull, almostempty;    // Early warning indicators  

    // Randomization Control (default weights)
    integer RD_EN_ON_DIST = 30;  // 30% read
    integer WR_EN_ON_DIST = 70;  // 70% write
    integer rst_on = 5;          // 5% reset
    integer rst_off = 95;        // 95% normal operation

    // Constraints - control signal activation frequencies
    constraint rst_constraints { rst_n dist {1'b0 := rst_on, 1'b1 := rst_off}; }
    constraint wr_constraints { wr_en dist {1'b1 := WR_EN_ON_DIST, 1'b0 := (100-WR_EN_ON_DIST)}; }
    constraint rd_constraints { rd_en dist {1'b1 := RD_EN_ON_DIST, 1'b0 := (100-RD_EN_ON_DIST)}; }

    // Constructor - customize enable probabilities
    function new(integer RD_EN_ON_DIST_1=30, WR_EN_ON_DIST_1=70);
        RD_EN_ON_DIST = RD_EN_ON_DIST_1;
        WR_EN_ON_DIST = WR_EN_ON_DIST_1;
    endfunction
    
endclass
endpackage