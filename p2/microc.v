module microc(input wire clk, reset, s_abs, s_inc, s_inm, we3, wez, input wire [2:0] op, output wire z, output wire [5:0] opcode);
//Microcontrolador sin memoria de datos de un solo ciclo

//Instanciar e interconectar pc, memprog, regfile, alu, sum, biestable Z y mux's
wire [9:0] salida_sumador, salida_mux2, salida_mux1, DIR, DIR_SALTO;
wire [15:0] salida_memprog;
wire [3:0] RA1, RA2, WA3;
wire [7:0] INM, WD3, RD1, RD2, salida_alu;
wire ZALU;

mux2 #(10) mux_pc (DIR_SALTO, salida_sumador,s_abs,salida_mux1);
mux2 #(10) mux_sum (DIR_SALTO, 10'b0000000001, s_inc, salida_mux2);
mux2 #(8)  mux_registro (salida_alu, INM, s_inm, WD3);

registro #(10) registro_ (clk, reset, salida_mux1, DIR);
memprog memprog_ (clk, DIR, salida_memprog);
regfile regfile_ (clk, we3, RA1, RA2, WA3, WD3, RD1, RD2);
alu alu_ (RD1, RD2, op, salida_alu, ZALU);
sum sum_ (DIR, salida_mux2, salida_sumador);
ffd ffz (clk, reset, ZALU, wez, z);

assign opcode = salida_memprog[15:10];
assign DIR_SALTO = salida_memprog[9:0];
assign INM = salida_memprog[11:4];
assign RA1 = salida_memprog[11:8];
assign RA2 = salida_memprog[7:4];
assign WA3 = salida_memprog[3:0];

endmodule