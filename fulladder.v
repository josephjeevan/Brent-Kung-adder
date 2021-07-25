module fulladder(sum,carry_out,a,b,c);

input a,b,c;
output sum,carry_out;

assign sum=a ^ b ^ c ;
assign carry_out = ( a & b ) | ( b & c ) | ( c & a );
































endmodule 