module test_brent;
      reg [15:0]a;
      reg [15:0] b;
      reg cin=0;
     wire [15:0] sum;
     wire carry_out;

brentkung dut ( a,b,cin,sum ,carry_out);

      integer    seed,i,j;
initial
begin
      for (i=0; i<8; i=i+1)
        begin
           a=$urandom; 
           b=$urandom;
           $monitor ( " At time %d, A is %d , B is %d,cin is %d,sum is %d,carryout is %d",$time,a,b,cin,sum,carry_out);
           #5 cin=~cin;
        end 
   end
initial
#70 $finish;
endmodule