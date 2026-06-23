`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 11:41:13 AM
// Design Name: 
// Module Name: module oscilloscope_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module testbench();
    reg rst,clk, busy;
    wire gclk;
    oscilloscope gc0(clk,rst, pclk, hsync, vsync, red, green, blue, convstb, busy, csb, rdb);
   
    always begin
        #5 clk = ~clk; // trigger the clock every 10 ticks
    end
   
    initial begin
        rst = 1'b0; // reset the system
        clk = 1'b0; // set the initial value of the clock
//        busy = 1'b1;
        #15
//        busy = 1'b0;
        rst = 1'b1; // start the state machine
        #4000000000; // let it run for 400 million time ticks
      end
    // when a rising edge is detected on clock, print the time and the
    // associated values of clk and gclk.
    always @(posedge clk) begin
        $display("convstb=%b time=%d",convstb,$time);
    end
endmodule