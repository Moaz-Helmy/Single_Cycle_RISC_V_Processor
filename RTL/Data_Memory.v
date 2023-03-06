module Data_Memory (
    /*
     * MemWrite-> control signal that controls the write operation.
     */
    input MemWrite,clk,

    /*
     * ALUResult-> used here as the calculated address to determine the location in memory to be read or wriiten at.
     */
    input [31:0]ALUResult,

    /*Write and Read ports*/
    input [31:0]WriteData,
    output reg [31:0]ReadData
);

/*Create memory that has 64 entries; 32-bit wide each*/
    reg [31:0]DataMem[0:63];

/*Write synchronously and read asynchronously*/
    always @(posedge clk) begin
        if(MemWrite)
        DataMem[ALUResult[31:2]]<=WriteData;
    end
    always @(*) begin
        ReadData=DataMem[ALUResult];
    end
endmodule