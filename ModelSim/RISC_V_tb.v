`timescale 1 ns/10 ps
module RISC_V_tb();

reg clk,areset;
integer i;

RISC_V_Processor RV(.clk(clk),.areset(areset));

/*Geenerate the clock*/
always
begin
#10; clk=~clk;
end

/*Display the content of the instruction memory*/
initial
begin
for(i=0;i<21;i=i+1)
	$display("%h",RV.InstructionMemory_ins.InsMem[i]);

clk=0;

/*Give a reset pulse to reset the program counter to zero at first*/
areset=0;
#5;
areset=1;
#2000;

$stop;
end
endmodule
