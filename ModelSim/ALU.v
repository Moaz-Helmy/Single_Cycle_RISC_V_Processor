
module ALU (
    /*Operands*/
    input [31:0]SrcA,
    input [31:0]SrcB,

    /*Control Signal to select the desired operation*/
    input [2:0] ALUControl,

    /*Result of the operation*/
    output reg [31:0] ALUResult,

    /*Zero flag and Sign flag to specify if the result is zero or not, and whether it's positive or negative.*/
    output reg ZF,SF
);


always @(*) begin

    /*Case Statement to select the operation to be done on the operands, based on the ALUControl signal*/
    case (ALUControl)
    3'b000: ALUResult=SrcA+SrcB;
    3'b001: ALUResult=SrcA<<SrcB;
    3'b010: ALUResult=SrcA-SrcB;
    3'b100: ALUResult=SrcA^SrcB;
    3'b101: ALUResult=SrcA>>SrcB;
    3'b110: ALUResult=SrcA|SrcB;
    3'b111: ALUResult=SrcA&SrcB;

    default: ALUResult=0;
    endcase
    /*Set or clear the flags based on the result*/
    if(ALUResult==0)
    begin
        ZF=1;
    end
    else
    begin
        ZF=0;
    end

    /*The sign flag is the MSB of the result*/
    SF=ALUResult[31];
    
end
    
endmodule