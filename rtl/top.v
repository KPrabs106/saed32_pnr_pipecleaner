/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in topographical mode
// Version   : L-2016.03-SP5-5
// Date      : Sat Feb 23 23:34:28 2019
/////////////////////////////////////////////////////////////


module top ( clk, reset, a, x, y );
  input clk, reset, a;
  output x, y;
  wire   n1, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25;
  wire   [2:0] state;
  wire   [2:0] nextstate;

  DFFARX1_HVT state_reg_0_ ( .D(nextstate[0]), .CLK(clk), .RSTB(n1), .Q(
        state[0]), .QN(n23) );
  DFFARX1_HVT state_reg_2_ ( .D(nextstate[2]), .CLK(clk), .RSTB(n1), .Q(
        state[2]), .QN(n25) );
  DFFARX1_HVT state_reg_1_ ( .D(nextstate[1]), .CLK(clk), .RSTB(n1), .Q(
        state[1]), .QN(n24) );
  INVX1_HVT U21 ( .A(reset), .Y(n1) );
  NAND4X0_HVT U22 ( .A1(a), .A2(state[2]), .A3(n23), .A4(n24), .Y(n21) );
  INVX1_HVT U23 ( .A(a), .Y(n16) );
  NAND4X0_HVT U24 ( .A1(state[1]), .A2(n16), .A3(n23), .A4(n25), .Y(n14) );
  NAND2X0_HVT U25 ( .A1(n21), .A2(n14), .Y(y) );
  OA221X1_HVT U26 ( .A1(state[1]), .A2(n16), .A3(n24), .A4(a), .A5(n25), .Y(
        n15) );
  AO21X1_HVT U27 ( .A1(state[0]), .A2(n15), .A3(y), .Y(x) );
  NAND3X0_HVT U28 ( .A1(n16), .A2(n24), .A3(n23), .Y(n19) );
  NAND2X0_HVT U29 ( .A1(state[1]), .A2(state[0]), .Y(n18) );
  INVX1_HVT U30 ( .A(n18), .Y(n20) );
  AO221X1_HVT U31 ( .A1(a), .A2(n20), .A3(n16), .A4(n18), .A5(state[2]), .Y(
        n17) );
  NAND2X0_HVT U32 ( .A1(n19), .A2(n17), .Y(nextstate[0]) );
  AND3X1_HVT U33 ( .A1(n19), .A2(n25), .A3(n18), .Y(nextstate[1]) );
  NAND3X0_HVT U34 ( .A1(a), .A2(n20), .A3(n25), .Y(n22) );
  NAND2X0_HVT U35 ( .A1(n22), .A2(n21), .Y(nextstate[2]) );
endmodule

