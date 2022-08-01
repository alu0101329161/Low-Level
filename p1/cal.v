//objetivo 2.3
//cal.v
//coger celda logica y full adder 

module cal(output wire out, c_out, input wire a, b, l, c_in, input wire [1:0] s); ///cuando l =1 salida celda ///l=0 salida suma del full adder

wire out_cl, out_fa;

fa fa1(c_out, out_fa, a, b, c_in);
cl cl1(out_cl, a, b, s);

mux2_1 mux2(out, out_fa, out_cl, l);
//elige el tipo de operacion que sale
endmodule
