module top( input   wire clk,
                    input   wire reset,
                    input   wire a,
                    output  wire x, y);

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    
    reg [2:0] state;
    reg [2:0] nextstate;

    // State Register
    always @(posedge clk or posedge reset)
        if (reset)  state <= S0;
        else        state <= nextstate;

    // Next State Logic
    always @(*)
        case (state)
            S0: if (a)  nextstate = S3;
                else    nextstate = S1;
            S1: if (a)  nextstate = S3;
                else    nextstate = S2;
            S2: if (a)  nextstate = S3;
                else    nextstate = S2;
            S3: if (a)  nextstate = S4;
                else    nextstate = S1;
            S4: if (a)  nextstate = S4;
                else    nextstate = S1;
            default:    nextstate = S0;
        endcase

    // Output Logic
    assign x =  ((state == S1 | state == S2) & ~a) |
                ((state == S3 | state == S4) & a);
    assign y =  (state == S2 & ~a) | (state == S4 & a);

endmodule 
