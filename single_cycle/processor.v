module processor (
    input clk,
    input rst
);
    reg [11:0] pc;
    wire [11:0] next_pc, pc_plus_1, branch_pc;
    wire [15:0] instruction, read_data_acc, read_data_ri, alu_in1, alu_in2, alu_out, mem_data, write_back_data;
    wire reg_write, mem_write, mem_to_reg, alu_src, jump, branch, is_mov_to, not_op, is_logical;
    wire [2:0] alu_op;
    wire [2:0] write_reg_sel;
    wire [15:0] imm_ext;

    always @(posedge clk or posedge rst) begin
        if (rst) pc <= 12'b0;
        else     pc <= next_pc;
    end

    assign pc_plus_1 = pc + 12'd1;

    instruction_memory inst_mem (
        .addr(pc),
        .instr(instruction)
    );

    control_unit cu (
        .opcode(instruction[15:12]),
        .func(instruction[8:0]),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .jump(jump),
        .branch(branch),
        .is_mov_to(is_mov_to),
        .not_op(not_op),
        .is_logical(is_logical),
        .alu_op(alu_op)
    );

    assign write_reg_sel = is_mov_to ? instruction[11:9] : 3'b000;

    register_file rf (
        .clk(clk),
        .rst(rst),
        .reg_write(reg_write),
        .read_reg(instruction[11:9]),
        .write_reg(write_reg_sel),
        .write_data(write_back_data),
        .read_data_acc(read_data_acc),
        .read_data_ri(read_data_ri)
    );

    assign alu_in1 = not_op ? read_data_ri : read_data_acc;
    assign imm_ext = is_logical ? {4'b0000, instruction[11:0]} :
                                  {{4{instruction[11]}}, instruction[11:0]};
    assign alu_in2 = alu_src ? imm_ext : read_data_ri;

    alu main_alu (
        .in1(alu_in1),
        .in2(alu_in2),
        .op(alu_op),
        .out(alu_out)
    );

    data_memory dmem (
        .clk(clk),
        .mem_write(mem_write),
        .addr(instruction[11:0]),
        .write_data(read_data_acc),
        .read_data(mem_data)
    );

    assign write_back_data = mem_to_reg ? mem_data :
                             is_mov_to  ? read_data_acc :
                                          alu_out;

    assign branch_pc = {pc[11:9], instruction[8:0]};

    assign next_pc = jump ? instruction[11:0] :
                     (branch && (read_data_acc == read_data_ri)) ? branch_pc :
                     pc_plus_1;

endmodule
