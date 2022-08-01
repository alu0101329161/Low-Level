//objetivo 2.2
///hacer un full adder
 
module fa(output wire cout, sum, input wire a, b, cin);

assign{cout,sum} = a + b + cin;

endmodule
