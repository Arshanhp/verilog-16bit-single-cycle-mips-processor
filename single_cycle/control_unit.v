module control_unit (
    input [3:0] opcode,
    input [8:0] func,
    output reg reg_write, mem_write, mem_to_reg, alu_src, jump, branch,
    output reg is_mov_to, not_op, is_logical,
    output reg [2:0] alu_op
);
    always @(*) begin
        reg_write  = 0;
        mem_write  = 0;
        mem_to_reg = 0;
        alu_src    = 0;
        jump       = 0;
        branch     = 0;
        is_mov_to  = 0;
        not_op     = 0;
        is_logical = 0;
        alu_op     = 3'b101; // pass in1 by default

        case (opcode)
            4'b0000: begin // Load
                reg_write  = 1;
                mem_to_reg = 1;
            end
            4'b0001: begin // Store
                mem_write = 1;
            end
            4'b0010: begin // Jump
                jump = 1;
            end
            4'b0100: begin // BranchZ
                branch = 1;
            end
            4'b1000: begin // Type C
                case (func)
                    9'b000000001: begin // MoveTo
                        reg_write = 1;
                        is_mov_to = 1;
                    end
                    9'b000000010: begin // MoveFrom
                        reg_write = 1;
                        alu_op = 3'b110;
                    end
                    9'b000000100: begin // Add
                        reg_write = 1;
                        alu_op = 3'b000;
                    end
                    9'b000001000: begin // Sub
                        reg_write = 1;
                        alu_op = 3'b001;
                    end
                    9'b000010000: begin // And
                        reg_write = 1;
                        alu_op = 3'b010;
                    end
                    9'b000100000: begin // Or
                        reg_write = 1;
                        alu_op = 3'b011;
                    end
                    9'b001000000: begin // Not
                        reg_write = 1;
                        alu_op = 3'b100;
                        not_op = 1;
                    end
                    9'b010000000: begin // Nop
                    end
                    default: begin
                    end
                endcase
            end
            4'b1100: begin // Addi
                reg_write = 1;
                alu_src = 1;
                alu_op = 3'b000;
            end
            4'b1101: begin // Subi
                reg_write = 1;
                alu_src = 1;
                alu_op = 3'b001;
            end
            4'b1110: begin // Andi
                reg_write = 1;
                alu_src = 1;
                alu_op = 3'b010;
                is_logical = 1;
            end
            4'b1111: begin // Ori
                reg_write = 1;
                alu_src = 1;
                alu_op = 3'b011;
                is_logical = 1;
            end
        endcase
    end
endmodule
