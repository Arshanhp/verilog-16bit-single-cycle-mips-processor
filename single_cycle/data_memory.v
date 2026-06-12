module data_memory (
    input clk, mem_write, 
    input [11:0] addr, 
    input [15:0] write_data, 
    output [15:0] read_data
);
    reg [15:0] mem [0:4095];
    integer i;

    initial begin
        for (i = 0; i < 4096; i = i + 1)
            mem[i] = 16'h0000;
    end

    assign read_data = mem[addr];

    always @(posedge clk) begin
        if (mem_write)
            mem[addr] <= write_data;
    end
endmodule
