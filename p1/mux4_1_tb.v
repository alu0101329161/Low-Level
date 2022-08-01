// Testbench para modulo de multiplexor module mux4_1(output reg out, input wire a, b, c, d, input wire [1:0] s);
`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulación y el paso de simulación

module mux4_1_tb;
//declaracion de señales
wire test_out;
reg test_a, test_b, test_c, test_d; 
reg [1:0] test_s;

mux4_1 mux1(test_out, test_a, test_b, test_c, test_d, test_s);

initial
begin
  $monitor("tiempo=%0d a=%b b=%b c=%b d=%b s=%b out=%b", $time, test_a, test_b,test_c, test_d,test_s, test_out );
  $dumpfile("mux4_1_tb.vcd");
  $dumpvars;

 test_s = 2'b00;
 test_a = 1'b0;
 #20;

 test_s = 2'b00;
 test_a = 1'b1;
 #20;

 test_s = 2'b01;
 test_b = 1'b0;
 #20;

 test_s = 2'b01;
 test_b = 1'b1;
 #20;

 test_s = 2'b10;
 test_c = 1'b0;
 #20;

 test_s = 2'b10;
 test_c = 1'b1;
 #20;

 test_s = 2'b11;
 test_d = 1'b0;
 #20;

 test_s = 2'b11;
 test_d = 1'b1;
 #20;

 $finish;

end
endmodule