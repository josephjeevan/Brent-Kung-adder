module brentkung ( a,b,cin,sum ,carry_out);

input [15:0] a,b;
input cin;
output carry_out;

output [15:0] sum;
	
wire [16:0] c;
assign c[0]=cin;

wire [15:0] first_order_p,first_order_g ;
wire [7:0] second_order_p,second_order_g;
wire [3:0] third_order_p,third_order_g;
wire [1:0] forth_order_p,forth_order_g;
wire  [0:0] fifth_order_p,fifth_order_g;
genvar i;

//first order
generate
for (i=0;i<=15;i=i+1)
begin :jeevan
xor_module x1(first_order_p[i],a[i],b[i]);
and_module a1( first_order_g[i],a[i],b[i]);
end
endgenerate

////second order

generate 
for (i=0;i<=7;i=i+1)
begin :jeevan1
aplusbc_module ap2(second_order_g[i],first_order_g[2*i+1],first_order_p[2*i+1],first_order_g[2*i]);
and_module a2 (second_order_p[i],first_order_p[2*i+1],first_order_p[2*i]);
end
endgenerate

//third order

generate 
for (i=0;i<=3;i=i+1)
begin :jeevan2
 assign third_order_g[i] = second_order_g[2*i+1] | (second_order_p[2*i+1]&second_order_g[2*i]);
//aplusbc_module q11(third_order_g[i],second_order_g[2*i+1],second_order_p[2*i+1],second_order_g[2*i]);
and_module a3(third_order_p[i],second_order_p[2*i+1],second_order_p[2*i]);
end
endgenerate

//forth order

generate 
for (i=0;i<=1;i=i+1)
begin :jeevan3
aplusbc_module ap4(forth_order_g[i],third_order_g[2*i+1],third_order_p[2*i+1],third_order_g[2*i]);
and_module a4(forth_order_p[i],third_order_p[2*i+1],third_order_p[2*i]);
end
endgenerate


//fifth order

generate 
for (i=0;i<=0;i=i+1)
begin :jeevan4
aplusbc_module ap5(fifth_order_g[i],forth_order_g[2*i+1],forth_order_p[2*i+1],forth_order_g[2*i]);
and_module a5(fifth_order_p[i],forth_order_p[2*i+1],forth_order_p[2*i]);
end
endgenerate


//first_order_ c calculations

assign c[1]=first_order_g[0] | ( first_order_p[0] & c[0] );
assign c[2]=second_order_g[0] | ( second_order_p[0] & c[0] );
assign c[4]=third_order_g[0] | ( third_order_p[0] & c[0] );
assign c[8]=forth_order_g[0] | ( forth_order_p[0] & c[0] );
assign c[16]=fifth_order_g[0] | ( fifth_order_p[0] & c[0] );

//second order c calculations

assign c[3]=first_order_g[2] | ( first_order_p[2] & c[2] );
assign c[5]=first_order_g[4] | ( first_order_p[4] & c[4] );
assign c[9]=first_order_g[8] | ( first_order_p[8] & c[8] );
assign c[6]=second_order_g[2] | ( second_order_p[2] & c[4] );
assign c[10]=second_order_g[4] | ( second_order_p[4] & c[8] );
assign c[12]=third_order_g[2] | ( third_order_p[2] & c[8] );

//third order c calculations

assign c[7]=first_order_g[6] | ( first_order_p[6] & c[6] );
assign c[11]=first_order_g[10] | ( first_order_p[10] & c[10] );
assign c[13]=first_order_g[12] | ( first_order_p[12] & c[12] );
assign c[14]=second_order_g[6] | ( second_order_p[6] & c[12] );

// final order c calculations

assign c[15]=first_order_g[14] | ( first_order_p[14] & c[14] );


generate
for (i=0;i<=15;i=i+1)
begin :jeevan5
xor_module x2(sum[i],first_order_p[i],c[i]);
end
endgenerate



assign carry_out = c[16];





























endmodule
