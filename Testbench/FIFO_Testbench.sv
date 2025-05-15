///////////////////////////////////////////////////////////////////////////////
// FIFO Testbench: Top-level verification module
// - Generates constrained random stimulus
// - Verifies reset behavior
// - Coordinates verification components
// - Runs 10,000 random test cycles
///////////////////////////////////////////////////////////////////////////////
module FIFO_TB(FIFO_interface.Testbench FIFO_IF);
import Shared_Pkg::*;
import Transaction_Pkg::*;
import Coverage_Pkg::*;
import Scoreboard_Pkg::*;

    // Verification Components
    FIFO_transaction MyTransaction =new;
    FIFO_coverage MyCoverage = new;
    FIFO_scoreboard MyScoreboard = new;
    
    initial begin
        chk_rst();
        repeat(10_000)begin
            assert(MyTransaction.randomize());
                FIFO_IF.data_in = MyTransaction.data_in;
                FIFO_IF.rst_n = MyTransaction.rst_n;
                FIFO_IF.rd_en = MyTransaction.rd_en;
                FIFO_IF.wr_en = MyTransaction.wr_en;
            @(negedge FIFO_IF.clk);
        end
        test_finished = 1;
        @(negedge FIFO_IF.clk);
        $stop;
     end

    task chk_rst();
        FIFO_IF.rst_n = 0; FIFO_IF.data_in = 0; FIFO_IF.rd_en = 0; FIFO_IF.wr_en = 0;
        repeat(5) @(negedge FIFO_IF.clk);
        FIFO_IF.rst_n = 1;
    endtask

endmodule