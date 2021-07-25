module ripplecarry ( a,b,cin,sum ,carry_out);

input [15:0] a,b;
input cin;
output carry_out;

output [15:0] sum;
	
wire [16:0] c;
assign c[0]=cin;
genvar i;



generate
for (i=0;i<=15;i=i+1)
begin :jeevan
fulladder f1(sum[i] , c[i+1] , a[i],b[i],c[i]);
end
endgenerate

assign carry_out = c[16];


























endmodule 