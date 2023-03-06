module Register_File (
    /*
     * RegWrite-> control signal to enable the write.
     */
    input clk,RegWrite,

    /*
     * A1-> Address of register that will be available on RD1 (Read Port 1)
     * A2-> Address of register that will be available on RD2 (Read Port 2)
     * A3-> Address of register that will be written at by WD3 (Wirte port)
     */
    input [4:0]A1,
    input [4:0]A2,
    input [4:0]A3,

    /*
     * WD3-> Write port
     * RD -> Read port
     */
    input [31:0]WD3,
    output reg [31:0]RD1,
    output reg [31:0]RD2
);

/*Create 32 register, each one is 32-bit wide*/
    reg [31:0]RegFile[0:31];

    /*Counter used in for loop to reset all registers to zero*/
    integer i;

    /*Reset all registers to zero*/
	initial
	begin
	for(i=0;i<32;i=i+1)
		RegFile[i]=0;	
	end 	

    /*Read asynchronously and write synchronously*/
    always @(posedge clk or A1 or A2) begin

        /*Only write when RegWrite is high; it's controlled by the control unit*/
        if(RegWrite)
        RegFile[A3]<=WD3;
	
    /*Read data at addresses A1 and A2 to RD1 and RD2 ports respectively*/
	RD1<=RegFile[A1];
    RD2<=RegFile[A2];
    end

endmodule