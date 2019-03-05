`timescale 1ns/1ps
module tb();    
    reg clk, reset, a;
    wire x, y;

    //`ifdef PR
    //    chip inst_chip(.clk(clk), .reset(reset), .a(a), .x(x), .y(y));
    //`else
        top inst_top(.clk(clk), .reset(reset), .a(a), .x(x), .y(y));
    //`endif

    always @ (posedge clk) begin
	$display("reset = %b, a = %b, x = %b, y = %b", reset, a, x, y);
    end

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1'b1;
        #10;
        reset = 1'b0;
    end

    initial begin
        a = 1'b0;
        forever #100 a = ~a;
    end

    initial begin
        $vcdplusfile(`DUMP_FILE);
        $vcdpluson(0, tb);
        #1000;
        $finish(2);
    end

endmodule
