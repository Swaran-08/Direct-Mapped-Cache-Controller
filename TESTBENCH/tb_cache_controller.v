 `timescale 1ns / 1ps

module tb_cache_controller;

reg clk;
reg reset;
reg cpu_read;
reg [7:0] cpu_address;

wire [7:0] cpu_data;
wire ready;
wire hit;
wire miss;

// Debug Outputs
wire memory_read_enable;
wire cache_write_enable;

cache_controller DUT
(
    .clk(clk),
    .reset(reset),

    .cpu_read(cpu_read),
    .cpu_address(cpu_address),

    .cpu_data(cpu_data),

    .ready(ready),
    .hit(hit),
    .miss(miss),

    .memory_read_enable(memory_read_enable),
    .cache_write_enable(cache_write_enable)
);

// Clock Generation
initial
    clk = 0;

always #5 clk = ~clk;

// Monitor
initial
begin
    $monitor(
"Time=%0t | State=%0d | Addr=%0d | Tag=%b | Index=%b | Offset=%b | Data=%0d | Hit=%b | Miss=%b | Ready=%b | MemRead=%b | CacheWrite=%b | CacheTag=%b | Valid=%b | Block=%h",

    $time,

    DUT.FSM.state,

    cpu_address,

    DUT.tag,
    DUT.index,
    DUT.offset,

    cpu_data,

    hit,
    miss,
    ready,

    memory_read_enable,
    cache_write_enable,

    DUT.cache_tag,
    DUT.cache_valid,

    DUT.block_data
    );
end

// Test Sequence
initial
begin

    reset = 1;
    cpu_read = 0;
    cpu_address = 0;

    #20;
    reset = 0;

    #20;

    // TEST-1
    $display("\nTEST-1 : ADDRESS = 20 (MISS)");
    cpu_address = 8'd20;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    // TEST-2
    $display("\nTEST-2 : ADDRESS = 21 (HIT)");
    cpu_address = 8'd21;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    // TEST-3
    $display("\nTEST-3 : ADDRESS = 20 AGAIN (HIT)");
    cpu_address = 8'd20;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    // TEST-4
    $display("\nTEST-4 : ADDRESS = 100 (MISS)");
    cpu_address = 8'd100;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    // TEST-5
    $display("\nTEST-5 : ADDRESS = 100 AGAIN (HIT)");
    cpu_address = 8'd100;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    // TEST-6
    $display("\nTEST-6 : ADDRESS = 20 AGAIN (MISS)");
    cpu_address = 8'd20;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    // TEST-7
    $display("\nTEST-7 : FILL CACHE");

    cpu_address = 8'd0;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    cpu_address = 8'd2;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    cpu_address = 8'd6;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    // TEST-8
    $display("\nTEST-8 : ADDRESS = 32 (REPLACEMENT)");
    cpu_address = 8'd32;
    cpu_read = 1;
    #10;
    cpu_read = 0;
    #60;

    #80;
    $finish;

end

endmodule
