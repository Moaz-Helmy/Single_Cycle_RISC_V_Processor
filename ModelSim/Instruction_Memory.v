module Instruction_Memory (
    /*The address of the esired instruction to be read*/
    input [31:0]PC,

    /*The output instruction*/
    output reg [31:0] Instr
);

/*Create the memory that has 64 entries, 32-bit each.*/
    reg [31:0]InsMem[0:63];

/*loading test program into the instruction memory*/
    initial
	$readmemh("program.txt",InsMem,0,20);

    always @(*) begin
        /*Assign the instruction at the address PC*4 to the output Instr bus*/
        /*Note that, the address is PC*4 because the instruction is 4 bytes, thus the address is incremented by 4 each step*/
        Instr=InsMem[PC/4];
    end
endmodule