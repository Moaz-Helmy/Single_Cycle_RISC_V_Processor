
module RISC_V_Processor (
	input clk,areset
);
/*ALU Ports*/
    wire [31:0]SrcA;
    reg [31:0]SrcB;
    wire [2:0]ALUControl;
    wire [31:0]ALUResult;
    wire ZF,SF;

/*PC Ports*/
    wire PCSrc;
    wire load;

    wire [31:0]ImmExt;
    wire [31:0]PC;

/*Instruction Memory Ports*/
    wire [31:0]Instr;

/*Register file Ports*/
    wire RegWrite;
    reg [31:0]Result;
 

/*Data Memory Ports*/
    wire MemWrite;
    wire [31:0]WriteData;
    wire [31:0]ReadData;

/*Sign extend Ports*/
    wire [1:0]ImmSrc;

/*Control Unit*/
    wire ALUSrc;
    wire ResultSrc;

/***********Adjusting and Connecting the signals of the modules together*************/

/*
 * 1- Instantiation
 */

 /*ALU*/
 ALU ALU_ins(.SrcA(SrcA),.SrcB(SrcB),.ALUControl(ALUControl),.ALUResult(ALUResult),.ZF(ZF),.SF(SF));

 /*Program Counter*/
 Program_Counter PC_ins(.clk(clk),.PCSrc(PCSrc),.load(load),.areset(areset),.ImmExt(ImmExt),.PC(PC));

 /*Instruction Memory*/
 Instruction_Memory InstructionMemory_ins(.PC(PC),.Instr(Instr));

 /*Register File*/
 Register_File RegisterFile_ins(.clk(clk),.RegWrite(RegWrite),.A1(Instr[19:15]),.A2(Instr[24:20]),.A3(Instr[11:7]),.WD3(Result),.RD1(SrcA),.RD2(WriteData));

 /*Data Memory*/
 Data_Memory DataMemory_ins(.clk(clk),.MemWrite(MemWrite),.ALUResult(ALUResult),.WriteData(WriteData),.ReadData(ReadData));

/*Sign Extend*/
Sign_Extend SignExtend_ins(.Instr(Instr[31:7]),.ImmSrc(ImmSrc),.ImmExt(ImmExt));

/*Control Unit*/
Control_Unit ControlUnit_ins(.ZF(ZF),.SF(SF),.Instr(Instr),.PCSrc(PCSrc),.load(load),.areset(areset),.ALUSrc(ALUSrc),.ALUControl(ALUControl),.ResultSrc(ResultSrc),.MemWrite(MemWrite),.ImmSrc(ImmSrc),.RegWrite(RegWrite));


/*
 * 2- Some additional logic
 */

 /*The Result signal that stores either the ALUResult or the ReadData from the data memory; based on the ResultSrc signal from the CU.*/
 always @(*) begin
    if(ResultSrc==1)
    Result=ReadData;
    else
    Result=ALUResult;
 end

 /*The SrcB signal, which is the second operand of the ALU. It could be from the sign extend or from RD2 of the register file directly based on ALUSrc signal from the CU*/
always @(*) begin
    if(ALUSrc==0)
    SrcB=WriteData; /*WriteData signal is connected to RD2. Refer to the instantiatiion step.*/
    else
    SrcB=ImmExt;

end
endmodule