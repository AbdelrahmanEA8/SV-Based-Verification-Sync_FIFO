///////////////////////////////////////////////////////////////////////////////
// FIFO Scoreboard: Golden reference model and result checker
// - Compares DUT outputs against expected reference values
// - Tracks correct/error counts for verification metrics
// - Provides detailed error reporting on mismatches
///////////////////////////////////////////////////////////////////////////////

package Scoreboard_Pkg;
import Shared_Pkg::*;
import Transaction_Pkg::*;

class FIFO_scoreboard;
    // Golden Model Outputs
    logic [FIFO_WIDTH-1:0] data_out_ref;  // Expected data output
    logic wr_ack_ref, overflow_ref;        // Expected write responses
    logic full_ref, empty_ref;             // Expected capacity flags
    logic almostfull_ref, almostempty_ref; // Expected threshold flags
    logic underflow_ref;                   // Expected read error

    // FIFO memory (Stack)
    logic [FIFO_WIDTH-1:0] MyFifo [$];
    
    FIFO_transaction trans = new();  // Transaction object for comparisons

    // Compares DUT outputs against golden model
    task check_data(FIFO_transaction MyTransaction);
    reference_model(MyTransaction);
        if (MyTransaction.data_out == data_out_ref &&
            MyTransaction.wr_ack == wr_ack_ref &&
            MyTransaction.overflow == overflow_ref &&
            MyTransaction.full == full_ref &&
            MyTransaction.empty == empty_ref &&
            MyTransaction.almostfull == almostfull_ref &&
            MyTransaction.almostempty == almostempty_ref &&
            MyTransaction.underflow == underflow_ref) 
        begin
            correct_count++;
        end
        else begin
            // Error reporting for debugging
            $display("%t ERROR: DUT vs Reference Mismatch", $time);
            $display("Data:     DUT=%h  REF=%h", MyTransaction.data_out, data_out_ref);
            $display("wr_ack:   DUT=%h  REF=%h", MyTransaction.wr_ack, wr_ack_ref);
            $display("overflow: DUT=%h  REF=%h", MyTransaction.overflow, overflow_ref);
            $display("full:     DUT=%h  REF=%h", MyTransaction.full, full_ref);
            $display("empty:    DUT=%h  REF=%h", MyTransaction.empty, empty_ref);
            $display("almostf:  DUT=%h  REF=%h", MyTransaction.almostfull, almostfull_ref);
            $display("almoste:  DUT=%h  REF=%h", MyTransaction.almostempty, almostempty_ref);
            $display("underflow:DUT=%h  REF=%h", MyTransaction.underflow, underflow_ref);
            $display("==================================================");
            error_count++;
        end
    endtask

    // golden model reference values
    task reference_model(FIFO_transaction MyTransaction);
        if (!MyTransaction.rst_n) begin
            MyFifo.delete();
            data_out_ref = 0;
            overflow_ref = 0; wr_ack_ref = 0;
            full_ref = 0; empty_ref = 1;
            almostfull_ref = 0; almostempty_ref = 0;
            underflow_ref = 0;
        end
        else begin
        // Write operation
            if (MyTransaction.wr_en && !full_ref) begin
                MyFifo.push_back(MyTransaction.data_in);
                wr_ack_ref = 1;
                overflow_ref = 0;
            end
            else begin
                wr_ack_ref = 0;
                if(full_ref && MyTransaction.wr_en)
                    overflow_ref = 1;
                else
                    overflow_ref = 0;
            end
        // Read operation
            if (MyTransaction.rd_en && !empty_ref) begin
                data_out_ref = MyFifo.pop_front();
                underflow_ref = 0;
            end
            else begin
                if(empty_ref && MyTransaction.rd_en)
                    underflow_ref = 1;
                else
                    underflow_ref = 0;
            end
        end 
    
        full_ref = (MyFifo.size() == FIFO_DEPTH)? 1 : 0;  
        empty_ref = (MyFifo.size() == 0)? 1 : 0; 
        almostfull_ref = (MyFifo.size() == FIFO_DEPTH-1)? 1 : 0;
        almostempty_ref = (MyFifo.size() == 1)? 1 : 0; 

    endtask
endclass
endpackage