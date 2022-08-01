// iverilog -o prueba microc_tb.v microc.v memprog.v alu.v componentes.v
// ./prueba
//  gtkwave micro_tb.vcd
// Testbench para modulo de multiplexor module mux4_1(output reg out, input wire a, b, c, d, input wire [1:0] s);
`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulación y el paso de simulación iverilog -o prueba

module microc_tb;
//declaracion de señales
reg test_clk, test_reset, test_abs, test_inc, test_inm, test_we3, test_wez;
reg [2:0] test_op;
wire [5:0] test_opcode;
wire test_z;

microc microc1(test_clk, test_reset, test_abs, test_inc, test_inm, test_we3, test_wez, test_op, test_z, test_opcode);

// Reset peque;o
initial
begin
    test_reset=1'b1;
    #10;
    test_reset=1'b0;
end
// CLK
always
begin
    test_clk=1'b1;
    #20;
    test_clk=1'b0;
    #20;
end

initial
begin
$dumpfile("micro_tb.vcd"); //archivo para GTKWAVE
$dumpvars;
#900;  //20 ciclos
$finish;
end

always @(negedge test_clk)
begin
       case (test_opcode)
       //li perfect
       6'b001000:
       begin
           test_inm=1'b1;
           test_abs=1'b1; 
           test_inc=1'b1;
           test_we3=1'b1;
           test_wez=1'b0;  
           test_op=3'b000;
       end
       // add perfect
       6'b010000:
       begin
           test_inm=1'b0;
           test_abs=1'b1; 
           test_inc=1'b1;
           test_we3=1'b1;
           test_wez=1'b1;  
           test_op=3'b010;
       end
       // sub perfect
       6'b001100:
       begin
           test_inm=1'b0;
           test_abs=1'b1; 
           test_inc=1'b1;
           test_we3=1'b1;
           test_wez=1'b1;  
           test_op=3'b011;  
       end
        // or perfect
       6'b011100:
       begin
           test_inm=1'b0;
           test_abs=1'b1; 
           test_inc=1'b1;
           test_we3=1'b1;
           test_wez=1'b1;  
           test_op=3'b101;  
       end

       //beqz perfecto
        6'b000010:
       begin
           if (test_z == 0) 
           begin
           test_inm=1'b0;
           test_abs=1'b1; //cuidado
           test_inc=1'b1;
           test_we3=1'b0;
           test_wez=1'b0;  //wez solo vale uno en operaciones aritmetico logicas
           test_op=3'b000;
           end 
           else
           begin
           test_inm=1'b0;
           test_abs=1'b0; 
           test_inc=1'b0;
           test_we3=1'b0; 
           test_wez=1'b0;  //wez solo vale uno en operaciones aritmetico logicas
           test_op=3'b000; 
           end
       end
       //j ABSOLUTO
       6'b000011:
       begin
           test_inm=1'b0;
           test_abs=1'b0;                           
           test_inc=1'b0;
           test_we3=1'b0;
           test_wez=1'b0;                      
           test_op=3'b000;   
       end
       //b RELATIVO
       6'b000111:
       begin
           test_inm=1'b0;
           test_abs=1'b1;                          //cuidado
           test_inc=1'b0;
           test_we3=1'b0;
           test_wez=1'b0;                           //wez solo vale uno en operaciones aritmetico logicas
           test_op=3'b000;   
       end

       endcase
end
endmodule