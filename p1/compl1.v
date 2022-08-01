//objetivo 3
//hacer asignacion continua en una sola linea con un operador ternario
///entrada 4 bit y salida 4 bits y señal de control cpl si cpl=sal si cpl = 0
//Si cpl = 1, Sal = Cpl1(Ent) y si no, Sal =Ent.

module compl1(output wire [3:0] Sal, input wire [3:0] Ent, input wire cpl);

assign Sal = cpl ? ~Ent : Ent;

endmodule
