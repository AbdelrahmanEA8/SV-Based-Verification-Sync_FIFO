vlib work
vlog -f file.txt +define+SIM +cover
vsim -voptargs=+acc work.TOP -cover
add wave * 
add wave -position 1 -color white sim:/TOP/FIFO_IF/clk 
add wave -position 2 -radix unsigned sim:/TOP/FIFO_IF/rst_n 
add wave -position 3 -radix unsigned sim:/TOP/FIFO_IF/wr_en 
add wave -position 4 -radix unsigned sim:/TOP/FIFO_IF/rd_en 
add wave -position 5 -radix hexadecimal sim:/TOP/FIFO_IF/data_in 
add wave -position 6 -color yellow -radix hexadecimal sim:/TOP/FIFO_IF/data_out 
add wave -position 7 -color Orchid -radix hexadecimal sim:/TOP/monitor/MyScoreboard.data_out_ref 
add wave -position 8 -color yellow -radix unsigned sim:/TOP/FIFO_IF/wr_ack 
add wave -position 9 -color Orchid -radix unsigned sim:/TOP/monitor/MyScoreboard.wr_ack_ref 
add wave -position 12 -color yellow -radix unsigned sim:/TOP/FIFO_IF/full 
add wave -position 13 -color Orchid -radix unsigned sim:/TOP/monitor/MyScoreboard.full_ref 
add wave -position 14 -color yellow -radix unsigned sim:/TOP/FIFO_IF/empty 
add wave -position 15 -color Orchid -radix unsigned sim:/TOP/monitor/MyScoreboard.empty_ref 
add wave -position 16 -color yellow -radix unsigned sim:/TOP/FIFO_IF/almostfull 
add wave -position 17 -color Orchid -radix unsigned sim:/TOP/monitor/MyScoreboard.almostfull_ref 
add wave -position 18 -color yellow -radix unsigned sim:/TOP/FIFO_IF/almostempty 
add wave -position 19 -color Orchid -radix unsigned sim:/TOP/monitor/MyScoreboard.almostempty_ref 
add wave -position 20 -color yellow -radix unsigned sim:/TOP/FIFO_IF/overflow 
add wave -position 21 -color Orchid -radix unsigned sim:/TOP/monitor/MyScoreboard.overflow_ref 
add wave -position 22 -color yellow -radix unsigned sim:/TOP/FIFO_IF/underflow 
add wave -position 23 -color Orchid -radix unsigned sim:/TOP/monitor/MyScoreboard.underflow_ref 
add wave -position 24 -radix unsigned sim:/TOP/DUT/count
add wave -position 25 -radix unsigned sim:/Shared_Pkg::error_count 
add wave -position 26 -radix unsigned sim:/Shared_Pkg::correct_count
run -all
coverage report -output report.txt -srcfile=FIFO.sv -detail -cvg -codeAll
coverage report -detail -cvg -directive -comments -output fcover_report.txt {}