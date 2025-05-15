///////////////////////////////////////////////////////////////////////////////
// FIFO Coverage Class: Functional coverage model for FIFO verification
// - Covers all key FIFO states and transitions
// - Includes critical cross-coverage between control signals and status flags
// - Filters invalid combinations with ignore_bins
///////////////////////////////////////////////////////////////////////////////

package Coverage_Pkg;
import Shared_Pkg::*;
import Transaction_Pkg::*;

class FIFO_coverage;
    // Transaction handle for coverage sampling
    FIFO_transaction F_cvg_txn = new;

    covergroup CodeCov;
        //////////////////////////// Control Signals ///////////////////////////
        rst_n_cp: coverpoint F_cvg_txn.rst_n {
            bins inactive = {1}; 
            bins active   = {0};
            bins inactive_active_trans = (1 => 0);
            bins active_inactive_trans = (0 => 1);
        }
        
        wr_en_cp: coverpoint F_cvg_txn.wr_en { bins high = {1}; bins low = {0}; }
        rd_en_cp: coverpoint F_cvg_txn.rd_en { bins high = {1}; bins low = {0}; }

        ////////////////////////// Status Indicators ///////////////////////////
        wr_ack_cp: coverpoint F_cvg_txn.wr_ack {
            bins high = {1}; bins low = {0};
            bins high_low_trans = (1 => 0);
            bins low_high_trans = (0 => 1);
        }

        full_cp:  coverpoint F_cvg_txn.full {
            bins high = {1}; bins low = {0};
            bins high_low_trans = (1 => 0);
            bins low_high_trans = (0 => 1);
        }

        empty_cp: coverpoint F_cvg_txn.empty {
            bins high = {1}; bins low = {0};
            bins high_low_trans = (1 => 0);
            bins low_high_trans = (0 => 1);
        }

        almostfull_cp:  coverpoint F_cvg_txn.almostfull {
            bins high = {1}; bins low = {0};
            bins high_low_trans = (1 => 0);
            bins low_high_trans = (0 => 1);
        }

        almostempty_cp: coverpoint F_cvg_txn.almostempty {
            bins high = {1}; bins low = {0};
            bins high_low_trans = (1 => 0);
            bins low_high_trans = (0 => 1);
        }

        ///////////////////////// Error Conditions ////////////////////////////
        overflow_cp: coverpoint F_cvg_txn.overflow {
            bins high = {1}; bins low = {0};
            bins high_low_trans = (1 => 0);
            bins low_high_trans = (0 => 1);
        }

        underflow_cp: coverpoint F_cvg_txn.underflow {
            bins high = {1}; bins low = {0};
            bins high_low_trans = (1 => 0);
            bins low_high_trans = (0 => 1);
        }

        ////////////////////////// Cross Coverage //////////////////////////////
        // Reset behavior verification
        rst_n_full:        cross rst_n_cp, full_cp {
            bins rst_n_full = binsof(rst_n_cp.active) && binsof(full_cp.low);
            option.cross_auto_bin_max = 0;
        }
        
        rst_n_empty:       cross rst_n_cp, empty_cp {
            bins rst_n_empty = binsof(rst_n_cp.active) && binsof(empty_cp.high);
            option.cross_auto_bin_max = 0;
        }

        // Write operation coverage
        wr_en_wr_ack_cross: cross wr_en_cp, wr_ack_cp {
            bins wr_en_wr_ack = binsof(wr_ack_cp.high) && binsof(wr_en_cp.high);
            option.cross_auto_bin_max = 0;
        }

        // Read operation coverage
        rd_en_empty_cross: cross rd_en_cp, empty_cp {
            bins empty_rd_en = binsof(empty_cp.high) && binsof(rd_en_cp.high);
            option.cross_auto_bin_max = 0;
        }

        // 3-way crosses with invalid combination filtering
        wr_rd_ack_cross: cross wr_en_cp, rd_en_cp, wr_ack_cp {
            ignore_bins wr_low_ack_high1 = binsof(wr_ack_cp.high) && binsof(wr_en_cp.low);
            ignore_bins wr_low_ack_high2 = binsof(wr_ack_cp.low_high_trans) && binsof(wr_en_cp.low);
        }

        wr_rd_overflow_cross: cross wr_en_cp, rd_en_cp, overflow_cp {
            ignore_bins wr_low_overflow_high1 = binsof(overflow_cp.high) && binsof(wr_en_cp.low);
            ignore_bins wr_low_overflow_high2 = binsof(overflow_cp.low_high_trans) && binsof(wr_en_cp.low);
        }
    endgroup

    // Constructor - instantiates coverage group
    function new();
        CodeCov = new;
    endfunction

    // Samples transaction for coverage
    function void sample(FIFO_transaction take_tr);
        F_cvg_txn = take_tr;
        CodeCov.sample();
    endfunction
endclass
endpackage