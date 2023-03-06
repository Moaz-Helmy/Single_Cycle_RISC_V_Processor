module Program_Counter (
    /*
     * PCSrc-> Selects the next instruction address. If it's 0, the next address is the successive one in ins. memory. If it's 1 , it means there's a taken branch and the next
     * address is PC+target.
     * load -> loads the PC with data when high.
     * areset-> control signal to set the PC to zero. 
     */
    input clk,PCSrc,load,areset,


    /*
     * This bus is the o/p of the sign extender block. It's used here only in the calculation of the next instruction address, in case of a taken branch.
     */
    input [31:0]ImmExt,

    /*
     * The result address to index the instruction memory.
     */
    output reg [31:0] PC
);
    /*This bus holds the next calculated address. Whether the PCSrc is high or low.*/
    reg [31:0] PCNext;

    /*Sequential block to set the next address to the PC*/
    always @(posedge clk or negedge areset) begin

        /*Asynchronous active-low reset*/
        if(!areset)
        PC<=0;
        else
        begin
            /*Load the next address to the PC when load signal is high*/
            if(load)
            PC<=PCNext;
            else
            PC<=PC;
        end
    end

    /*Combinational block for the next address calculations*/
    always @(*) begin

        /*Select whether the next address is PC+4, or there's a taken branch and the next address should be PC+ImmExt.*/
        /*Note that ImmExt is the output of the sign extender block*/
          case (PCSrc)
            1'b0:PCNext=PC+3'd4;
            1'b1:PCNext=PC+ImmExt;
            default: PCNext=PC+3'd4;
        endcase
    end
endmodule