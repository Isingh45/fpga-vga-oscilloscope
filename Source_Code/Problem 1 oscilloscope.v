`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 11:13:15 AM
// Design Name: 
// Module Name: oscilloscope
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

module oscilloscope(
    input clk,
    input rst,
    output pclk,
    output hsync,
    output vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue,
    output convstb,
    input busy,
    output csb,
    output rdb
);

    // Counter registers
    reg [13:0] ctrP; // Pixel clock counter
    reg [13:0] ctrH; // Horizontal counter
    reg [18:0] ctrV; // Vertical counter
    reg [8:0] timing_counter; // Timing counter for DAC
    reg [7:0] buffer[640:0]; // Data buffer (640 pixels)

    // Timing signal assignments
    assign pclk = (ctrP < 14'd2) ? 1'b1 : 1'b0; // Pixel clock
    assign hsync = (ctrH < 14'd96) ? 1'b0 : 1'b1; // Horizontal sync pulse
    assign vsync = (ctrV < 19'd2) ? 1'b0 : 1'b1;  // Vertical sync pulse

    // DAC timing signals
    assign convstb = (timing_counter <= 9'd2) ? 1'b0 : 1'b1; // Convert start
    assign csb = (timing_counter > 9'd454 && timing_counter <= 9'd494) ? 1'b0 : 1'b1; // Chip select
    assign rdb = (timing_counter > 9'd454 && timing_counter <= 9'd484) ? 1'b0 : 1'b1; // Read data

    // Pixel clock generation
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            ctrP <= 14'd0;
        end else if (ctrP < 14'd3) begin
            ctrP <= ctrP + 14'd1;
        end else begin
            ctrP <= 14'd0;
        end
    end

    // Horizontal and vertical sync generation
    always @(posedge pclk or negedge rst) begin
        if (!rst) begin
            ctrH <= 14'd0;
            ctrV <= 19'd0;
        end else if (ctrH < 14'd799) begin
            ctrH <= ctrH + 14'd1;
        end else begin
            ctrH <= 14'd0;
            if (ctrV >= 19'd520) begin
                ctrV <= 19'd0;
            end else begin
                ctrV <= ctrV + 19'd1;
            end
        end
    end

    // DAC timing control
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            timing_counter <= 9'd0;
        end else if (timing_counter < 9'd499) begin
            timing_counter <= timing_counter + 9'd1;
        end else begin
            timing_counter <= 9'd0;
        end
    end

endmodule