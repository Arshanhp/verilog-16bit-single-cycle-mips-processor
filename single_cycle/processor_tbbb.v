`timescale 1ns/1ps

module processor_tb;

    reg clk;
    reg rst;

    processor DUT (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #15;
        rst = 0;
    end

    initial begin
        $readmemh("program.hex", DUT.inst_mem.mem);
        #400000;
        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | PC=%h | Inst=%h | ACC=%h | Ri=%h | WAddr=%h | WE=%b | WD=%h | ALUOp=%b | MW=%b | MRD=%h",
            $time,
            DUT.pc,
            DUT.instruction,
            DUT.rf.regs[0],
            DUT.rf.regs[DUT.instruction[11:9]],
            DUT.write_reg_sel,
            DUT.reg_write,
            DUT.write_back_data,
            DUT.alu_op,
            DUT.mem_write,
            DUT.dmem.read_data
        );
    end

    initial begin
        #395000;
        if (DUT.rf.regs[1] == 16'h000A) begin
            $display("\n=================================");
            $display("       TEST RESULT: PASS         ");
            $display("=================================");
            $display("Success: R1 holds expected value 10 (000a).");
        end else begin
            $display("\n=================================");
            $display("       TEST RESULT: FAIL         ");
            $display("=================================");
            $display("Failure: R1 = %h (Expected: 000a)", DUT.rf.regs[1]);
        end

        $display("\n--- Final Register File Contents ---");
        $display("R0 (ACC): %h", DUT.rf.regs[0]);
        $display("R1:       %h", DUT.rf.regs[1]);
        $display("R2:       %h", DUT.rf.regs[2]);
        $display("R3:       %h", DUT.rf.regs[3]);
        $display("R4:       %h", DUT.rf.regs[4]);
        $display("R5:       %h", DUT.rf.regs[5]);
        $display("R6:       %h", DUT.rf.regs[6]);
        $display("R7:       %h", DUT.rf.regs[7]);
    end

endmodule