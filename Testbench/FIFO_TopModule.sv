////////////////////////////////////////////////////////////////////////////////
// Module       : TOP
// Author       : Abdelrahman Essam Fahmy
// Date         : 5/10/2024
// Description  : Testbench top-level for FIFO verification
// Components   :
//   - Clock generator (500MHz)
//   - DUT (FIFO)
//   - Testbench driver
//   - Golden reference model
//   - Verification monitor
////////////////////////////////////////////////////////////////////////////////

module TOP();
    // Clock generation (500MHz, 2ns period)
    logic clk;
    initial begin
        clk = 0;
        forever #1 clk = ~clk;  // 1ns half-period
    end

    // Main FIFO interface with clock
    FIFO_interface FIFO_IF(clk);

    // Device Under Test - actual RTL implementation
    FIFO DUT (.FIFO_IF(FIFO_IF.DUT));

    // Testbench - stimulus generator and checks
    FIFO_TB tb (.FIFO_IF(FIFO_IF.Testbench));

    // Golden Model - reference implementation
    // Golden_Model golden_model (.FIFO_IF(FIFO_IF.golden_model));

    // Monitor - verification scoreboarding
    Monitor monitor (.FIFO_IF(FIFO_IF.MONITOR));
endmodule