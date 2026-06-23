`timescale 1ns / 1ps

module oscilloscope(
    input clk,             // Clock signal
    input rst,             // Reset signal
    output pclk,           // Pixel clock
    output hsync,          // Horizontal sync signal
    output vsync,          // Vertical sync signal
    output [3:0] red,      // Red color signal
    output [3:0] green,    // Green color signal
    output [3:0] blue,     // Blue color signal
    output convstb,        // Convert Start signal for ADC
    input busy,            // Busy signal from ADC
    output csb,            // Chip Select signal for ADC
    output rdb,            // Read Data signal for ADC
    input [7:0] data,      // Data input from ADC
    input switch           // Switch for controlling certain behavior
);

    // Internal Registers
    reg [13:0] ctrP;              // Pixel clock counter
    reg [13:0] ctrH;              // Horizontal sync counter
    reg [18:0] ctrV;              // Vertical sync counter
    reg [8:0] timing_counter;     // Timing counter for ADC
    reg [9:0] buffercounter;      // Buffer index counter
    reg [7:0] buffer[639:0];      // Data buffer for VGA (640 elements)

    // Assignments for outputs
    assign pclk = (ctrP < 14'd2) ? 1'b1 : 1'b0;  // Pixel clock (high for 2 cycles)
    assign hsync = (ctrH < 14'd96) ? 1'b0 : 1'b1; // Horizontal sync pulse
    assign vsync = (ctrV < 19'd2) ? 1'b0 : 1'b1;  // Vertical sync pulse

    // ADC Control Signals
    assign convstb = (timing_counter <= 9'd2) ? 1'b0 : 1'b1;  // Convert Start signal
    assign csb = (timing_counter > 9'd449 && timing_counter <= 9'd494) ? 1'b0 : 1'b1; // Chip Select
    assign rdb = (timing_counter > 9'd449 && timing_counter <= 9'd484) ? 1'b0 : 1'b1; // Read Data

    // Pixel Color Generation (Green Pixel for Buffer Matches)
    assign green = (((buffer[ctrH - 14'd144] + 10'd31) == ctrV) && (ctrH <= 14'd784)) ? 4'b1111 : 4'b0000;

    // Pixel Clock Counter
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            ctrP <= 14'd0;  // Reset pixel clock counter
        end else if (ctrP < 14'd3) begin
            ctrP <= ctrP + 14'd1;  // Increment counter for 4 counts
        end else begin
            ctrP <= 14'd0;  // Reset counter after 4 counts
        end
    end

    // Horizontal and Vertical Sync Counters
    always @(posedge pclk or negedge rst) begin
        if (!rst) begin
            ctrH <= 14'd0;  // Reset horizontal counter
            ctrV <= 19'd0;  // Reset vertical counter
        end else if (ctrH < 14'd799) begin
            ctrH <= ctrH + 14'd1;  // Increment horizontal counter
        end else begin
            ctrH <= 14'd0;  // Reset horizontal counter
            if (ctrV >= 19'd520) begin
                ctrV <= 19'd0;  // Reset vertical counter if max lines reached
            end else begin
                ctrV <= ctrV + 19'd1;  // Increment vertical counter
            end
        end
    end

    // Timing Counter and Buffer Management
        always @(posedge clk or negedge rst) begin
        if (!rst) begin
            timing_counter <= 9'd0;  // Reset timing counter
            buffercounter <= 10'd0;  // Reset buffer counter
        end else begin
            if (timing_counter < 9'd499) begin
                // Check when both csb and rdb are low (i.e., both = 0)
                if (timing_counter == 9'd451) begin   
                    if (buffercounter < 10'd639) begin
                        buffercounter <= buffercounter + 10'd1;  // Increment buffer index
                    end else begin
                        buffercounter <= 10'd0;  // Wrap buffer index
                    end
                    buffer[buffercounter] <= data;  // Store ADC data into buffer
                end
                timing_counter <= timing_counter + 9'd1;  // Increment timing counter
            end else begin
                timing_counter <= 9'd0;  // Reset timing counter
            end
        end
    end

endmodule

