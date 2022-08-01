//objetivo 2 hacer celda lógica
///modelado estructural
///usar primitivas y declaracion de variables para cables que se conecten

module cl(output wire out, input wire a, b, input wire [1:0] s);

wire sa; //salida de la and
wire so;
wire sx;
wire sn;

and and1(sa,a,b); //primeri salida y despues entradas
or or1(so,a,b);
xor xor1(sx,a,b);
not not1(sn,a);

mux4_1 mux1(out,sa,so,sx,sn,s);

endmodule
//iverilog cl.v mux4_1.v (para compilar)
