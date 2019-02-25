module chip (clk, reset, a, x, y);
    input clk, reset, a;
    output x, y;

    wire clk_int, reset_int, a_int;
    wire x_int, y_int;

    top main_block(.clk(clk_int), .reset(reset_int), .a(a_int), .x(x_int), .y(y_int));

    // left
    I1025_EW pad_clk(.R_EN(1'b1), .PADIO(clk), .DOUT(clk_int));
    I1025_EW pad_reset(.R_EN(1'b1), .PADIO(reset), .DOUT(reset_int));
    I1025_EW pad_a(.R_EN(1'b1), .PADIO(a), .DOUT(a_int));

    // right
    D12I1025_EW pad_x(.DIN(x_int), .EN(1'b1), .PADIO(x));
    D12I1025_EW pad_y(.DIN(y_int), .EN(1'b1), .PADIO(y));
endmodule
