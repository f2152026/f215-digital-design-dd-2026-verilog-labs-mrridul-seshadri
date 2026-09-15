//testbench for the comparator in task3

module tb;

reg [1:0] A;
reg [1:0] B;

wire GT;
wire LT;
wire EQ;

comp2 DUT(
    .A(A),
    .B(B),
    .GT(GT),
    .LT(LT),
    .EQ(EQ)
);

string vcd_file;
 initial begin
   if ($value$plusargs("vcd=%s", vcd_file)) begin
     $dumpfile(vcd_file);
     $dumpvars(0, DUT);
   end
 end

initial begin
    A = 2'b00; B = 2'b00; #5;
    A = 2'b00; B = 2'b01; #5;
    A = 2'b00; B = 2'b10; #5;
    A = 2'b00; B = 2'b11; #5;
    A = 2'b01; B = 2'b00; #5;
    A = 2'b01; B = 2'b01; #5;
    A = 2'b01; B = 2'b10; #5;
    A = 2'b01; B = 2'b11; #5;
    A = 2'b10; B = 2'b00; #5;
    A = 2'b10; B = 2'b01; #5;
    A = 2'b10; B = 2'b10; #5;
    A = 2'b10; B = 2'b11; #5;
    A = 2'b11; B = 2'b00; #5;
    A = 2'b11; B = 2'b01; #5;
    A = 2'b11; B = 2'b10; #5;
    A = 2'b11; B = 2'b11; #5;

end

initial begin
    $monitor($time, " A=%b B=%b | GT=%b LT=%b EQ=%b ", A,B,GT,LT,EQ);
end

endmodule