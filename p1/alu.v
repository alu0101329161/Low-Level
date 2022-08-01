// compilar :iverilog -o prueba alu_tb.v alu.v cal.v cl.v compl1.v full-adder.v mux2_4.v mux2_1.v mux4_1.v

module alu(output wire [3:0] R, output wire zero, carry, sign, input wire [3:0] A, B, input wire [1:0]ALUOp, input wire L);

wire op1_A, op2_B, cpl, cin;
wire [3:0] cout;
wire [3:0] OP1, OP2;
wire [3:0] wire_compl1;

mux2_4 mux_Alu1 (OP1, 4'b0000, A, op1_A);   //Asigno OP1
mux2_4 mux_Alu2 (wire_compl1, A, B, op2_B); //Asigno OP2
compl1 compl1_alu (OP2, wire_compl1, cpl); //Asigno COMPLEMENTARIO OP2

cal cal0 (R[0], cout[0], OP1[0], OP2[0], L, cin, ALUOp);    //dejo el cout
cal cal1 (R[1], cout[1], OP1[1], OP2[1], L, cout[0], ALUOp);//al siguiente
cal cal2 (R[2], cout[2], OP1[2], OP2[2], L, cout[1], ALUOp);
cal cal3 (R[3], cout[3], OP1[3], OP2[3], L, cout[2], ALUOp);

//tabla de verdad
assign op1_A =  (ALUOp[1]) | (L);
assign op2_B = (~ALUOp[0]) | (ALUOp[1]) | (L);
assign cpl = (~L & ~ALUOp[1]) | (~L & ~ALUOp[0]);
assign cin = (~ALUOp[1]) | (~ALUOp[0]);

assign sign  = R[3];
assign carry = cout[3];
assign zero  = (~(R[0] | R[1] | R[2] | R[3]));

endmodule
