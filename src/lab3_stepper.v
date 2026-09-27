`timescale 1ns/1ps

module lab3_stepper #(
    parameter integer CLK_HZ = 50_000_000,
    parameter integer STEP_HZ = 100
) (
    input  wire       clk_50mhz,
    input  wire       rst_p,
    input  wire       enable,
    input  wire       direction,
    output reg  [3:0] stepmotor
);

    localparam integer STEP_CYCLES = CLK_HZ / STEP_HZ;
    localparam integer COUNT_WIDTH = (STEP_CYCLES < 2) ? 1 : $clog2(STEP_CYCLES);

    reg [COUNT_WIDTH-1:0] count;
    reg [1:0] state;

    (* ASYNC_REG = "TRUE" *) reg enable_meta, enable_sync;
    (* ASYNC_REG = "TRUE" *) reg direction_meta, direction_sync;

    always @(posedge clk_50mhz or posedge rst_p) begin
        if (rst_p) begin
            enable_meta    <= 0;
            enable_sync    <= 0;
            direction_meta <= 0;
            direction_sync <= 0;
        end else begin
            enable_meta    <= enable;
            enable_sync    <= enable_meta;
            direction_meta <= direction;
            direction_sync <= direction_meta;
        end
    end

    always @(posedge clk_50mhz or posedge rst_p) begin
        if (rst_p) begin
            count <= 0;
            state <= 0;
        end else if (!enable_sync) begin
            count <= 0;
        end else if (count == STEP_CYCLES - 1) begin
            count <= 0;
            state <= direction_sync ? state - 1'b1 : state + 1'b1;
        end else begin
            count <= count + 1'b1;
        end
    end

    always @* begin
        case (state)
            2'd0:    stepmotor = 4'b0011;
            2'd1:    stepmotor = 4'b0110;
            2'd2:    stepmotor = 4'b1100;
            default: stepmotor = 4'b1001;
        endcase
    end

endmodule
