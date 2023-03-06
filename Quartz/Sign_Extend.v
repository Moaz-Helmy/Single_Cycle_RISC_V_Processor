module Sign_Extend (
    /*The complete instruction*/
    input [31:7]Instr,

    /*Control signal*/
    input [1:0]ImmSrc,

    /*Extended result*/
    output reg [31:0]ImmExt 
);
    always @(*) begin
        case (ImmSrc)
            /*I-Type*/
            2'b00:ImmExt={{20{Instr[31]}},Instr[31:20]};
            /*R-Type*/
            2'b01:ImmExt={{20{Instr[31]}},Instr[31:25],Instr[11:7]};
            /*B-Type*/
            2'b10:ImmExt={{20{Instr[31]}},Instr[7],Instr[30:25],Instr[11:8],1'b0}; 
            default: ImmExt=0;
        endcase
    end
endmodule