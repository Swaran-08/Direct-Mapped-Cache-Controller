 `timescale 1ns / 1ps

module cache_controller(

    input clk,
    input reset,

    // CPU Interface
    input        cpu_read,
    input [7:0]  cpu_address,

    output reg [7:0] cpu_data,
    output ready,
    output hit,
    output miss,

 
    output memory_read_enable,
    output cache_write_enable

);
 
wire [4:0] tag;
wire [1:0] index;
wire offset;

// Cache Outputs
wire [4:0] cache_tag;
wire [7:0] cache_data;
wire cache_valid;

// FSM Outputs
wire cache_write_enable ;
wire memory_read_enable ;

// Main Memory Output
wire [15:0] block_data;

// Data to Cache
wire [7:0] data_byte0;
wire [7:0] data_byte1;

assign data_byte0 = block_data[7:0];
assign data_byte1 = block_data[15:8];
 
address_decoder DECODER(

    .address(cpu_address),
    .tag(tag),
    .index(index),
    .offset(offset)

);
 
cache_memory CACHE(

    .clk(clk),
    .reset(reset),

    .write_enable(cache_write_enable ),

    .index(index),
    .tag_in(tag),
    .offset(offset),

    .data_byte0(data_byte0),
    .data_byte1(data_byte1),

    .tag_out(cache_tag),
    .data_out(cache_data),
    .valid_out(cache_valid)

);
 
hit_miss_detector HITMISS(

    .tag_in(tag),
    .tag_out(cache_tag),
    .valid_out(cache_valid),

    .hit(hit),
    .miss(miss)

);
 
main_memory MEMORY(

    .clk(clk),

    .mem_read(memory_read_enable),
    .mem_write(1'b0),

    .address(cpu_address),
    .data_in(8'd0),

    .block_data(block_data)

);
 
fsm_controller FSM(

    .clk(clk),
    .reset(reset),

    .cpu_read(cpu_read),

    .hit(hit),
    .miss(miss),

    .cache_read_enable(),
    .cache_write_enable(cache_write_enable ),
    .memory_read_enable(memory_read_enable ),

    .ready(ready),

    .state()

);
 

always @(*)
begin
    if(hit)
    begin
        cpu_data = cache_data;
    end
    else
    begin
        if(offset)
            cpu_data = block_data[15:8];
        else
            cpu_data = block_data[7:0];
    end
end

endmodule