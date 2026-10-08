 `timescale 1ns / 1ps

module fsm_controller(
    input clk,
    input reset,
    input cpu_read,
    input hit,
    input miss,
    output reg cache_read_enable,
    output reg cache_write_enable,
    output reg memory_read_enable,
    output reg ready,
    output reg [2:0] state
);

parameter IDLE         = 3'b000;
parameter COMPARE_TAG  = 3'b001;
parameter CACHE_READ   = 3'b010;
parameter MEMORY_READ  = 3'b011;
parameter CACHE_UPDATE = 3'b100;
parameter DATA_RETURN  = 3'b101;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= IDLE;
    end
    else
    begin
        case(state)
        IDLE:
        begin
            if(cpu_read)
                state <= COMPARE_TAG;
            else
                state <= IDLE;
        end
        
        COMPARE_TAG:
        begin
            if(hit)
                state <= CACHE_READ;
            else if(miss)
                state <= MEMORY_READ;
        end

        CACHE_READ:
        begin
            state <= DATA_RETURN;
            
        end
        
        MEMORY_READ:
        begin
            state <= CACHE_UPDATE;
        end
        
        CACHE_UPDATE:
        begin
            state <= DATA_RETURN;
        end
        
        DATA_RETURN:
        begin
            state <= IDLE;
        end
        default:
            state <= IDLE;
        endcase
    end
end

always @(*)
begin

    cache_read_enable  = 0;
    cache_write_enable = 0;
    memory_read_enable = 0;
    ready              = 0;

    case(state)

    IDLE:
    begin
   end
 
    COMPARE_TAG:
    begin
    end

    CACHE_READ:
    begin
        cache_read_enable = 1;
          ready=1;
    end
    
    MEMORY_READ:
    begin
        memory_read_enable = 1;
        ready=1;
    end

    CACHE_UPDATE:
    begin
            
        cache_write_enable = 1;
            
    end
    
    DATA_RETURN:
    begin
        
    end
    endcase
end
endmodule