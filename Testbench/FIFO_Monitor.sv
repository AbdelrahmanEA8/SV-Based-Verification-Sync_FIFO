///////////////////////////////////////////////////////////////////////////////
// FIFO Monitor: Observes DUT signals and coordinates verification components
// - Samples DUT inputs/outputs on clock edges
// - Drives coverage collection
// - Coordinates scoreboard checking
// - Provides test summary statistics
///////////////////////////////////////////////////////////////////////////////
module Monitor(FIFO_interface.MONITOR FIFO_IF);
import Transaction_Pkg::*;
import Shared_Pkg::*;
import Coverage_Pkg::*;
import Scoreboard_Pkg::*;

    // Verification Components
    FIFO_transaction MyTransaction = new();  // Transaction container
    FIFO_coverage   MyCoverage = new();  // Coverage collector
    FIFO_scoreboard  MyScoreboard = new();  // Scoreboard checker

    initial begin
        forever begin
            // Sample on negative clock edge for stable signals
            @(posedge FIFO_IF.clk);
            
            // Capture all DUT signals
            MyTransaction.rst_n       = FIFO_IF.rst_n;
            MyTransaction.wr_en       = FIFO_IF.wr_en;
            MyTransaction.rd_en       = FIFO_IF.rd_en;
            MyTransaction.data_in     = FIFO_IF.data_in;

            @(negedge FIFO_IF.clk);
            MyTransaction.data_out    = FIFO_IF.data_out;
            MyTransaction.wr_ack      = FIFO_IF.wr_ack;
            MyTransaction.overflow    = FIFO_IF.overflow;
            MyTransaction.full        = FIFO_IF.full;
            MyTransaction.empty       = FIFO_IF.empty;
            MyTransaction.almostfull  = FIFO_IF.almostfull;
            MyTransaction.almostempty = FIFO_IF.almostempty;
            MyTransaction.underflow  = FIFO_IF.underflow;



            fork
                // Collect functional coverage
                begin
                    MyCoverage.sample(MyTransaction);
                end

                // Perform scoreboard checking
                begin
                    MyScoreboard.check_data(MyTransaction);
                end
            join

            // Test termination condition
            if (test_finished) begin
                $display("\n**************************************************");
                $display("************** TEST SUMMARY ***********************");
                $display("**************************************************");
                $display("** Correct Transactions: %0d", correct_count);
                $display("** Error Transactions:   %0d", error_count);
                $display("**************************************************");
                $stop;
            end
        end
    end
endmodule