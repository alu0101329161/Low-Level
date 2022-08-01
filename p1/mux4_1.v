//objetivo 1     mux 4_1_v
///como usa reg hay q usar bloquees tipo initial y always
///modelado de comporatmiento

module mux4_1(output reg out, input wire a, b, c, d, input wire [1:0] s);

always@(a,b,c,d,s)           // cuandondo cambie alguno de esos ejecuta codigo

begin   
case(s)

2'b00:out = a;              // si lleva mas de una linea hay q usar begin and end
2'b01:out = b;
2'b10:out = c;
2'b11:out = d;
default:out = 1'bX;         // caso inprevisto

endcase
end
endmodule

/// _nbits"_base_valor    notacion
///iverilog mux4_1v:
