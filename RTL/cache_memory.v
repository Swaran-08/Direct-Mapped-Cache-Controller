 `timescale 1ns / 1ps

module cache_memory
#(
    parameter DATA_WIDTH  = 8,
    parameter TAG_WIDTH   = 5,
    parameter CACHE_LINES = 4
)
(
    input clk,
    input reset,
    input write_enable,
    input [1:0] index,
    input [4:0] tag_in,
    input offset,

    // Write Data (2-byte block)
    input [7:0] data_byte0,
    input [7:0] data_byte1,

    output reg [4:0] tag_out,
    output reg [7:0] data_out,
    output reg valid_out
);
    reg [7:0] data_array [0:CACHE_LINES-1][0:1];
    reg [TAG_WIDTH-1:0] tag_array [0:CACHE_LINES-1];
    reg valid_array [0:CACHE_LINES-1];

    integer i;
    
    always @(posedge clk)
    begin
        if(reset)
        begin
            for(i=0;i<CACHE_LINES;i=i+1)
            begin
                data_array[i][0] <= 8'd0;
                data_array[i][1] <= 8'd0;
                tag_array[i]     <= 5'd0;
                valid_array[i]   <= 1'b0;
            end
        end

        else if(write_enable)
        begin
            // Overwrite the selected cache line
            data_array[index][0] <= data_byte0;
            data_array[index][1] <= data_byte1;
            tag_array[index] <= tag_in;
            valid_array[index] <= 1'b1;
        end
    end

    always @(*)
    begin
   tag_out   = tag_array[index];
        valid_out = valid_array[index];

        if(offset)
            data_out = data_array[index][1];
        else
            data_out = data_array[index][0];
    end
endmodule