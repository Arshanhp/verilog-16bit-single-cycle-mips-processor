
module alu (
    input  [15:0] in1,
    input  [15:0] in2,
    input  [2:0]  op,
    output reg [15:0] out
);
    always @(*) begin
        case (op)
            3'b000: out = in1 + in2;    // Add
            3'b001: out = in1 - in2;    // Sub
            3'b010: out = in1 & in2;    // And
            3'b011: out = in1 | in2;    // Or
            3'b100: out = ~in1;         // Not
            3'b101: out = in1;          // In1
            3'b110: out = in2;          // In2
            default: out = 16'b0;
        endcase
    end
endmodule
