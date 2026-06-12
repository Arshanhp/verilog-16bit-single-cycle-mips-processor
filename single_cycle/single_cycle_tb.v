`timescale 1ns/1ps



module processor_tb;

    // Clock and reset
    reg clk;
    reg rst;

    // Instantiate processor
   processor DUT (
        .clk(clk),
        .rst(rst)
    );


    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset sequence
    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    // Program loading and monitoring
    initial begin

        // Optional: load instruction memory
       // $readmemh("program.hex", DUT.imem.mem);
        $readmemh("program.hex", DUT.inst_mem.mem);

        // Run simulation
        #1000;

        $display("Simulation finished");
        //$finish;
    end

    // Monitor important signals
    initial begin
        $monitor(
            "Time=%0t PC=%h Instr=%h",
            $time,
            DUT.pc,
            DUT.instruction
        );
    end


initial begin
    #500;

    if (DUT.rf.regs[1] == 16'd10)
        $display("PASS");
    else
        $display("FAIL: r1=%d", DUT.rf.regs[1]);

    $finish;
end

endmodule
