
module register_file (
    input clk, rst, reg_write,
    input [2:0]  read_reg,
    input [2:0]  write_reg,
    input [15:0] write_data,
    output [15:0] read_data_acc, 
    output [15:0] read_data_ri   
);
    reg [15:0] regs [0:7];  
    integer i;

    assign read_data_acc = regs[0];
    assign read_data_ri  = regs[read_reg];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1) regs[i] <= 16'b0;
        end else if (reg_write) begin
            regs[write_reg] <= write_data;
        end
    end
endmodule
